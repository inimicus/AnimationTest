local EM = EVENT_MANAGER
local WM = WINDOW_MANAGER

local function makeControl(name, width, height, top, left)
    local c = WM:CreateTopLevelWindow(name .. "_control")
    c:SetClampedToScreen(true)
    c:SetDimensions(width, height)
    c:SetMouseEnabled(true)
    c:SetAnchor(CENTER, GUIROOT, CENTER, left, top)
    c:SetAlpha(1)
    c:SetMovable(true)

    function c:ConfigureAnimation(texture, cellWidth, cellHeight, frameRate)
        local textureControl = WM:CreateControl(name .. "_texture", c, CT_TEXTURE)
        textureControl:SetTexture(texture)
        textureControl:SetDimensions(width, height)
        textureControl:SetAlpha(1)
        textureControl:SetAnchor(TOPLEFT, self, TOPLEFT, 0, 0)

        textureControl.timeline = ANIMATION_MANAGER:CreateTimeline()
        local animation = textureControl.timeline:InsertAnimation(ANIMATION_TEXTURE, textureControl)
        animation:SetImageData(cellWidth, cellHeight)
        animation:SetFramerate(frameRate)

        textureControl.timeline:SetEnabled(true)
        textureControl.timeline:SetPlaybackType(ANIMATION_PLAYBACK_LOOP, LOOP_INDEFINITELY)
        textureControl.timeline:PlayFromStart()

        self.textureControl = textureControl

        return self
    end

    return c
end

local function runTest(_, addonName)
    if addonName ~= "AnimationTest" then return end

    local animations = {
        test_4x1v1 = {
            width = 64,
            height = 64,
            top = -64,
            left = 64,
            texture = "AnimationTest/Dudes_64-4x1_v1.dds",
            cellWidth = 4,
            cellHeight = 1,
            frameRate = 4,
        },
        test_4x1v2 = {
            width = 64,
            height = 64,
            top = 64,
            left = 64,
            texture = "AnimationTest/Dudes_64-4x1_v2.dds",
            cellWidth = 4,
            cellHeight = 1,
            frameRate = 4,
        },
        test_2x2 = {
            width = 64,
            height = 64,
            top = 64,
            left = -64,
            texture = "AnimationTest/Dudes_64-2x2.dds",
            cellWidth = 2,
            cellHeight = 2,
            frameRate = 4,
        },
        test_5x1 = {
            width = 64,
            height = 64,
            top = -64,
            left = -64,
            texture = "AnimationTest/Dudes_64-5x1.dds",
            cellWidth = 5,
            cellHeight = 1,
            frameRate = 4,
        },
    }

    for name, props in pairs(animations) do
        makeControl(name, props.width, props.height, props.top, props.left)
            :ConfigureAnimation(props.texture, props.cellWidth, props.cellHeight, props.frameRate)
    end
end

EM:RegisterForEvent("AnimationTestInit", EVENT_ADD_ON_LOADED, runTest)
