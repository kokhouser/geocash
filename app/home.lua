-- Include required files
local composer = require( "composer" )
local widget = require("widget")

-- Coordinates of mid x,y and (width, Height) of all screens
local midY = display.contentCenterY
local midX = display.contentCenterX
local width = display.contentWidth
local height = display.contentHeight

----------------------------------------------------------------------------------
local scene = composer.newScene()

----------------------------------------------------------------------------------
-- 
--  NOTE:
--  
--  Code outside of listener functions (below) will only be executed once,
--  unless storyboard.removeScene() is called.
-- 
---------------------------------------------------------------------------------

---------------------------------------------------------------------------------
-- BEGINNING OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- Called when the scene's view does not exist:
function scene:create( event )
    local group = self.view

        function widget.newPanel( options )
        local customOptions = options or {}
        local opt = {}
        opt.location = customOptions.location or "left"
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
            else -- Panel on the right 
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
            else -- Panel on the right
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
    group:insert( bg )

    -- Display Elements to screen
    local NavBar = display.newRect( midX, 100, width + 30, 100 )
    -- Convert hex colors and use percentage for colors
    NavBar:setFillColor( 0,.475, .42)
    group:insert( NavBar )

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

    group:insert( MenuIcon )
    group:insert( AddIcon )
    group:insert( panel )

    local function mShow(event)
        if showTrue == "hidden" then
            panel:show()
            showTrue = "shown"
        else
            panel:hide()
            showTrue = "hidden"
        end

    end

    local options =
    {
        effect = "slideRight",
        time = 100000
    }

    -- Function to handle button events
    local function handleButtonEvent( event )

        if ( "ended" == event.phase ) then
            composer.gotoScene( "scene1" , options )
        end
    end

    -- Create the widget
    local button1 = widget.newButton
    {
        left = 100,
        top = 200,
        id = "button1",
        label = "Default",
        onRelease = handleButtonEvent
    }

    MenuIcon:addEventListener( "tap", mShow )  


    -----------------------------------------------------------------------------

    --  CREATE display objects and add them to 'group' here.
    --  Example use-case: Restore 'group' from previously saved state.

    -----------------------------------------------------------------------------

end


-- Called immediately after scene has moved onscreen:
function scene:enter( event )
    local group = self.view

    print("entered")

    -----------------------------------------------------------------------------

    --  INSERT code here (e.g. start timers, load audio, start listeners, etc.)

    -----------------------------------------------------------------------------

end


-- Called when scene is about to move offscreen:
function scene:exit( event )
    local group = self.view

    -----------------------------------------------------------------------------

    --  INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)

    -----------------------------------------------------------------------------

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroy( event )
    local group = self.view

    -----------------------------------------------------------------------------

    --  INSERT code here (e.g. remove listeners, widgets, save state, etc.)

    -----------------------------------------------------------------------------

end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "create", scene )

-- "enter" event is dispatched whenever scene transition has finished
scene:addEventListener( "enter", scene )

-- "exit" event is dispatched before next scene's transition begins
scene:addEventListener( "exit", scene )

-- "destroy" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene