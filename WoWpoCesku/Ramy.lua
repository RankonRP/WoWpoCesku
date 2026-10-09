-- © 2026 RankonRP a přispěvatelé. Překlady a texty nelze kopírovat do jiných addonů ani projektů bez povolení – viz docs/LICENSE-DATA.md
-------------------------------------------------------------------------------
-- Zkouška rámů: /czq ramy ukáže vedle sebe šablony oken, které má hra (WoW Forever), abychom vybrali rám,
-- který nejlíp ladí s herním rozhraním. Jen pro vývoj.
-------------------------------------------------------------------------------
local FONT = "Interface\\AddOns\\WoWpoCesku\\Fonts\\cz.ttf"
local TEMPLATES = {
    "PortraitFrameTemplate",
    "ButtonFrameTemplate",
    "ButtonFrameTemplateNoPortrait",
    "BasicFrameTemplateWithInset",
    "BasicFrameTemplate",
    "DefaultPanelTemplate",
    "SimplePanelTemplate",
    "UIPanelDialogTemplate",
    "DialogBorderTemplate",
    "DialogBorderOpaqueTemplate",
    "DialogBorderDarkTemplate",
    "InsetFrameTemplate",
    "ThinBorderTemplate",
    "TooltipBackdropTemplate",
    "ChatConfigBoxTemplate",
    "HelpPlateBox",
}

local win

local function oldDialog(parent)
    local f = CreateFrame("Frame", nil, parent, "BackdropTemplate")
    f:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8x8",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        edgeSize = 32, insets = { left = 11, right = 11, top = 11, bottom = 11 },
    })
    f:SetBackdropColor(0.23, 0.13, 0.07, 1)
    return f
end

local function build()
    win = CreateFrame("Frame", "WoWpoCeskuRamy", UIParent, "BackdropTemplate")
    win:SetSize(1180, 780)
    win:SetPoint("CENTER")
    win:SetFrameStrata("DIALOG")
    win:SetBackdrop({ bgFile = "Interface\\Buttons\\WHITE8x8", edgeFile = "Interface\\Buttons\\WHITE8x8", edgeSize = 1 })
    win:SetBackdropColor(0.04, 0.04, 0.05, 0.96)
    win:SetBackdropBorderColor(0.6, 0.45, 0.15, 1)
    win:EnableMouse(true)
    win:SetMovable(true)
    win:RegisterForDrag("LeftButton")
    win:SetScript("OnDragStart", win.StartMoving)
    win:SetScript("OnDragStop", win.StopMovingOrSizing)
    local close = CreateFrame("Button", nil, win, "UIPanelCloseButton")
    close:SetPoint("TOPRIGHT", -4, -4)
    if UISpecialFrames then table.insert(UISpecialFrames, "WoWpoCeskuRamy") end

    local head = win:CreateFontString(nil, "OVERLAY")
    head:SetFont(FONT, 14, "")
    head:SetPoint("TOPLEFT", 14, -10)
    head:SetText("Rámy ze hry: vyfoť a napiš, který se ti líbí (číslo)")

    local items = {}
    for i, name in ipairs(TEMPLATES) do items[#items + 1] = { name = name } end
    items[#items + 1] = { name = "UI-DialogBox-Border (starý, v Dungeon Kronice dřív)", old = true }

    local cw, ch = 280, 175
    for i, it in ipairs(items) do
        local col, row = (i - 1) % 4, math.floor((i - 1) / 4)
        local f, ok
        if it.old then
            f, ok = oldDialog(win), true
        else
            ok, f = pcall(CreateFrame, "Frame", nil, win, it.name)
        end
        local x, y = 14 + col * (cw + 16), -(44 + row * (ch + 34))
        if ok and f then
            f:SetSize(cw, ch)
            f:SetPoint("TOPLEFT", x, y)
            f:SetFrameLevel(win:GetFrameLevel() + 2)
            if f.SetTitle then pcall(f.SetTitle, f, tostring(i)) elseif f.TitleText then f.TitleText:SetText(tostring(i)) end
            local lbl = f:CreateFontString(nil, "OVERLAY")
            lbl:SetFont(FONT, 12, "OUTLINE")
            lbl:SetPoint("CENTER", 0, 0)
            lbl:SetText(i .. ". " .. it.name)
            lbl:SetWidth(cw - 50)
        else
            local lbl = win:CreateFontString(nil, "OVERLAY")
            lbl:SetFont(FONT, 12, "")
            lbl:SetTextColor(1, 0.4, 0.3)
            lbl:SetPoint("TOPLEFT", x, y)
            lbl:SetWidth(cw)
            lbl:SetText(i .. ". " .. it.name .. ": šablonu hra nemá")
        end
    end
end

function WoWpoCesku_FrameTest()
    if not win then build(); win:Show() return end   -- čerstvě vytvořené okno je hned vidět
    if win:IsShown() then win:Hide() else win:Show() end
end
