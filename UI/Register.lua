local composer = require( "composer" )
local widget = require("widget")

-- Coordinates of mid x,y and (width, Height) of all screens
local midY = display.contentCenterY
local midX = display.contentCenterX
local width = display.contentWidth
local height = display.contentHeight
local nUser = 0

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

    local regTex = display.newText( " Register ", midX, midY - 200, native.systemFont, 100 )

    local function inputListener( event )
        if event.phase == "began" then
            -- user begins editing textBox
            -- print( event.text )

        elseif event.phase == "ended" then
            -- do something with textBox text
            -- event.target.text 

        -- elseif event.phase == "editing" then
        
        end
    end

    local bg = display.newRect( midX, midY, width, height )
    bg:setFillColor( 1,1,1 )
    bg.alpha = 0.6

    local usernameField = native.newTextField( midX, midY, 2/3*width, 60 )
    usernameField.font = native.newFont( native.systemFontBold, 24 )
    usernameField.inputType = "email"
    usernameField.placeholder = " e-mail@gmail.com "
    usernameField:setTextColor( 0.4, 0.4, 0.8 )
    -- usernameField:addEventListener( "userInput", onUsername )

    local passwordField = native.newTextField( midX, midY+80, 2/3*width, 60 )
    passwordField.font = native.newFont( native.systemFontBold, 24 )
    passwordField.inputType = "default"
    passwordField.placeholder = " Password "
    passwordField.isSecure = true
    passwordField:setTextColor( 0.4, 0.4, 0.8 )
    -- passwordField:addEventListener( "userInput", onPassword )

    -- local passwordField2 = native.newTextField( midX, midY, 2/3*width, 60 )
    -- passwordField.font = native.newFont( native.systemFontBold, 24 )
    -- passwordField.inputType = "default"
    -- passwordField.placeholder = "Confirm Password "
    -- passwordField.isSecure = true
    -- passwordField:setTextColor( 0.4, 0.4, 0.8 )
    -- --passwordField:addEventListener( "userInput", onPassword )

    local function SubForm( event )
        local optionsw =
        {

            effect = "fromRight",
            time = 500
        }

        if ( "ended" == event.phase ) then
            
            -- mainGroup.isVisible = false
            composer.gotoScene( "home" , options)
        end  
    end

    local rSub = display.newRect(midX, midY+200,  2/3*width, 60)
    local rSubBut = widget.newButton
    {
        x = midX,
        y = midY+200,
        width= 2/3*width,
        height = 60,
        id = "rSubBut",
        label = "Sign up",
        labelAlign = "center",
        labelColor = { default={ black }, over={ black } },
        fontSize = 30,
        onRelease = SubForm
    }

    group:insert( regTex )
    group:insert( rSub )
    group:insert( rSubBut )
    group:insert( usernameField )
    group:insert( passwordField )
    --group:insert( passwordField2 )
    group:insert( bg )
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