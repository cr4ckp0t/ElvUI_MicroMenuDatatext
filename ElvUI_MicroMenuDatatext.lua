-------------------------------------------------------------------------------
-- ElvUI Titles Datatext By Crackpotx (US, Lightbringer)
-------------------------------------------------------------------------------
local E, _, V, P, G = unpack(ElvUI)
local DT = E:GetModule("DataTexts")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_MicroMenuDatatext", false)
local EP = LibStub("LibElvUIPlugin-1.0")

-- local api cache
local C_StorePublic_IsEnabled = C_StorePublic.IsEnabled
local CreateFrame = _G["CreateFrame"]
local LoadAddOn = _G["LoadAddOn"]
local HideUIPanel = _G["HideUIPanel"]
local MicroButtonTooltipText = _G["MicroButtonTooltipText"]
local ShowUIPanel = _G["ShowUIPanel"]
local ToggleAchievementFrame = _G["ToggleAchievementFrame"]
local ToggleCharacter = _G["ToggleCharacter"]
local ToggleCollectionsJournal = _G["ToggleCollectionsJournal"]
local ToggleEncounterJournal = _G["ToggleEncounterJournal"]
local ToggleFrame = _G["ToggleFrame"]
local ToggleGuildFrame = _G["ToggleGuildFrame"]
local ToggleHelpFrame = _G["ToggleHelpFrame"]
local ToggleLFDParentFrame = _G["ToggleLFDParentFrame"]
local ToggleQuestLog = _G["ToggleQuestLog"]
local ToggleSpellBook = _G["ToggleSpellBook"]
local ToggleStoreUI = _G["ToggleStoreUI"]
local UIDropDownMenu_AddButton = _G["UIDropDownMenu_AddButton"]
local UnitLevel = _G["UnitLevel"]

local format = string.format
local join = string.join
local Frame = CreateFrame("Frame", "ElvUI_MicroMenuDTMenu", E.UIParent, "UIDropDownMenuTemplate")
local displayString = ""
local hexColor = "|cffffff00"

local function GetDefaultAction()
	-- get the quick action
	if E.db.micromenudt.defaultAction == "character" then
		return L["Toggle Character Frame"]
	elseif E.db.micromenudt.defaultAction == "spellbook" then
		return L["Toggle Spellbook"]
	elseif E.db.micromenudt.defaultAction == "talents" then
		return L["Toggle Talents"]
	elseif E.db.micromenudt.defaultAction == "achievements" then
		return L["Toggle Achievements"]
	elseif E.db.micromenudt.defaultAction == "quests" then
		return L["Toggle Quest Log"]
	elseif E.db.micromenudt.defaultAction == "guild" then
		return L["Toggle Guild Frame"]
	elseif E.db.micromenudt.defaultAction == "dungeons" then
		return L["Toggle Dungeons Frame"]
	elseif E.db.micromenudt.defaultAction == "collections" then
		return L["Toggle Collections Journal"]
	elseif E.db.micromenudt.defaultAction == "encounters" then
		return L["Toggle Encounter Journal"]
	elseif E.db.micromenudt.defaultAction == "gamemenu" then
		return L["Toggle Game Menu"]
	elseif E.db.micromenudt.defaultAction == "elvui" then
		return L["Toggle ElvUI Options UI"]
	elseif E.db.micromenudt.defaultAction == "elvuict" then
		return L["Toggle ElvUI Chat Tweaks Config"]
	end	
end

local function OnUpdate(self, elapsed)
	if self.text:GetText() == nil then
		self.text:SetText(L["Micro Menu"])
	end
end

local function OnClick(self, button)
	if button == "LeftButton" then
		-- do the quick action
		if E.db.micromenudt.defaultAction == "character" then
			ToggleFrame(_G["CharacterFrame"])
		elseif E.db.micromenudt.defaultAction == "spellbook" then
			ToggleFrame(_G["SpellBookFrame"])
		elseif E.db.micromenudt.defaultAction == "talents" then
			-- only players > level 10 have talents
			if UnitLevel("player") >= 10 then
				if not _G["PlayerTalentFrame"] then LoadAddOn("Blizzard_TalentUI") end
				ToggleFrame(_G["PlayerTalentFrame"])
			end
		elseif E.db.micromenudt.defaultAction == "achievements" then
			ToggleAchievementFrame()
		elseif E.db.micromenudt.defaultAction == "quests" then
			ToggleQuestLog()
		elseif E.db.micromenudt.defaultAction == "guild" then
			ToggleGuildFrame()
		elseif E.db.micromenudt.defaultAction == "dungeons" then
			ToggleLFDParentFrame()
		elseif E.db.micromenudt.defaultAction == "collections" then
			ToggleCollectionsJournal()
		elseif E.db.micromenudt.defaultAction == "encounters" then
			ToggleEncounterJournal()
		elseif E.db.micromenudt.defaultAction == "gamemenu" then
			if _G["GameMenuFrame"]:IsShown() then
				HideUIPanel(_G["GameMenuFrame"])
			else
				ShowUIPanel(_G["GameMenuFrame"])
			end
		elseif E.db.micromenudt.defaultAction == "elvui" then
			E:ToggleOptionsUI()
		elseif E.db.micromenudt.defaultAction == "elvuict" then
			if not IsAddOnLoaded("ElvUI_ChatTweaks") or not ElvUI_ChatTweaks then
				print("|cffff0000You do not have ElvUI_ChatTweaks enabled. Please enable the addon and try again.|r")
			else
				ElvUI_ChatTweaks:ToggleConfig()
			end
		end
	else
		DT.tooltip:Hide()
		ToggleDropDownMenu(1, nil, Frame, self, 0, 0)
	end
end

local function CreateMenu(self, level)
	-- character frame
	UIDropDownMenu_AddButton({
		hasArrow = false,
		notCheckable = true,
		colorCode = "|cffffffff",
		text = MicroButtonTooltipText(CHARACTER_BUTTON, "TOGGLECHARACTER0"),
		func = function() ToggleFrame(_G["CharacterFrame"]) end,
	})

	-- spellbook
	UIDropDownMenu_AddButton({
		hasArrow = false,
		notCheckable = true,
		colorCode = "|cffffffff",
		text = MicroButtonTooltipText(SPELLBOOK_ABILITIES_BUTTON, "TOGGLESPELLBOOK"),
		func = function() ToggleFrame(_G["SpellBookFrame"]) end,
	})

	-- talents
	UIDropDownMenu_AddButton({
		hasArrow = false,
		notCheckable = true,
		colorCode = "|cffffffff",
		text = MicroButtonTooltipText(TALENTS_BUTTON, "TOGGLETALENTS"),
		func = function()
			-- only players > level 10 have talents
			if UnitLevel("player") >= 10 then
				if not _G["PlayerTalentFrame"] then LoadAddOn("Blizzard_TalentUI") end
				ToggleFrame(_G["PlayerTalentFrame"])
			end
		end,
	})

	-- achievements
	UIDropDownMenu_AddButton({
		hasArrow = false,
		notCheckable = true,
		colorCode = "|cffffffff",
		text = MicroButtonTooltipText(ACHIEVEMENT_BUTTON, "TOGGLEACHIEVEMENT"),
		func = function() ToggleAchievementFrame() end,
	})

	-- quest log
	UIDropDownMenu_AddButton({
		hasArrow = false,
		notCheckable = true,
		colorCode = "|cffffffff",
		text = MicroButtonTooltipText(QUESTLOG_BUTTON, "TOGGLEQUESTLOG"),
		func = function() ToggleQuestLog() end,
	})

	-- guild
	UIDropDownMenu_AddButton({
		hasArrow = false,
		notCheckable = true,
		colorCode = "|cffffffff",
		text = MicroButtonTooltipText(GUILD, "TOGGLEGUILDTAB"),
		func = function() ToggleGuildFrame() end,
	})

	-- dungeons
	UIDropDownMenu_AddButton({
		hasArrow = false,
		notCheckable = true,
		colorCode = "|cffffffff",
		text = MicroButtonTooltipText(DUNGEONS_BUTTON, "TOGGLEGROUPFINDER"),
		func = function() ToggleLFDParentFrame() end,
	})

	-- collections (pets, toys, and mounts)
	UIDropDownMenu_AddButton({
		hasArrow = false,
		notCheckable = true,
		colorCode = "|cffffffff",
		text = MicroButtonTooltipText(COLLECTIONS, "TOGGLECOLLECTIONS"),
		func = function() ToggleCollectionsJournal() end,
	})

	-- encounters
	UIDropDownMenu_AddButton({
		hasArrow = false,
		notCheckable = true,
		colorCode = "|cffffffff",
		text = MicroButtonTooltipText(ENCOUNTER_JOURNAL, "TOGGLEENCOUNTERJOURNAL"),
		func = function() ToggleEncounterJournal() end,
	})

	if not C_StorePublic_IsEnabled() and GetCurrentRegionName() == "CN" then
		-- help button (for disable store or chinese region)
		UIDropDownMenu_AddButton({
			hasArrow = false,
			notCheckable = true,
			colorCode = "|cffffffff",
			text = HELP_BUTTON,
			func = function() ToggleHelpFrame() end,
		})
	else
		-- store button for everyone else
		UIDropDownMenu_AddButton({
			hasArrow = false,
			notCheckable = true,
			colorCode = "|cffffffff",
			text = BLIZZARD_STORE,
			func = function() ToggleStoreUI() end,
		})
	end

	-- system menu
	UIDropDownMenu_AddButton({
		hasArrow = false,
		notCheckable = true,
		colorCode = "|cffffffff",
		text = L["Game Menu"],
		func = function()
			if _G["GameMenuFrame"]:IsShown() then
				HideUIPanel(_G["GameMenuFrame"])
			else
				ShowUIPanel(_G["GameMenuFrame"])
			end
		end,
	})

	-- elvui config
	if E.db.micromenudt.showElvui and E then
		UIDropDownMenu_AddButton({
			hasArrow = false,
			notCheckable = true,
			colorCode = "|cffffffff",
			text = L["ElvUI Config"],
			func = function() E:ToggleOptionsUI() end,
		})
	end

	if E.db.micromenudt.showElvuict and IsAddOnLoaded("ElvUI_ChatTweaks") and ElvUI_ChatTweaks then
		UIDropDownMenu_AddButton({
			hasArrow = false,
			notCheckable = true,
			colorCode = "|cffffffff",
			text = L["ElvUI Chat Tweaks"],
			func = function() ElvUI_ChatTweaks:ToggleConfig() end,
		})
	end
end

local function OnEnter(self)
	DT:SetupTooltip(self)
	DT.tooltip:AddLine(("%s %s"):format(displayString:format(L["ElvUI"]), L["Micro Menu Datatext By Crackpotx"]), 1, 1, 1, 1, 1, 1)
	DT.tooltip:AddLine(" ")
	DT.tooltip:AddDoubleLine(("<%s>"):format(L["Left Click"]), GetDefaultAction())
	DT.tooltip:AddDoubleLine(("<%s>"):format(L["Right Click"]), L["Open Micro Menu"])
	DT.tooltip:Show()
end

local function ValueColorUpdate(hex, r, g, b)
	displayString = join("", hex, "%s|r")
	hexColor = hex
end
E["valueColorUpdateFuncs"][ValueColorUpdate] = true

function Frame:PLAYER_ENTERING_WORLD()
	self.initialize = CreateMenu
	self.displayMode = "MENU"
end
Frame:SetScript("OnEvent", function(self, event, ...) self[event](self, ...) end)
Frame:RegisterEvent("PLAYER_ENTERING_WORLD")

P["micromenudt"] = {
	defaultAction = "character",
	showElvui = true,
	showElvuict = false,
}

local function InjectOptions()
	if not E.Options.args.Crackpotx then
		E.Options.args.Crackpotx = {
			type = "group",
			order = -2,
			name = L["Plugins by |cff0070deCrackpotx|r"],
			args = {
				thanks = {
					type = "description",
					order = 1,
					name = L["Thanks for using and supporting my work!  - |cff0070deCrackpotx|r\n\n|cffff0000If you find any bugs, or have any suggestions for any of my addons, please open a ticket at that particular addon's page on CurseForge."],
				},
			},
		}
	elseif not E.Options.args.Crackpotx.args.thanks then
		E.Options.args.Crackpotx.args.thanks = {
			type = "description",
			order = 1,
			name = L["Thanks for using and supporting my work!  -- |cff0070deCrackpotx|r\n\n|cffff0000If you find any bugs, or have any suggestions for any of my addons, please open a ticket at that particular addon's page on CurseForge."],
		}
	end
	
	E.Options.args.Crackpotx.args.micromenudt = {
		type = "group",
		name = L["Micro Menu Datatext"],
		get = function(info) return E.db.micromenudt[info[#info]] end,
		set = function(info, value) E.db.micromenudt[info[#info]] = value; DT:LoadDataTexts() end,
		args = {
			defaultAction = {
				type = "select",
				order = 4,
				style = "dropdown",
				width = "double",
				name = L["Default Click Action"],
				desc = L["Default action when you left click on the datatext."],
				values = {
					character = L["Toggle Character Frame"],
					spellbook = L["Toggle Spellbook"],
					talents = L["Toggle Talents"],
					achievements = L["Toggle Achievements"],
					quests = L["Toggle Quest Log"],
					guild = L["Toggle Guild Frame"],
					dungeons = L["Toggle Dungeons Frame"],
					collections = L["Toggle Collections Frame"],
					encounters = L["Toggle Encounters Guide"],
					gamemenu = L["Toggle Game Menu"],
					elvui = L["Toggle ElvUI Options UI"],
					elvuict = L["Toggle ElvUI Chat Tweaks Config"],
				},
			},
			showElvui = {
				type = "toggle",
				order = 5,
				name = L["Show ElvUI Config"],
				desc = L["Show a shortcut to open ElvUI's config in the menu."],
			},
			showElvuict = {
				type = "toggle",
				order = 6,
				name = L["Show ElvUI CT"],
				desc = L["Show a shortcut to open ElvUI Chat Tweaks' config in the menu.\n\n|cffff0000This only applies if this addon is loaded.|r"],
			}
		},
	}
end

EP:RegisterPlugin(..., InjectOptions)
DT:RegisterDatatext("Micro Menu", nil, nil, OnUpdate, OnClick, OnEnter, L["Micro Menu"])