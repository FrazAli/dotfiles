-- Daily + Weekly templates
local function get_weather()
	-- Fetch weather data from the OpenMeteo API
	local lat = "59.3293" -- Replace with your latitude
	local lon = "18.0686" -- Replace with your longitude
	local url = string.format(
		"https://api.open-meteo.com/v1/forecast?latitude=%s&longitude=%s&daily=weathercode,temperature_2m_max,temperature_2m_min,windspeed_10m_min,windspeed_10m_max,relative_humidity_2m_mean&wind_speed_unit=ms&timezone=auto",
		lat,
		lon
	)

	local handle = io.popen("curl -s '" .. url .. "'")
	if not handle then
		return "🌡️ Temperature: \n💨 Wind: \n🌞 Forecast: \n"
	end
	local result = handle:read("*a")
	handle:close()

	local weather_data = vim.fn.json_decode(result)

	-- Adjust the parsing based on the API response
	if
		not weather_data
		or not weather_data.daily
		or not weather_data.daily.weathercode
		or not weather_data.daily.temperature_2m_max
		or not weather_data.daily.temperature_2m_min
		or not weather_data.daily.windspeed_10m_max
	then
		return "- Wind: \n- Temperature: \n- Forecast: "
	end

	local weather_map = {
		[0] = { description = "Clear sky", icon = "☀️" },
		[1] = { description = "Mainly clear", icon = "🌤️" },
		[2] = { description = "Partly cloudy", icon = "⛅" },
		[3] = { description = "Overcast", icon = "☁️" },
		[45] = { description = "Fog 🌫️", icon = "🌁" },
		[48] = { description = "Depositing rime fog", icon = "🌁" },
		[51] = { description = "Drizzle: 💦 Light intensity", icon = "🌦️" },
		[53] = { description = "Drizzle: 💦 Moderate intensity", icon = "🌦️" },
		[55] = { description = "Drizzle: 💦 Dense intensity", icon = "🌦️" },
		[56] = { description = "Freezing Drizzle: 💦🥶 Light intensity", icon = "🌧️" },
		[57] = { description = "Freezing Drizzle: 💦💦🥶 Dense intensity", icon = "🌧️" },
		[61] = { description = "Rain: 💧 Slight intensity", icon = "🌧️" },
		[63] = { description = "Rain: 💧💧 Moderate intensity", icon = "🌧️" },
		[65] = { description = "Rain: 💧💧💧 Heavy intensity", icon = "🌧️" },
		[66] = { description = "Freezing Rain: 💧🥶 Light intensity", icon = "🌧️" },
		[67] = { description = "Freezing Rain: 💧💧🥶 Heavy intensity", icon = "🌧️" },
		[71] = { description = "Snow fall: ❄️ Slight intensity", icon = "🌨️" },
		[73] = { description = "Snow fall: ❄️❄️ Moderate intensity", icon = "🌨️" },
		[75] = { description = "Snow fall: ❄️❄️❄️ Heavy intensity", icon = "🌨️" },
		[77] = { description = "Snow grains ☃️", icon = "🌨️" },
		[80] = { description = "Rain showers: ☔️ Slight intensity", icon = "🌧️" },
		[81] = { description = "Rain showers: ☔️☔️ Moderate intensity", icon = "🌧️" },
		[82] = { description = "Rain showers: ☔️☔️☔️ Violent intensity", icon = "🌧️" },
		[85] = { description = "Snow showers: ❆ Slight intensity", icon = "🌨️" },
		[86] = { description = "Snow showers: ❆❆ Heavy intensity", icon = "🌨️" },
		[95] = { description = "Thunderstorm: ⚡️ Slight or moderate", icon = "⛈️" },
		[96] = { description = "Thunderstorm with slight hail ⚡️🧊", icon = "⛈️" },
		[99] = { description = "Thunderstorm with heavy hail ⚡️🧊🧊", icon = "⛈️" },
	}

	local code = weather_data.daily.weathercode[1]
	local weather = weather_map[code] or { description = "Unknown", icon = "🧑🏻‍💻" }
	local max_temp = weather_data.daily.temperature_2m_max[1]
	local min_temp = weather_data.daily.temperature_2m_min[1]
	local min_wind = weather_data.daily.windspeed_10m_min[1]
	local max_wind = weather_data.daily.windspeed_10m_max[1]
	local mean_humidity = weather_data.daily.relative_humidity_2m_mean[1]

	local weather_string = string.format(
		"- 🌡️ Temperature: %s°C - %s°C\n"
			.. "- 💨 Wind: %s - %s m/s\n"
			.. "- 🌞 Forecast: %s %s\n"
			.. "- 💧 Humidity\n"
			.. "  - 🌍 Outdoor: %s﹪\n"
			.. "  - 🏠 Indoor RH (AM/PM): #﹪ / #﹪\n",
		min_temp,
		max_temp,
		min_wind,
		max_wind,
		weather.icon,
		weather.description,
		mean_humidity
	)
	return weather_string
end

local function load_template(template_path)
	local file = io.open(template_path, "r")
	if file then
		local content = file:read("*a")
		file:close()
		return content
	end

	return nil
end

local daily_template = function()
	local template_path = vim.fn.expand("./templates/daily.md")
	local template_content = load_template(template_path)

	if not template_content then
		vim.notify(
			"Daily journal template not found at: " .. template_path .. ". Using default.",
			vim.log.levels.WARN,
			{ title = "Journal Plugin" }
		)
		template_content = [[
# %A, %B %d, %Y

## Weather

{{WEATHER}}

## Calendar

## Goals

## Habits

## Health

### Food

#### Breakfast

#### Lunch

#### Dinner

# Notes

## Work

## Personal

]]
	end

	local weather_string = get_weather()
	local final_content = template_content:gsub("{{WEATHER}}", weather_string)
	return final_content
end

local weekly_template = function()
	local template_path = vim.fn.expand("./templates/weekly.md")
	local template_content = load_template(template_path)

	if not template_content then
		vim.notify(
			"Weekly journal template not found at: " .. template_path .. ". Using default.",
			vim.log.levels.WARN,
			{ title = "Journal Plugin" }
		)
		template_content = [[
# Week %W %B %Y — Summary

## Goals

## Habits

## Health

# Notes

]]
	end

	return template_content
end

return {
	"jakobkhansen/journal.nvim",
	config = function()
		require("journal").setup({
			filetype = "md",
			root = "~/journal",
			date_format = "%d/%m/%Y",
			autocomplete_date_modifier = "end",
			journal = {
				format = "%Y/%m-%B/daily/%d-%A",
				template = daily_template,
				frequency = { day = 1 },
				entries = {
					day = {
						format = "%Y/%m-%B/daily/%d-%A",
						template = daily_template,
						frequency = { day = 1 },
					},
					week = {
						format = "%Y/%m-%B/weekly/week-%W",
						template = weekly_template,
						frequency = { day = 7 },
						date_modifier = "monday",
					},
					month = {
						format = "%Y/%m-%B/%B",
						template = "# %B %Y\n",
						frequency = { month = 1 },
					},
					year = {
						format = "%Y/%Y",
						template = "# %Y\n",
						frequency = { year = 1 },
					},
				},
			},
		})
	end,
}
