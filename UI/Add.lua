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
    
    local bg = display.newRect(midX, midY+80, width, height - 140)
    bg:setFillColor( .886, .875, .882  )

    local TitleText = display.newText( "TITLE", 200, 250, native.systemFontBold, 70 )
    TitleText:setFillColor( Black )

    local TitleField = native.newTextField( midX - 70, 400, 2/3*width, 120 )
    TitleField.font = native.newFont( native.systemFontBold, 24 )
    TitleField.inputType = "email"
    TitleField.placeholder = " Username "
    TitleField:setTextColor( 0.4, 0.4, 0.8 )
    -- TitleField:addEventListener( "userInput", onUsername )

    local function inputListener( event )
        if event.phase == "began" then
            -- user begins editing textBox
            print( event.text )

        elseif event.phase == "ended" then
            -- do something with textBox text
            print( event.target.text )

        elseif event.phase == "editing" then
            print( event.newCharacters )
            print( event.oldText )
            print( event.startPosition )
            print( event.text )
        end
    end

    local DescText = display.newText( "Description", 300, midY-300, native.systemFontBold, 70 )
    DescText:setFillColor( Black )

    local DescriptionBox = native.newTextBox( midX+20, midY, 2.5/3*width, 400 )
    DescriptionBox.text = ""
    DescriptionBox.isEditable = true
    DescriptionBox:addEventListener( "userInput", inputListener )


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