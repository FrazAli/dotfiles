local M = {}

function M.get_weather()
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
		[51] = { description = "Drizzle: 🌦️ Light intensity", icon = "🌦️" },
		[53] = { description = "Drizzle: 🌦️🌦️ Moderate intensity", icon = "🌦️" },
		[55] = { description = "Drizzle: 🌦️🌦️🌦️ Dense intensity", icon = "🌦️" },
		[56] = { description = "Freezing Drizzle: 🌧️🥶 Light intensity", icon = "🌧️" },
		[57] = { description = "Freezing Drizzle: 🌧️🌧️🥶 Dense intensity", icon = "🌧️" },
		[61] = { description = "Rain: 🌧️ Slight intensity", icon = "🌧️" },
		[63] = { description = "Rain: 🌧️🌧️ Moderate intensity", icon = "🌧️" },
		[65] = { description = "Rain: 🌧️🌧️🌧️ Heavy intensity", icon = "🌧️" },
		[66] = { description = "Freezing Rain: 🌧️🥶 Light intensity", icon = "🌧️" },
		[67] = { description = "Freezing Rain: 🌧️🌧️🥶 Heavy intensity", icon = "🌧️" },
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
		"| Description             | Value           |\n"
			.. "| ----------------------- | --------------- |\n"
			.. "| 🌡️ Temperature          | %s°C - %s°C     |\n"
			.. "| 💨 Wind                 | %s - %s m/s     |\n"
			.. "| 🌞 Forecast             | %s %s           |\n"
			.. "| 💧 Humidity             |                 |\n"
			.. "|  - 🌍 Outdoor           | %s﹪            |\n"
			.. "|  - 🏠 Indoor RH (AM/PM) | #﹪ / #﹪       |\n",
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

function M.insert_weather()
	local weather_string = M.get_weather()
	vim.api.nvim_put(vim.fn.split(weather_string, "\n"), "l", true, true)
end

vim.keymap.set("n", "<leader>cc", function()
	-- Toggle color column
	-- Value is the column number to mark for recommended max line length
	if vim.o.colorcolumn == "" then
		vim.o.colorcolumn = "120"
	else
		vim.o.colorcolumn = ""
	end
end, { desc = "Toggle color column" })

return M
