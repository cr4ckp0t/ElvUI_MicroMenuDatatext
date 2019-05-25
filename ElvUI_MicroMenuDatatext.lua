-------------------------------------------------------------------------------
-- ElvUI Titles Datatext By Lockslap (US, Bleeding Hollow)
-------------------------------------------------------------------------------
local E, _, V, P, G = unpack(ElvUI)
local DT = E:GetModule("DataTexts")
local L = LibStub("AceLocale-3.0"):GetLocale("ElvUI_MicroMenuDatatext", false)
local EP = LibStub("LibElvUIPlugin-1.0")

local Frame = CreateFrame("Frame")
local displayString = ""

local function Update()

end

local function Click(self, button)

end

local function CreateMenu(self, level)

end

function Frame:PLAYER_ENTERING_WORLD()	
	self.initialize = CreateMenu
	self.displayMode = "MENU"
end
Frame:SetScript("OnEvent", function(self, event

local function ValueColorUpdate(hex, r, g, b)
	displayString = join("", "|cffffffff%s:|r", " ", hex, "%d|r")
	if lastPanel ~= nil then OnEvent(lastPanel) end
end
E["valueColorUpdateFuncs"][ValueColorUpdate] = true

P["micromenudt"] = {
	["useName"] = true,
}

local function InjectOptions()
	if not E.Options.args.lockslap then
		E.Options.args.lockslap = {
			type = "group",
			order = -2,
			name = L["Plugins by |cff9382c9Lockslap|r"],
			args = {
				thanks = {
					type = "description",
					order = 1,
					name = L["Thanks for using and supporting my work!  -- |cff9382c9Lockslap|r\n\n|cffff0000If you find any bugs, or have any suggestions for any of my addons, please open a ticket at that particular addon's page on CurseForge."],
				},
			},
		}
	elseif not E.Options.args.lockslap.args.thanks then
		E.Options.args.lockslap.args.thanks = {
			type = "description",
			order = 1,
			name = L["Thanks for using and supporting my work!  -- |cff9382c9Lockslap|r\n\n|cffff0000If you find any bugs, or have any suggestions for any of my addons, please open a ticket at that particular addon's page on CurseForge."],
		}
	end
	
	E.Options.args.lockslap.args.micromenudt = {
		type = "group",
		name = L["Micro Menu Datatext"],
		get = function(info) return E.db.micromenudt[info[#info]] end,
		set = function(info, value) E.db.micromenudt[info[#info]] = value; DT:LoadDataTexts() end,
		args = {
			useName = {
				type	= "toggle",
				order	= 4,
				name	= L["Use Character Name"],
				desc	= L["Use your character's class color and name in the tooltip."],
			},
		},
	}
end

EP:RegisterPlugin(..., InjectOptions)
DT:RegisterDatatext("Micro Menu", nil, nil, Update, Click, nil)