local composer = require( "composer" )
local widget = require("widget")
local json = require("json")

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
        local options =
    {
        effect = "slideLeft",
        time = 400,
        params = event.params.username
    }
    local group = self.view
    local currentLat = 0
    local currentLong = 0
    local bg = display.newRect(midX, midY+80, width, height - 140)
    bg:setFillColor( .886, .875, .882  )

    local TitleText = display.newText( "Cache Name", display.contentWidth/2, display.contentHeight/5, native.systemFontBold, 70 )
    TitleText:setFillColor( Black )

    local TitleField = native.newTextField( display.contentWidth/2, display.contentHeight/5 + 100, 3/4*width, 120 )
    TitleField.font = native.newFont( native.systemFontBold, 30 )
    TitleField.inputType = "default"
    TitleField:setTextColor( 0.4, 0.4, 0.8 )
    TitleField.text = ""


    local DescText = display.newText( "Description", display.contentWidth/2, 2*display.contentHeight/5 - 50, native.systemFontBold, 70 )
    DescText:setFillColor( Black )

    local DescriptionBox = native.newTextBox( display.contentWidth/2, 2*display.contentHeight/5 + 150, 2.3/3*width, 300 )
    DescriptionBox.text = ""
    DescriptionBox.isEditable = true

    local LatText = display.newText( "Latitude", display.contentWidth/4, 3*display.contentHeight/5 + 80, native.systemFontBold, 50 )
    LatText:setFillColor( Black )

    local LatField = native.newTextField( display.contentWidth/4, 3*display.contentHeight/5 + 150, 1/4*width, 80 )
    LatField.font = native.newFont( native.systemFontBold, 30 )
    LatField.inputType = "default"
    LatField:setTextColor( 0.4, 0.4, 0.8 )
    LatField.text = ""

    local LongText = display.newText( "Latitude", 3*display.contentWidth/4, 3*display.contentHeight/5 + 80, native.systemFontBold, 50 )
    LongText:setFillColor( Black )

    local LongField = native.newTextField( 3*display.contentWidth/4, 3*display.contentHeight/5 + 150, 1/4*width, 80 )
    LongField.font = native.newFont( native.systemFontBold, 30 )
    LongField.inputType = "default"
    LongField:setTextColor( 0.4, 0.4, 0.8 )
    LongField.text = ""

    local locationHandler = function( event )

    -- Check for error (user may have turned off location services)
    if ( event.errorCode ) then
            native.showAlert( "GPS Location Error", event.errorMessage, {"OK"} )
            print( "Location error: " .. tostring( event.errorMessage ) )
        else
            currentLat = event.latitude
            currentLong = event.longitude
            LatField.text = currentLat
            LongField.text = currentLong
        end
    end
    

    local function onComplete( event )
       if event.action == "clicked" then
            local i = event.index
            if i == 1 then
                composer.gotoScene( "home" , options)
            end
        end
    end

    local function networkListener(event)
        if (event.isError) then
            print("Network Error!")
        else
            print ("Response: " ..event.response )
            local alert = native.showAlert( "Success", "Cache Added!", {"OK"}, onComplete )
        end
    end

    local function submitCache (event)
        print ("Submit pressed!")
        if ( "ended" == event.phase ) then
            sendInfo = {["name"] = TitleField.text, ["description"] = DescriptionBox.text, ["latitude"] = LatField.text, ["longitude"] = LongField.text }
            print (sendInfo)
            local headers = {
                ["Content-Type"] = "application/json"
            }

            local params = {}
            params.headers=headers
            params.body=json.encode( sendInfo )

            print ( "params.body: "..params.body )

            network.request( "http://geocash.elasticbeanstalk.com/geocaches/add", "POST", networkListener, params)
        end
    end

    local CHOSENBUTTON = widget.newButton{
        x = midX,
        y = 3*display.contentHeight/4 + 100,
        width= 2/3*width,
        height = 100,
        onEvent = submitCache,
        labelAlign = "center",
        labelColor = { default={ 0, .50, 1 }, over={ 1,1,1 } },
        fontSize = 50,
        label = "Submit"
    }

    group:insert(bg)
    group:insert(TitleText)
    group:insert(TitleField)
    group:insert(DescText)
    group:insert(DescriptionBox)
    group:insert(LatField)
    group:insert(LatText)
    group:insert(LongField)
    group:insert(LongText)
    group:insert(CHOSENBUTTON)

    -----------------------------------------------------------------------------

    --  CREATE display objects and add them to 'group' here.
    --  Example use-case: Restore 'group' from previously saved state.

    -----------------------------------------------------------------------------
    Runtime:addEventListener( "location", locationHandler )

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