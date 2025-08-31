-- Daily + Weekly templates
local function get_weather()
	-- Fetch weather data from the OpenMeteo API
	local lat = "59.3293" -- Replace with your latitude
	local lon = "18.0686" -- Replace with your longitude
	local url = string.format(
		"https://api.open-meteo.com/v1/forecast?latitude=%s&longitude=%s&daily=weathercode,temperature_2m_max,temperature_2m_min,windspeed_10m_min,windspeed_10m_max&wind_speed_unit=kmh&timezone=auto",
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
		[45] = { description = "Fog", icon = "🌁" },
		[48] = { description = "Depositing rime fog", icon = "🌁" },
		[51] = { description = "Drizzle: Light intensity", icon = "🌦️" },
		[53] = { description = "Drizzle: Moderate intensity", icon = "🌦️" },
		[55] = { description = "Drizzle: Dense intensity", icon = "🌦️" },
		[56] = { description = "Freezing Drizzle: Light intensity", icon = "🌧️" },
		[57] = { description = "Freezing Drizzle: Dense intensity", icon = "🌧️" },
		[61] = { description = "Rain: Slight intensity", icon = "🌧️" },
		[63] = { description = "Rain: Moderate intensity", icon = "🌧️" },
		[65] = { description = "Rain: Heavy intensity", icon = "🌧️" },
		[66] = { description = "Freezing Rain: Light intensity", icon = "🌧️" },
		[67] = { description = "Freezing Rain: Heavy intensity", icon = "🌧️" },
		[71] = { description = "Snow fall: Slight intensity", icon = "🌨️" },
		[73] = { description = "Snow fall: Moderate intensity", icon = "🌨️" },
		[75] = { description = "Snow fall: Heavy intensity", icon = "🌨️" },
		[77] = { description = "Snow grains", icon = "🌨️" },
		[80] = { description = "Rain showers: Slight intensity", icon = "🌧️" },
		[81] = { description = "Rain showers: Moderate intensity", icon = "🌧️" },
		[82] = { description = "Rain showers: Violent intensity", icon = "🌧️" },
		[85] = { description = "Snow showers: Slight intensity", icon = "🌨️" },
		[86] = { description = "Snow showers: Heavy intensity", icon = "🌨️" },
		[95] = { description = "Thunderstorm: Slight or moderate", icon = "⛈️" },
		[96] = { description = "Thunderstorm with slight hail", icon = "⛈️" },
		[99] = { description = "Thunderstorm with heavy hail", icon = "⛈️" },
	}

	local code = weather_data.daily.weathercode[1]
	local weather = weather_map[code] or { description = "Unknown", icon = "🧑🏻‍💻" }
	local max_temp = weather_data.daily.temperature_2m_max[1]
	local min_temp = weather_data.daily.temperature_2m_min[1]
	local min_wind = weather_data.daily.windspeed_10m_min[1]
	local max_wind = weather_data.daily.windspeed_10m_max[1]

	local weather_string = string.format(
		"🌡️ Temperature: %s°C - %s°C\n💨 Wind: %s - %s km/h\n🌞 Forecast: %s %s\n",
		min_temp,
		max_temp,
		min_wind,
		max_wind,
		weather.icon,
		weather.description
	)
	return weather_string
end

local daily_template = function()
	return [[
# %A, %B %d, %Y

## Weather

]] .. get_weather() .. [[

## Morning Protocol (empty stomach)
- [ ] 200–300 ml warm water + pinch sea salt (~⅛ tsp) @ ...:...
- Notes (taste, nausea, reflux): .....................

## Health — Core Tracking (Phase 1)

### Bowel Movement (BM) Log
- BM today (Y/N): ...
- Time(s): ...:... / ...:...
- Bristol type (1–7): ...
- Ease (1=hard/strain, 5=effortless): ...
- Visible mucus/blood (Y/N): ... | Urgency (0–3): ...
- Notes: .....................

### Symptoms (0=none, 3=severe)
- Bloating ... | Cramps ... | Nausea ... | Reflux ... | Headache ...
- Sinus/Throat irritation ... | Itch/Histamine ... | Fatigue ... | Brain fog ...
- Sleepiness after meals ... | Dizziness with exertion ...

### Sleep (last night)
- Bed: ...:... | Wake: ...:... | Awakenings #: ...
- Dream intensity (0–3): ... | Sleep paralysis (Y/N): ...
- Rested on waking (0–3): ...

### Protocol Timing & Doses
- Flaxseed 1 Tbsp (~10 g) with breakfast @ ...:... (Taken Y/N): ...
- Psyllium (whole husk) ½–1 tsp in water @ 10:30 (≥90 min from food/supps) ➜ Extra water glass (Y/N): ...
- Magnesium citrate 200–300 mg after dinner @ ...:... (Dose: ... mg)
- Extras today (tick): [ ] Ginger tea  [ ] Thyme tea  [ ] Chamomile  [ ] Rooibos
- Hydration total (L): ...

## Food Log (brief)
### Breakfast (07:00–08:00)
- Menu: .....................
- Rice cakes: ... (1–2) | Veg topping: .....................
- Add-ons: [ ] Avocado  [ ] Tahini  [ ] Seeds  [ ] Olive oil  [ ] Lemon

### Lunch (12:00–13:00)
- Menu: .....................

### Dinner (18:00–19:00)
- Menu: .....................

### Snacks (time + item)
- ...:... .....................
- ...:... .....................

## Training / Activity
- Type: [ ] Walk  [ ] Strength  [ ] Bike/Row  [ ] Mobility
- Duration: ... min | Effort (RPE 1–10): ...
- Any dizziness/near-faint? (Y/N): ... | Notes: .....................

## Triggers / Exposures (today)
- Damp/smell? (Y/N): ... | Visible dust specks? (Y/N): ...
- New/old items brought in: .....................
- Other: .....................

# Notes
- .....................
- .....................

## Work

## Personal
]]
end

local weekly_template = [[
# Week %W %B %Y — Summary

## Totals / Averages
- BMs: ... / 7 days  |  Avg Bristol: ...  |  Avg Ease: ...
- Avg awakenings/night: ...  |  Dream intensity avg: ...  |  Paralysis episodes: ...
- Training sessions: ... (total minutes: ...)  |  Dizziness episodes: ...
- Hydration avg (L/day): ...  |  Magnesium avg (mg): ...

## Protocol Adherence (check counts)
- Salt water AM: .../7   |  Flax with breakfast: .../7   |  Psyllium 10:30: .../7   |  Magnesium after dinner: .../7
- Tea rotation: Chamomile ... / Thyme ... / Ginger ... / Rooibos ...

## Symptoms trend (0–3; ↓ better, ↑ worse)
- Bloating: ... → ...  |  Cramps: ... → ...  |  Nausea: ... → ...
- Sinus/Throat: ... → ...  |  Fatigue: ... → ...
- Brain fog: ... → ...  |  Dizziness with exertion: ... → ...

## Triggers/Environment
- Avg indoor RH% (AM/PM): ... / ...   |  Notable exposures: .....................

## Notes & Next Tweaks
- What worked: .....................
- What didn’t: .....................
- Planned adjustments for next week: .....................
]]

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

