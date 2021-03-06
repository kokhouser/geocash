-- Include required files
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
local back = false
local myMap

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
function scene:show(event)
    local group = self.view
    myMap.x = midX
    myMap.y = midY
    if event.params ~= nil and event.params.latitude ~= nil then
        local options = 
        { 
            title = decoded.objects[i].name, 
            subtitle = decoded.objects[i].description, 
        }
        local result, errorMessage = myMap:addMarker(tonumber(event.params.latitude), tonumber(event.params.longitude), options )
        if ( result ) then
            print( "Marker added" )
        else
            print( errorMessage )
        end
    end
end

-- Called when the scene's view does not exist:
function scene:create( event )
    local group = self.view
    myMap = native.newMapView( midX, midY, display.contentWidth, display.contentHeight-400 )
---------------------------------------------------------------------------------
-- SlideMenu Effect
---------------------------------------------------------------------------------

        local options =
        {
            effect = "slideLeft",
            time = 400,
            params = {username = event.params.username}
        }


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

---------------------------------------------------------------------------------
-- Function ends
-- -- --
-- Create main scene objects and icon effect functions
---------------------------------------------------------------------------------
     local bgGroup = display.newGroup( )
    -- Background
    -- local bg = display.newRect( midX, midY+50, width, height - 100 )
    -- bg:setFillColor( .886, .875, .882 )
    -- group:insert( bg )

    -- Display Elements to screen
    local NavBar = display.newRect( midX, 100, width + 30, 100 )
    -- Convert hex colors and use percentage for colors
    NavBar:setFillColor( 0,.475, .42)

    local MenuIcon = display.newImage( "Img/ic_menu.png", 50, 100)
    local AddIcon = display.newImage( "Img/ic_add.png", width - 50, 100)
    local backArrow = display.newImage( "Img/ic_arrow_back.png", -50, 100 )
    bgGroup:insert(MenuIcon)
    bgGroup:insert(AddIcon)
    bgGroup:toFront( )

    function backArrow:touch( event )
        if event.phase == "ended" then
            composer.gotoScene( "home" , options )
            myMap.alpha = 1 
            if back == true then
                MenuIcon.isVisible = true
                transition.to( MenuIcon, { x = MenuIcon.x + 200, time=500 } )
                transition.to( backArrow, { x = backArrow.x - 100, time=500 } )
                backArrow.isVisible = false
                back = false
                AddIcon.isVisible = true

            end
        end
    end

    function AddIcon:touch( event )
        if event.phase == "ended" then
            panel:hide()
            myMap.x = -500
            myMap.y = -500
            composer.gotoScene( "Add" , options )
            myMap.alpha = 0 
            if back == false then
                backArrow.isVisible = true
                transition.to( MenuIcon, { x = MenuIcon.x - 200, time=500 } )
                MenuIcon.isVisible = false
                transition.to( backArrow, { x = backArrow.x + 100, time=500 } )
                back = true                
                AddIcon.isVisible = false
            end
        end
    end

    AddIcon:addEventListener( "touch", AddIcon )
    backArrow:addEventListener( "touch", backArrow )
---------------------------------------------------------------------------------
-- End
-- -- -- 
-- Menu Content
---------------------------------------------------------------------------------

    panel = widget.newPanel{
        location = "left",
        onComplete = panelTransDone,
        width = width*0.65,
        height = display.contentHeight,
        speed = 250,
        inEasing = easing.outQuint,
        outEasing = easing.outCubic
    }
    -- Grouping related objects together
    local mGroup = display.newGroup( )
    local accGroup = display.newGroup( )
    local dblvl = 1

    --local accIMG = "Img/acc.png"
    panel.background = display.newRect( 0, 0, panel.width, panel.height )
    panel.background:setFillColor( .698, .875, .859 )
    accGroup:insert( panel.background )

    panel.accBg = display.newRect( 0, 180 - midY, panel.width, 250 )
    panel.accBg:setFillColor( 0,.59,.53 )
    accGroup:insert( panel.accBg )

    --panel.accPic = display.newImageRect( accIMG, 100, 100 )
    --panel.accPic.x = -180
    --panel.accPic.y = -480
    --accGroup:insert( panel.accPic )

    local name = event.params.username
    panel.accName = display.newText( name , 40, -510, native.systemFontBold, 45 )
    panel.accName:setFillColor( .33,.33,.33 )
    accGroup:insert( panel.accName )

    local level = "level "..dblvl
    panel.Level = display.newText( level , 40, -460, native.systemFont, 35 )
    panel.Level:setFillColor( .33,.33,.33 )
    accGroup:insert( panel.Level )

    panel.icon1 = display.newImage( "Img/ic_person.png", -180, -270)-- display.newRect( -180, -270, 50, 50 )
    
    panel.tap1 = display.newRect( 0, -290, panel.width, 150 )
    panel.tap1.alpha = 0
    panel.des1 = display.newText( "Friends Nearby", 50, -270, native.systemFont, 30 )
    panel.des1:setFillColor( .33,.33,.33 )
    
    panel.icon2 = display.newImage( "Img/ic_location.png", -180, -130)-- display.newRect( -180, -170, 50, 50 )
    panel.tap2 = display.newRect( 0, -150, panel.width, 130 )
    panel.tap2.alpha = 0
    panel.des2 = display.newText( "Location", 50, -130, native.systemFont, 30 )
    panel.des2:setFillColor( .33,.33,.33 )
    
    panel.icon3 = display.newImage( "Img/ic_settings.png", -180, 0)-- display.newRect( -180, -70, 50, 50 )
    panel.tap3 = display.newRect( 0, -20, panel.width, 130 )
    panel.tap3.alpha = 0
    panel.des3 = display.newText( "Settings", 50, 0, native.systemFont, 30 )
    panel.des3:setFillColor( .33,.33,.33 )

    mGroup:insert( panel.icon1 )
    mGroup:insert( panel.tap1 )
    mGroup:insert( panel.tap2 )
    mGroup:insert( panel.tap3 )
    mGroup:insert( panel.des1 )
    mGroup:insert( panel.icon2 )
    mGroup:insert( panel.des2 )
    mGroup:insert( panel.icon3 )
    mGroup:insert( panel.des3 )
    panel:insert( accGroup )
    panel:insert( mGroup )
    
---------------------------------------------------------------------------------
-- END
-- -- --
-- Slide menu control function
---------------------------------------------------------------------------------

    local function mShow(event)
        if showTrue == "hidden" then
            panel:show()
            myMap.alpha=0
            showTrue = "shown"
        else
            myMap.alpha=1
            panel:hide()
            showTrue = "hidden"
        end

    end
    
    local function locationHandler( event, decoded )

        local currentLocation = myMap:getUserLocation()
        print ("First Here!")
        if ( currentLocation.errorCode or ( currentLocation.latitude == 0 and currentLocation.longitude == 0 ) ) then
            print ("Second here!!")
            locationText.text = currentLocation.errorMessage

            attempts = attempts + 1

            if ( attempts > 10 ) then
                native.showAlert( "No GPS Signal", "Can't sync with GPS.", { "Okay" } )
            else
                timer.performWithDelay( 1000, locationHandler )
            end
        else
            --locationText.text = "Current location: " .. currentLocation.latitude .. "," .. currentLocation.longitude
            print ("Here!")
            myMap:setCenter( currentLocation.latitude, currentLocation.longitude )
        end
    end

    local function networkListener( event )

        if ( event.isError ) then
            print( "Network error!" )
        else
            --print ( "RESPONSE: " .. event.response )
            local decoded, pos, msg = json.decode( event.response )
            if not decoded then
                print( "Decode failed at "..tostring(pos)..": "..tostring(msg) )
            else
                myMap.mapType = "standard"
                --print (decoded.num_results)
                local numCache = decoded.num_results
                print (numCache)
                for i=1, numCache, 1 do
                    print (i)
                    local options = 
                    { 
                        title = decoded.objects[i].name, 
                        subtitle = decoded.objects[i].description, 
                    }
                    print (decoded.objects[i].latitude)
                    local result, errorMessage = myMap:addMarker(tonumber(decoded.objects[i].latitude), tonumber(decoded.objects[i].longitude), options )
                    if ( result ) then
                        print( "Marker added" )
                    else
                        print( errorMessage )
                    end
                end
                locationHandler(decoded)

            end
        end
    end
    network.request( "http://geocash.elasticbeanstalk.com/geocaches", "GET", networkListener )

    MenuIcon:addEventListener( "tap", mShow )  

---------------------------------------------------------------------------------
-- End
---------------------------------------------------------------------------------

end


-- Called when scene is about to move offscreen:
function scene:hide( event )
    local group = self.view


end


--Called prior to the removal of scene's "view" (display group)
function scene:destroy( event )
    local group = self.view

end

---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "create", scene )

-- "enter" event is dispatched whenever scene transition has finished
scene:addEventListener( "show", scene )

-- "exit" event is dispatched before next scene's transition begins
scene:addEventListener( "hide", scene )

-- "destroy" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroy", scene )

---------------------------------------------------------------------------------

return scene