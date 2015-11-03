-- Coordinates of mid x,y and (width, Height) of all screens
local midY = display.contentCenterY
local midX = display.contentCenterX
local width = display.contentWidth
local height = display.contentHeight

-- Include required files
local widget = require("widget")
function widget.newPanel( options )
    local customOptions = options or {}
    local opt = {}
    opt.location = customOptions.location or "left"
    -- local default_width, default_height
    -- if ( opt.location == "top" or opt.location == "bottom" ) then
    --     default_width = width
    --     default_height = height * 0.33
    -- else
    --     default_width = width * 0.33
    --     default_height = height
    -- end
    opt.width = customOptions.width or width - (width/2) +160
    opt.height = customOptions.heigh or height - 130
    opt.speed =  500
    opt.inEasing = customOptions.inEasing or easing.linear
    opt.outEasing = customOptions.outEasing or easing.linear
    if ( customOptions.onComplete and type(customOptions.onComplete) == "function" ) then
        opt.listener = customOptions.onComplete
    else 
        opt.listener = nil
    end
    local container = display.newContainer( opt.width, opt.height )
    if ( opt.location == "left" ) then
        container.anchorX = 1.0
        container.x = display.screenOriginX
        container.anchorY = 0.5
        container.y = display.contentCenterY+85
    elseif ( opt.location == "right" ) then
        container.anchorX = 0.0
        container.x = display.actualContentWidth
        container.anchorY = 0.5
        container.y = display.contentCenterY
    end
    function container:show()
        local options = {
            time = opt.speed,
            transition = opt.inEasing
        }
        if ( opt.listener ) then
            options.onComplete = opt.listener
            self.completeState = "shown"
        end
        if ( opt.location == "left" ) then
            options.x = display.screenOriginX + opt.width
        else
            options.x = display.actualContentWidth - opt.width
        end 
        transition.to( self, options )
    end
    function container:hide()
        local options = {
            time = opt.speed,
            transition = opt.outEasing
        }
        if ( opt.listener ) then
            options.onComplete = opt.listener
            self.completeState = "hidden"
        end
        if ( opt.location == "left" ) then
            options.x = display.screenOriginX
        else
            options.x = display.actualContentWidth
        end 
        transition.to( self, options )
    end
    return container
end

local showTrue = "hidden"

-- Background
local bg = display.newRect( midX, midY+50, width, height - 100 )
bg:setFillColor( .886, .875, .882 )
-- Display Elements to screen
local NavBar = display.newRect( midX, 100, width + 30, 100 )
-- Convert hex colors and use percentage for colors
NavBar:setFillColor( 0,.475, .42)

local MenuIcon = display.newImage( "img/ic_menu.png", 50, 100)
local AddIcon = display.newImage( "img/ic_add.png", width - 50, 100)

local panel = widget.newPanel{
    location = "left",
    onComplete = panelTransDone,
    width = width*0.65,
    height = height*0.65,
    speed = 250,
    inEasing = easing.outQuint,
    outEasing = easing.outCubic
}

panel.background = display.newRect( 0, 0, panel.width, panel.height )
panel.background:setFillColor( .698, .875, .859 )
panel:insert( panel.background )

panel.title = display.newText( "menu", 0, 200 - midY, native.systemFontBold, 100 )
panel.title:setFillColor( 1, 1, 1 )
panel:insert( panel.title )

local function mShow(event)
	if showTrue == "hidden" then
		panel:show()
		showTrue = "shown"
	else
		panel:hide()
		showTrue = "hidden"
	end

end

MenuIcon:addEventListener( "tap", mShow )
