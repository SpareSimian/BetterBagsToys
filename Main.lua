local addonName, addon = ...
LibStub('AceAddon-3.0'):NewAddon(addon, addonName, 'AceConsole-3.0')

-- required API to do tooltip scanning
if not C_TooltipInfo or not C_TooltipInfo.GetOwnedItemByID then
  return
end

local bb = LibStub('AceAddon-3.0'):GetAddon("BetterBags")
local categories = bb:GetModule('Categories')
local L = bb:GetModule('Localization')

local function extractColoredText(text)
  local found, _, itemString = string.find(text, "|c%x%x%x%x%x%x%x%x(.+)|r")
  if found then
    return itemString
  else
    return text
  end
end

--[[

categories to build:
Anima
Korthian Relics
Conduits
Stygia

categories shared with other expansions:
Champion Equipment

]]-- 

categories:RegisterCategoryFunction("ToysFilter", function (data)

  -- addon:Print("Candidate for Toys category " .. data.itemInfo.itemName)

  local tooltipInfo = C_TooltipInfo.GetOwnedItemByID(data.itemInfo.itemID)
  
  for k,v in pairs(tooltipInfo.lines) do
    local text = extractColoredText(v.leftText)
    -- addon:Print(data.itemInfo.itemName .. " tooltip line: " .. text)
    if text == "Toy" then
      return L:G("Toys")
    end
  end

  return nil
end)
