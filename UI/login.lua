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

	local group = self.view
	local mainGroup = display.newGroup()

	local function onUsername( event )
	    if ( "began" == event.phase ) then
	        -- This is the "keyboard appearing" event.
	        -- In some cases you may want to adjust the interface while the keyboard is open.

	    elseif ( "submitted" == event.phase ) then
	        -- Automatically tab to password field if user clicks "Return" on virtual keyboard.
	        native.setKeyboardFocus( passwordField )
	    end
	end

	local function onPassword( event )
	    -- Hide keyboard when the user clicks "Return" in this field
	    if ( "submitted" == event.phase ) then
	        native.setKeyboardFocus( nil )
	    end
	end

	local usernameField = native.newTextField( midX, midY- 100, 2/3*width, 120 )
	usernameField.font = native.newFont( native.systemFontBold, 24 )
	usernameField.inputType = "email"
	usernameField.placeholder = " Username "
	usernameField:setTextColor( 0.4, 0.4, 0.8 )
	usernameField:addEventListener( "userInput", onUsername )

	local passwordField = native.newTextField( midX, midY+40, 2/3*width, 120 )
	passwordField.font = native.newFont( native.systemFontBold, 24 )
	passwordField.inputType = "default"
	passwordField.placeholder = " Password "
	passwordField.isSecure = true
	passwordField:setTextColor( 0.4, 0.4, 0.8 )
	passwordField:addEventListener( "userInput", onPassword )

	local submit = display.newRect(midX, midY+200,  2/3*width, 100)
	

	-- Function to handle button events
	local function Signuphere( event )
	local options =
	{

		effect = "fromBottom",
	    time = 400


	-----------------------------------------------
	-- 		params (optional)
	-- Table. An optional table containing any kind of custom data that should be transferred to the scene. 
	-- In the specified scene, this data can be accessed via event.params in the create event or show event.\
	--params = {
		    --     sampleVar1 = "my sample variable",
		    --     sampleVar2 = "another sample variable"
		    -- }
	-----------------------------------------------
	    
	}
	    if ( "ended" == event.phase ) then
	    	mainGroup.isVisible = false
	        composer.gotoScene( "Register" , options)
	    end  

	end

	local function loginhere( event )
		local options2 =
		{

			effect = "fromRight",
		    time = 500
		}
	    if ( "ended" == event.phase ) then
	    	mainGroup.isVisible = false
	        
	    sendInfo = {["email"] = usernameField.text, ["password"] = passwordField.text }
	    
	    print (sendInfo)

	    local function networkListener(event)
	    	if (event.isError) then
	    		print("Network Error!")
	    	elseif event.response == "Error logging in." then
	    		print("Wrong User/Pass.")
	    	else
	    		print ("Response: " ..event.response )
	    		composer.gotoScene( "home" , options)
	    	end
	    end

	    local headers = {
	    	["Content-Type"] = "application/json"
		}

		local params = {}
		params.headers=headers
		params.body=json.encode( sendInfo )

		print ( "params.body: "..params.body )

		network.request( "http://geocash.elasticbeanstalk.com/login", "POST", networkListener, params)
	end
	end


	local login = widget.newButton
	{
	    x = midX,
	    y = midY+200,
	    width= width,
	    height = 100,
	    id = "login",
	    label = "Login",
	    labelAlign = "center",
	    labelColor = { default={ black }, over={ black } },
	    fontSize = 50,
	    onRelease = loginhere
	}

	
	local Register = widget.newButton
	{
	    x = midX,
	    y = midY+320,
	    width= width,
	    height = 100,
	    id = "Register",
	    label = "Not yet registered?",
	    labelAlign = "center",
	    labelColor = { default={ 0, .50, 1 }, over={ 1,1,1 } },
	    fontSize = 50,
	    onRelease = Signuphere
	}

	mainGroup:insert(usernameField)
	mainGroup:insert(passwordField)
	mainGroup:insert(submit)
	mainGroup:insert(login)
	mainGroup:insert(Register)
	group:insert(mainGroup)
	mainGroup.alpha = 0
	transition.to( mainGroup, { time=1000, alpha=1 } )


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