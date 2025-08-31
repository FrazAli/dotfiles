-- Daily + Weekly templates
local function get_weather()
	-- Fetch weather data from the OpenMeteo API
	local lat = "59.3293" -- Replace with your latitude
	local lon = "18.0686" -- Replace with your longitude
	local url = string.format(
		"https://api.open-meteo.com/v1/forecast?latitude=%s&longitude=%s&daily=weathercode,temperature_2m_max,temperature_2m_min,windspeed_10m_min,windspeed_10m_max,relative_humidity_2m_mean&wind_speed_unit=kmh&timezone=auto",
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
			.. "- 💨 Wind: %s - %s km/h\n"
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

local daily_template = function()
	return [[
# %A, %B %d, %Y

## Weather

]] .. get_weather() .. [[

## Morning Protocol (empty stomach)
- [ ] 200–300 ml warm water + pinch sea salt (~⅛ tsp) @ 00:00
- Notes after drinking water: ...
  _(taste, nausea, reflux)_

## Health — Core Tracking (Phase 1)

### Bowel Movement (BM) Log
#### BM #1
- Time: 00:00
- Bristol type (1–7): #
- Ease (1=hard/strain, 5=effortless): #
- Time on toilet: # min
- Straining (Y/N): N
- Feeling of complete emptying (0–3): #
- Visible mucus/blood (Y/N): N
- Color: [e.g. brown]
- Notes: ...

#### BM #2
- Time: 00:00
- Bristol type (1–7): #
- Ease: #
- Time on toilet: # min
- Straining (Y/N): N
- Feeling of complete emptying (0–3): #
- Visible mucus/blood (Y/N): N
- Color: [e.g. brown]
- Notes: ...

#### BM #3
- Time: 00:00
- Bristol type (1–7): #
- Ease: #
- Time on toilet: # min
- Straining (Y/N): N
- Feeling of complete emptying (0–3): #
- Visible mucus/blood (Y/N): N
- Color: [e.g. brown]
- Notes: ...

### Symptoms (0=none, 3=severe)
- Bloating: 0 | Cramps: 0 | Nausea: 0 | Reflux: 0 | Headache: 0
- Sinus/Throat irritation: 0 | Itch/Histamine: 0 | Fatigue: 0 | Brain fog: 0
- Dizziness with exertion: 0

### Sleep (last night)
- Bed: 00:00 | Wake: 00:00 | Awakenings: #
- Dream intensity (0–3): # | Sleep paralysis (Y/N): N
- Rested on waking (0–3): #

### Protocol Timing & Doses
- Flaxseed 1 Tbsp (~10 g) with breakfast @ 07:00 (Taken Y/N): Y
- Psyllium (whole husk) ½–1 tsp in water @ 10:30 (≥90 min from food/supps) ➜ Extra water glass (Y/N): N
- Magnesium citrate 200–300 mg after dinner @ 21:00 (Dose: 200 mg)
- Extras today (tick):
  - [ ] Ginger tea
  - [ ] Thyme tea
  - [ ] Chamomile
  - [ ] Rooibos
- Hydration goal (L): 2.0 | Actual (L): ...
  - Water: ...
  - Tea: ...

## Food Log (brief)
### Breakfast (07:00–08:00)
- Base:
  - [ ] Rice Cakes: #
  - [ ] Oats
  - [ ] Sweet Potatoes
- Protein: ...
- Veggies: ...
- Healthy fats:
  - [ ] Avocados
  - [ ] Tahini
  - [ ] Seeds
  - [ ] Olive oil
  - [ ] Nut butter
- Extras:
  - [ ] Lemon juice
  - [ ] Herbs / spices
  - [ ] Fruit/Berries: ...
- Sleepiness after meal (0–3): #
- Hunger rebound (hrs until next hunger): #

### Lunch (12:00–13:00)
- Menu: ...
- Sleepiness after meal (0–3): #
- Hunger rebound (hrs): #

### Dinner (18:00–19:00)
- Menu: ...
- Sleepiness after meal (0–3): #
- Hunger rebound (hrs): #

### Snacks (time + item)
- 00:00 ...
- 00:00 ...

## Training / Activity
- [ ] Walk: # min
- [ ] Strength: # min, effort (RPE 1–10): #
- Notes:
  - Any dizziness/near-faint? (Y/N): N | Details: ...

## Triggers / Exposures (today)
- Damp/smell? (Y/N): N
- Visible dust specks? (Y/N): N
- New/old items brought in: No
- Other: ...

## Notes
- Physical notes: ...
- Exposure notes: ...
]]
end

local weekly_template = [[
# Week %W %B %Y — Summary

## Totals / Averages
- BMs: ... / 7 days  |  Avg Bristol: ...  |  Avg Ease: ...
# Sunday, August 31, 2025
# Sunday, August 31, 2025

🌡️ Temperature: 13.7°C - 18.1°C, humidity: 70%
💨 Wind: 1.4 - 7.9 km/h
🌞 Forecast: ☁️ Overcast

## Morning Protocol (empty stomach)

- [x] 200–300 ml warm water + pinch sea salt (~⅛ tsp) @ **_:_**
- Notes (taste, nausea, reflux):

## Health — Core Tracking (Phase 1)

### Bowel Movement (BM) Log

#### BM # 1

- Time: 08:45
- Bristol type (1–7): 3
- Ease (1=hard/strain, 5=effortless): 2
- Time on toilet: 20 min
- Visible mucus/blood (Y/N): N
- Color: medium brown
- Notes: It was difficult to start, had to put aside my cellphone and focus to start. Once started it cam out one main and one small piece with mostly smooth.

#### BM # 2

- Time: 17:00
- Bristol type (1–7): 3
- Ease (1=hard/strain, 5=effortless): 2
- Time on toilet: 15 min
- Visible mucus/blood (Y/N): N
- Color: medium brown
- Notes This second stool in the afternoon was similar to the one in the morning, but smaller in length and had a lot of black quinoa in it.

### Symptoms (0=none, 3=severe)

- Bloating: 0 | Cramps: 0 | Nausea: 0 | Reflux: 0 | Headache: 0
- Sinus/Throat irritation: 0 | Itch/Histamine: 0 | Fatigue: 0 | Brain fog: 0
- Dizziness with exertion: 0

### Sleep (last night)

- Bed: 12:00 | Wake: 05:45 | Awakenings #: 0
- Dream intensity (0–3): 1 | Sleep paralysis (Y/N): N
- Rested on waking (0–3): 2

### Protocol Timing & Doses

- Flaxseed 1 Tbsp (~10 g) with breakfast @ 07:00 (Taken Y/N): Y
- Psyllium (whole husk) ½–1 tsp in water @ 10:30 (≥90 min from food/supps) ➜ Extra water glass (Y/N): N
- Magnesium citrate 200–300 mg after dinner @ 22:00 (Dose: 200 mg)
- Extras today (tick):
  - [ ] Ginger tea
  - [ ] Thyme tea
  - [x] Chamomile
  - [ ] Rooibos
- Hydration total (L): 1.2
  - Water: 1
  - Tea: 0.2

## Food Log (brief)

### Breakfast (07:00–08:00)

### Breakfast (07:00–08:00)

- Base:
  - [x] Rice Cakes: 2
  - [ ] Oats
  - [ ] Sweet Potatoes
- Protein: 2 eggs
- Veggies: [e.g. Avocado: 1, Mini bell peppers: 1]
- Healthy fats:
  - [x] Avocados
  - [x] Tahini
  - [ ] Seeds
  - [ ] Olive oil
  - [ ] Nut butter
- Extras:
  - [x] Lemon juice
  - [ ] Herbs / spices
  - [ ] Fruit/Berries [e.g. Banana: 1, Berries: #]
- Sleepiness after meals (0=none, 3=severe): 2

### Lunch (12:00–13:00)

- Menu: skipped
- Sleepiness after meals (0=none, 3=severe): 0

### Dinner (18:00–19:00)

- Menu: Max crispy (last piece left from previous batch), brocolli, carrots, cabbage and kale mix salad, left over tri-color quinoa, a handful of fresh blueberries, a little olive oil.
- Sleepiness after meals (0=none, 3=severe): 0

### Snacks (time + item)

- 02:30 One Peach normal, one donut (flat) peach, one plum
- 16:00 7 macadamia nuts, a quarter of cucumber, two small mini carrots, left over Heul dark (~250ml)

## Training / Activity

- [ ] Walk: # min
- [ ] Strength: # min, effort (RPE 1–10): #
- Notes:
  - Any dizziness/near-faint? (Y/N): N | Details: [e.g. Nausea, dizziness]

## Triggers / Exposures (today)

- Damp/smell? (Y/N): N
- Visible dust specks? (Y/N): N
- New/old items brought in: N, [e.g. clothes, books]
- Other: Suspect a mild exposure from the cabinet next to entrance door t my apartment.

## General Notes

Felt a bit or irritation in my nose in the evening when I took out my jacket. Suspect some slight contamination in the cabinet next to door.

🌡️ Temperature: 13.7°C - 18.1°C, humidity: 70%
💨 Wind: 1.4 - 7.9 km/h
🌞 Forecast: ☁️ Overcast

## Morning Protocol (empty stomach)

- [x] 200–300 ml warm water + pinch sea salt (~⅛ tsp) @ **_:_**
- Notes (taste, nausea, reflux):

## Health — Core Tracking (Phase 1)

### Bowel Movement (BM) Log

#### BM # 1

- Time: 08:45
- Bristol type (1–7): 3
- Ease (1=hard/strain, 5=effortless): 2
- Time on toilet: 20 min
- Visible mucus/blood (Y/N): N
- Color: medium brown
- Notes: It was difficult to start, had to put aside my cellphone and focus to start. Once started it cam out one main and one small piece with mostly smooth.

#### BM # 2

- Time: 17:00
- Bristol type (1–7): 3
- Ease (1=hard/strain, 5=effortless): 2
- Time on toilet: 15 min
- Visible mucus/blood (Y/N): N
- Color: medium brown
- Notes This second stool in the afternoon was similar to the one in the morning, but smaller in length and had a lot of black quinoa in it.

### Symptoms (0=none, 3=severe)

- Bloating: 0 | Cramps: 0 | Nausea: 0 | Reflux: 0 | Headache: 0
- Sinus/Throat irritation: 0 | Itch/Histamine: 0 | Fatigue: 0 | Brain fog: 0
- Dizziness with exertion: 0

### Sleep (last night)

- Bed: 12:00 | Wake: 05:45 | Awakenings #: 0
- Dream intensity (0–3): 1 | Sleep paralysis (Y/N): N
- Rested on waking (0–3): 2

### Protocol Timing & Doses

- Flaxseed 1 Tbsp (~10 g) with breakfast @ 07:00 (Taken Y/N): Y
- Psyllium (whole husk) ½–1 tsp in water @ 10:30 (≥90 min from food/supps) ➜ Extra water glass (Y/N): N
- Magnesium citrate 200–300 mg after dinner @ 22:00 (Dose: 200 mg)
- Extras today (tick):
  - [ ] Ginger tea
  - [ ] Thyme tea
  - [x] Chamomile
  - [ ] Rooibos
- Hydration total (L): 1.2
  - Water: 1
  - Tea: 0.2

## Food Log (brief)

### Breakfast (07:00–08:00)

### Breakfast (07:00–08:00)

- Base:
  - [x] Rice Cakes: 2
  - [ ] Oats
  - [ ] Sweet Potatoes
- Protein: 2 eggs
- Veggies: [e.g. Avocado: 1, Mini bell peppers: 1]
- Healthy fats:
  - [x] Avocados
  - [x] Tahini
  - [ ] Seeds
  - [ ] Olive oil
  - [ ] Nut butter
- Extras:
  - [x] Lemon juice
  - [ ] Herbs / spices
  - [ ] Fruit/Berries [e.g. Banana: 1, Berries: #]
- Sleepiness after meals (0=none, 3=severe): 2

### Lunch (12:00–13:00)

- Menu: skipped
- Sleepiness after meals (0=none, 3=severe): 0

### Dinner (18:00–19:00)

- Menu: Max crispy (last piece left from previous batch), brocolli, carrots, cabbage and kale mix salad, left over tri-color quinoa, a handful of fresh blueberries, a little olive oil.
- Sleepiness after meals (0=none, 3=severe): 0

### Snacks (time + item)

- 02:30 One Peach normal, one donut (flat) peach, one plum
- 16:00 7 macadamia nuts, a quarter of cucumber, two small mini carrots, left over Heul dark (~250ml)

## Training / Activity

- [ ] Walk: # min
- [ ] Strength: # min, effort (RPE 1–10): #
- Notes:
  - Any dizziness/near-faint? (Y/N): N | Details: [e.g. Nausea, dizziness]

## Triggers / Exposures (today)

- Damp/smell? (Y/N): N
- Visible dust specks? (Y/N): N
- New/old items brought in: N, [e.g. clothes, books]
- Other: Suspect a mild exposure from the cabinet next to entrance door t my apartment.

## General Notes

Felt a bit or irritation in my nose in the evening when I took out my jacket. Suspect some slight contamination in the cabinet next to door.
- Avg awakenings/night: ...  |  Dream intensity avg: ...  |  Paralysis episodes: ...
- Training sessions: ... (total minutes: ...)  |  Dizziness episodes: ...
- Hydration avg (L/day): ...  |  Magnesium avg (mg): ...

## Protocol Adherence (check counts)
- Salt water AM: .../7   |  Flax with breakfast: .../7   |  Psyllium 10:30: .../7   |  Magnesium after dinner: .../7
- Tea rotation: Chamomile ... / Thyme ... / Ginger ... / Rooibos ...

## Weather

]] .. get_weather() .. [[

## Morning Protocol (empty stomach)
- [ ] 200–300 ml warm water + pinch sea salt (~⅛ tsp) @ 00:00
- Notes after drinking water: None
  _(taste, nausea, reflux)_

## Health — Core Tracking (Phase 1)

### Bowel Movement (BM) Log
#### BM # 1
- Time: 00:00
- Bristol type (1–7): #
- Ease (1=hard/strain, 5=effortless): #
- Timo on toilet: # min
- Visible mucus/blood (Y/N): N
- Color: [e.g. brown]
- Notes: [e.g. Hard to start, felt incomplete, small dry lumps first then smoother log.]


### Symptoms (0=none, 3=severe)
- Bloating: 0 | Cramps: 0 | Nausea: 0 | Reflux: 0 | Headache: 0
- Sinus/Throat irritation: 0 | Itch/Histamine: 0 | Fatigue: 0 | Brain fog: 0
- Sleepiness after meals: 0 | Dizziness with exertion: 0

### Sleep (last night)
- Bed: 10:00 | Wake: 00:00 | Awakenings: #
- Dream intensity (0–3): 0 | Sleep paralysis (Y/N): Y
- Rested on waking (0–3): 2

### Protocol Timing & Doses
- Flaxseed 1 Tbsp (~10 g) with breakfast @ 07:00 (Taken Y/N): Y
- Psyllium (whole husk) ½–1 tsp in water @ 10:30 (≥90 min from food/supps) ➜ Extra water glass (Y/N): Y
- Magnesium citrate 200–300 mg after dinner @ 21:00 (Dose: 200 mg)
- Extras today (tick):
  - [ ] Ginger tea
  - [ ] Thyme tea
  - [ ] Chamomile
  - [ ] Rooibos
- Hydration total (L): #

## Food Log (brief)
### Breakfast (07:00–08:00)
- Base:
  - [ ] Rice Cakes: #
  - [ ] Oats
  - [ ] Sweet Potatoes
- Protein: [e.g. Eggs: 2, left over meat: 1]
- Veggies: [e.g. Avocado: 1, Mini bell peppers: 1]
- Healthy fats:
  - [ ] Avacados
  - [ ] Tahini
  - [ ] Seeds
  - [ ] Olive oil
  - [ ] Nut butter
- Extras:
  - [ ] Lemon juice
  - [ ] Herbs / spices
  - [ ] Fruits [e.g. Banana: 1, Berries: #]

### Lunch (12:00–13:00)
- Menu: [e.g. Veggie salad: 1, Chicken: 2]

### Dinner (18:00–19:00)
- Menu: [e.g. Veggie salad: 1, Chicken: 2]

### Snacks (time + item)
- 00:00 [e.g. Banana: 1]
- 00:00 [e.g. Banana: 1]

## Training / Activity
- [ ] Walk: # min
- [ ] Strength: # min, effort (RPE 1–10): #
- Notes:
  - Any dizziness/near-faint? (Y/N): N | Details: [e.g. Nausea, dizziness]

## Triggers / Exposures (today)
- Damp/smell? (Y/N): N
- Visible dust specks? (Y/N): N
- New/old items brought in: N, [e.g. clothes, books]
- Other: [Triggers/Exposures]

# Notes
- .....................
- .....................

## Work

## Personal
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
