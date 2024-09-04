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

categories:RegisterCategoryFunction("ToysFilter", function (data)

  -- addon:Print("Candidate for Toys category " .. data.itemInfo.itemName)

  local tooltipInfo = C_TooltipInfo.GetOwnedItemByID(data.itemInfo.itemID)

  local mightBeToy = false
  for _,v in pairs(tooltipInfo.lines) do
    local text = extractColoredText(v.leftText)
    -- addon:Print(data.itemInfo.itemName .. " tooltip line: " .. text)
    if text == "Toy" or text == "Warband Toy" then
      mightBeToy = true
    end
    -- ignore recipes, patterns, and schematics that produce toys
    if string.find(v.leftText, "Recipe:") then
      return nil
    end
    if string.find(v.leftText, "Pattern:") then
      return nil
    end
    if string.find(v.leftText, "Schematic:") then
      return nil
    end
  end

  if mightBeToy then
    return L:G("Toys")
  end

  return nil
end)
