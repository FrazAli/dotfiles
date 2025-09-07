local utils = require("utils")

-- Daily + Weekly templates
local function _load_template(template_path)
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
	local template_content = _load_template(template_path)

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

	local weather_string = utils.get_weather()
	local final_content = template_content:gsub("{{WEATHER}}", weather_string)
	return final_content
end

local weekly_template = function()
	local template_path = vim.fn.expand("./templates/weekly.md")
	local template_content = _load_template(template_path)

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
