-- Daily + Weekly templates
local daily_template = [[
# %A, %B %d, %Y

Weather: 🌡️🌞 ☁️ ☔ ❄️ ⚡ | Indoor RH (AM/PM): ___ / ___

## Morning Protocol (empty stomach)
- [ ] 200–300 ml warm water + pinch sea salt (~⅛ tsp) @ ___:___
- Notes (taste, nausea, reflux): ______________________

## Health — Core Tracking (Phase 1)

### Bowel Movement (BM) Log
- BM today (Y/N): ___
- Time(s): ___:___ / ___:___
- Bristol type (1–7): ___
- Ease (1=hard/strain, 5=effortless): ___
- Visible mucus/blood (Y/N): ___ | Urgency (0–3): ___
- Notes: ______________________

### Symptoms (0=none, 3=severe)
- Bloating ___ | Cramps ___ | Nausea ___ | Reflux ___ | Headache ___
- Sinus/Throat irritation ___ | Itch/Histamine ___ | Fatigue ___ | Brain fog ___
- Sleepiness after meals ___ | Dizziness with exertion ___

### Sleep (last night)
- Bed: ___:___ | Wake: ___:___ | Awakenings #: ___
- Dream intensity (0–3): ___ | Sleep paralysis (Y/N): ___
- Rested on waking (0–3): ___

### Protocol Timing & Doses
- Flaxseed 1 Tbsp (~10 g) with breakfast @ ___:___ (Taken Y/N): ___
- Psyllium (whole husk) ½–1 tsp in water @ 10:30 (≥90 min from food/supps) ➜ Extra water glass (Y/N): ___
- Magnesium citrate 200–300 mg after dinner @ ___:___ (Dose: ___ mg)
- Extras today (tick): [ ] Ginger tea  [ ] Thyme tea  [ ] Chamomile  [ ] Rooibos
- Hydration total (L): ___

## Food Log (brief)
### Breakfast (07:00–08:00)
- Menu: ______________________
- Rice cakes: ___ (1–2) | Veg topping: ______________________
- Add-ons: [ ] Avocado  [ ] Tahini  [ ] Seeds  [ ] Olive oil  [ ] Lemon

### Lunch (12:00–13:00)
- Menu: ______________________

### Dinner (18:00–19:00)
- Menu: ______________________

### Snacks (time + item)
- ___:___ ______________________
- ___:___ ______________________

## Training / Activity
- Type: [ ] Walk  [ ] Strength  [ ] Bike/Row  [ ] Mobility
- Duration: ___ min | Effort (RPE 1–10): ___
- Any dizziness/near-faint? (Y/N): ___ | Notes: ______________________

## Triggers / Exposures (today)
- Damp/smell? (Y/N): ___ | Visible dust specks? (Y/N): ___
- New/old items brought in: ______________________
- Other: ______________________

# Notes
- ______________________
- ______________________

## Work

## Personal
]]

local weekly_template = [[
# Week %W %B %Y — Summary

## Totals / Averages
- BMs: ___ / 7 days  |  Avg Bristol: ___  |  Avg Ease: ___
- Avg awakenings/night: ___  |  Dream intensity avg: ___  |  Paralysis episodes: ___
- Training sessions: ___ (total minutes: ___)  |  Dizziness episodes: ___
- Hydration avg (L/day): ___  |  Magnesium avg (mg): ___

## Protocol Adherence (check counts)
- Salt water AM: ___/7   |  Flax with breakfast: ___/7   |  Psyllium 10:30: ___/7   |  Magnesium after dinner: ___/7
- Tea rotation: Chamomile ___ / Thyme ___ / Ginger ___ / Rooibos ___

## Symptoms trend (0–3; ↓ better, ↑ worse)
- Bloating: ___ → ___  |  Cramps: ___ → ___  |  Nausea: ___ → ___
- Sinus/Throat: ___ → ___  |  Fatigue: ___ → ___
- Brain fog: ___ → ___  |  Dizziness with exertion: ___ → ___

## Triggers/Environment
- Avg indoor RH% (AM/PM): ___ / ___   |  Notable exposures: ______________________

## Notes & Next Tweaks
- What worked: ______________________
- What didn’t: ______________________
- Planned adjustments for next week: ______________________
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
