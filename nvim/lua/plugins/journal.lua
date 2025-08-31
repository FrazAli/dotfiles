-- Daily + Weekly templates
local daily_template = [[
# %A, %B %d, %Y

Weather: 🌡️🌞 ☁️ ☔ ❄️ ⚡   |  Indoor RH % (AM/PM): ____ / ____

## Morning Protocol (empty stomach)
- [ ] 200–300 ml **warm water + pinch sea salt** (~⅛ tsp) @ __:__
- Notes (taste, nausea, reflux): ______________________________________

## Health — Core Tracking (Phase 1)
### Bowel Movement (BM) Log
- BM today (Y/N): __
- Time(s): __:__ / __:__
- **Bristol type (1–7)**: _
- **Ease** (1=hard/strain, 5=effortless): _
- Visible mucus/blood (Y/N): _   |  Urgency (0–3): _
- Notes: ______________________________________________________________

### Symptoms (0=none, 3=severe)
- Bloating _:  Cramps _:  Nausea _:  Reflux _:  Headache _:
- Sinus/Throat irritation _:  Itch/Histamine _:  Fatigue _:  Brain fog _:
- Sleepiness after meals _:  Dizziness with exertion _:

### Sleep (last night)
- Bed: __:__  |  Wake: __:__  |  Awakenings #: _
- Dream intensity (0–3): _   |  Sleep paralysis (Y/N): _
- Rested on waking (0–3): _

### Protocol Timing & Doses
- **Flaxseed** 1 Tbsp (~10 g) with **breakfast** @ __:__  (Taken Y/N): _
- **Psyllium (whole husk)** ½–1 tsp in water @ **10:30** (≥90 min from food/supps)  ➜ Extra water glass (Y/N): _
- **Magnesium citrate** 200–300 mg **after dinner** @ __:__  (Dose: ___ mg)
- Extras today (tick):  [ ] Ginger tea  [ ] Thyme tea  [ ] Chamomile  [ ] Rooibos
- Hydration total (L): __.__

## Food Log (brief)
### Breakfast (07:00–08:00)
- Menu: _______________________________________________________________
- Rice cakes: _ (1–2)   |  Veg topping: ______________________________
- Add-ons: [ ] Avocado  [ ] Tahini  [ ] Seeds  [ ] Olive oil  [ ] Lemon

### Lunch (12:00–13:00)
- Menu: _______________________________________________________________

### Dinner (18:00–19:00)
- Menu: _______________________________________________________________

### Snacks (time + item)
- __:__  _________________________________________
- __:__  _________________________________________

## Training / Activity
- Type: [ ] Walk  [ ] Strength  [ ] Bike/Row  [ ] Mobility
- Duration: __ min   |  Effort (RPE 1–10): _
- Any dizziness/near-faint? (Y/N): _   Notes: __________________________

## Triggers / Exposures (today)
- Damp/smell? (Y/N): _  |  Visible dust specks? (Y/N): _
- New/old items brought in: ___________________________________________
- Other: ______________________________________________________________

# Notes
- ______________________________________________________________________
- ______________________________________________________________________

## Work

## Personal
]]

local weekly_template = [[
# Week %W %B %Y — Summary

## Totals / Averages
- BMs: __ / 7 days  |  Avg Bristol: __.__  |  Avg Ease: __.__
- Avg awakenings/night: __.__  |  Dream intensity avg: __.__  |  Paralysis episodes: __
- Training sessions: __ (total minutes: __)  |  Dizziness episodes: __
- Hydration avg (L/day): __.__  |  Magnesium avg (mg): __

## Protocol Adherence (check counts)
- Salt water AM: __/7   |  Flax with breakfast: __/7   |  Psyllium 10:30: __/7   |  Magnesium after dinner: __/7
- Tea rotation: Chamomile __ / Thyme __ / Ginger __ / Rooibos __

## Symptoms trend (0–3; ↓ better, ↑ worse)
- Bloating: __→__  |  Cramps: __→__  |  Nausea: __→__  |  Sinus/Throat: __→__  |  Fatigue: __→__
- Brain fog: __→__ |  Dizziness with exertion: __→__

## Triggers/Environment
- Avg indoor RH% (AM/PM): __ / __   |  Notable exposures: ____________________________

## Notes & Next Tweaks
- What worked: _________________________________________________________
- What didn’t: _________________________________________________________
- Planned adjustments for next week: ___________________________________
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
