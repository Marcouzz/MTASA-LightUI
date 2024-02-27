window = {
    options={}
}

local sound
local actual = 1
isLightShown = false
switch={}

-- Button Events
addEvent("onClientAcceptButton", true)

-- CheckBox Events
addEvent("onClientCheckBoxChange", true)

function createLightUI(name, color, namecolor, align, counter, scrollitems)
    if isLightShown then return false end
    if name == "" then
        assert(type(name) == string, "Bad argument @ createLightUI [expected string at argument 1,  got "..type(name).." '"..name.."'']")
    end
    if color then
        assert(tonumber(color), "Bad argument @ createLightUI [expected color at argument 4,  got "..type(color).." '"..color.."'']")
    end
    window = {}
    window.items={}
    zoom = getZoom()
    window.name = name
    local scale = scaleScreen(15, 10, 431, 107, align, "top")
    window.namepos = Vector2(unpack(scale, 1), unpack(scale, 2))
    window.namesize = Vector2(unpack(scale, 3), unpack(scale, 4))
    pos = window.namepos["x"]+(20/zoom)
    window.namealign = namealign
    window.namepos2 = Vector2(pos, window.namepos["y"]+(window.namesize["y"]/2.5))
    local scale = scaleScreen(0, 0, 431, 51, "left", "top")
    window.titlepos = Vector2(window.namepos["x"], window.namepos["y"]+window.namesize["y"])
    window.titlesize = Vector2(unpack(scale, 3), unpack(scale, 4))
    window.titlepos2 = Vector2(window.titlepos["x"]+(15/zoom), window.titlepos["y"]+(window.titlesize["y"]/2))
    
    

    window.namefont = dxCreateFont("assets/fonts/font.ttf", 28/zoom)
    window.titlefont = dxCreateFont("assets/fonts/font.ttf", 18/zoom, false)
    window.color = color or false
    window.namecolor = namecolor or tocolor(255, 255, 255)
    window.counter = counter or false
    window.scroll = scroll or false
    if not scrollitems or scrollitems > 10 or scrollitems <= 1 then
        scrollitems = 10
    end
    window.namepos3 = Vector2(window.namepos["x"]+(window.namesize["x"]-(25/zoom)), window.namepos["y"]+(window.namesize["y"]/2.5))

    local scale = scaleScreen(0,0,50,50)
    window.iconscale = Vector2(unpack(scale,3),unpack(scale,4))
    window.scrollitems = scrollitems
    bindKeys()
    isLightShown = true
    addEventHandler("onClientRender", getRootElement(), renderLight)
end

function renderLight()
    if #window.items > window.scrollitems  then
        dxDrawRoundedRectangle(window.namepos["x"], window.namepos["y"],window.namesize["x"], window.namesize["y"] + window.scrollitems * window.titlesize["y"] + (0.75*window.titlesize["y"]), 10,window.color)
    else 
        dxDrawRoundedRectangle(window.namepos["x"], window.namepos["y"],window.namesize["x"], window.namesize["y"] + #window.item * window.titlesize["y"] + (0.75*window.titlesize["y"]), 10,window.color)
    end
    if window.counter then
        dxDrawText(actual.."/"..#window.items, window.namepos3, nil, nil, window.namecolor, 0.6, window.namefont, 'right', "center")
    end
    if window.name then
        dxDrawText(window.name, window.namepos2, nil, nil, window.namecolor, 1, window.namefont, window.namealign, "center")
    end
    for i, v in pairs(window.items) do
        page = math.ceil(i/window.scrollitems)
        dxDrawText(getCurrentLightPage(), 0, 0, 0, 0)
        if i > window.scrollitems*(getCurrentLightPage()-1) and i <= window.scrollitems*getCurrentLightPage() then
            i=i-window.scrollitems*(getCurrentLightPage()-1)
            if actual-window.scrollitems*(getCurrentLightPage()-1) == i then
                color = tocolor(255, 255, 255, 48)
                textcolor = tocolor(255,255, 255)
            else
                color = tocolor(255, 255, 255, 15)
                textcolor = tocolor(255,255,255)
            end
            local pos = Vector2(window.titlepos["x"] + (25/zoom), window.titlepos["y"]+window.titlesize["y"]+((window.titlesize["y"] + (4/zoom))*(i-1)) - (1.5*window.titlesize["y"]))
            dxDrawRoundedRectangle(pos["x"], pos["y"], window.titlesize["x"]-(50/zoom), window.titlesize["y"], 5, color)
            local pos = Vector2(window.titlepos["x"]+(40/zoom), window.titlepos["y"]+window.titlesize["y"]/2+((window.titlesize["y"] + (4/zoom))*(i)) - (1.5*window.titlesize["y"]))
            dxDrawText(v.text, pos, nil, nil, textcolor, 1, window.titlefont, "left", "center")
            if v.type == "switch" then
                local pos = Vector2(window.titlepos["x"]+window.titlesize["x"]-(40/zoom), window.titlepos["y"]+window.titlesize["y"]/2+((window.titlesize["y"]+(4/zoom))*(i)) - (1.5*window.titlesize["y"]))
                local actual = tonumber(v.actual)
                dxDrawText("⮜ "..v.value[actual].." ⮞", pos, nil, nil, textcolor, 1, window.titlefont, "right", "center")
            elseif v.type == "button" and v.icon then
                local pos = Vector2(window.titlepos["x"]+window.titlesize["x"]-(60/zoom)-(25/zoom), window.titlepos["y"]+window.titlesize["y"]/2+((window.titlesize["y"]+(4/zoom))*(i-1))+(12/zoom) - (1.5*window.titlesize["y"]) + (window.iconscale["y"]/4))
                imgtype = 1
                dxDrawImage(pos,window.iconscale,"assets/icons/"..v.icon..""..imgtype..".png")
            end

            if v.type == "checkbox" then
                if v.actual == 1 then
                    checkicon = "accept"
                    imgtype = 1
                elseif v.actual == 0 then
                    checkicon = "box"
                    imgtype = 1
                end

                local pos = Vector2(window.titlepos["x"]+window.titlesize["x"]-(60/zoom)-(25/zoom), window.titlepos["y"]+window.titlesize["y"]/2+((window.titlesize["y"]+(4/zoom))*(i-1))+(12/zoom) - (1.5*window.titlesize["y"]) + (window.iconscale["y"]/4))

                dxDrawImage(pos,window.iconscale,"assets/icons/"..checkicon..""..imgtype..".png")
            
            end

            
        end
    end
end
local components = { "weapon", "ammo", "health", "clock", "money", "breath", "armour", "wanted" }

addEventHandler("onClientKey", getRootElement(), function(btn, state)
    if not isLightShown then return end
    if btn == "arrow_d" and state == true then
        cancelEvent()
    end
    if btn == "arrow_u" and state == true then
        cancelEvent()
    end
    if btn == "arrow_r" and state == true then
        cancelEvent()
    end
    if btn == "arrow_l" and state == true then
        cancelEvent()
    end
    if btn == "enter" and state == true then
        cancelEvent()
    end
end)

function bindKeys()
    bindKey("arrow_d", "up", function()
        if not isLightShown then return end
        if #window.items == 0 then return end
        if actual+1 > #window.items then
            actual = 1
        else
            actual = actual+1
        end
        playLightSound()
    end)
    bindKey("arrow_u", "up", function()
        if not isLightShown then return end
        if #window.items == 0 then return end
        if actual-1 < 1 then
            actual = #window.items
        else
            actual = actual-1
        end
        playLightSound()
    end)
    bindKey("arrow_r", "up", function()
        if not isLightShown then return end
        if #window.items == 0 then return end
        if window.items[actual].type == "switch" then
            window.items[actual].actual = window.items[actual].actual+1
            if window.items[actual].actual > #window.items[actual].value then window.items[actual].actual = 1 end
            playLightSound()
            local actualswitch = window.items[actual].actual
            local actualswitch = window.items[actual].value[tonumber(actualswitch)]
            triggerEvent("onClientChangeSwitch", localPlayer, actual, actualswitch)
        end
    end)
    bindKey("arrow_l", "up", function()
        if not isLightShown then return end
        if #window.items == 0 then return end
        if window.items[actual].type == "switch" then
            window.items[actual].actual = window.items[actual].actual-1
            if window.items[actual].actual < 1 then window.items[actual].actual = #window.items[actual].value end
            local actualswitch = window.items[actual].actual
            local actualswitch = window.items[actual].value[tonumber(actualswitch)]
            triggerEvent("onClientChangeSwitch", localPlayer, actual, actualswitch)
            playLightSound()
        end
    end)
    bindKey("enter", "up", function()
        if not isLightShown then return end
        if #window.items == 0 then return end
        if window.items[actual].type == "switch" then
            local actualswitch = window.items[actual].actual
            local actualswitch = window.items[actual].value[tonumber(actualswitch)]
            triggerEvent("onClientAcceptSwitch", localPlayer, actual, actualswitch)
        end
        if window.items[actual].type == "button" then
            local btntext = window.items[actual].text
            triggerEvent("onClientAcceptButton", localPlayer, actual, btntext)
        end
        if window.items[actual].type == "checkbox" then
            if window.items[actual].actual == 1 then 
                window.items[actual].actual = 0
                triggerEvent("onClientCheckBoxChange", localPlayer, actual, false)
            else
                window.items[actual].actual = 1
                triggerEvent("onClientCheckBoxChange", localPlayer, actual, true)
            end
        end
    end)
end

function playLightSound()
    sound = playSound("assets/change.wav", false)
end

function getCurrentLightPage()
    local currentpage = math.ceil(actual/window.scrollitems)
    return currentpage
end

function clearLightUI()
    window.items = {}
    actual = 0
end

function removeLightItem(id)
    table.remove(window.items, id)
end

function removeLightUI()
    removeEventHandler("onClientRender",getRootElement(),renderLight)
    window = {}
    window.items = {}
    actual = 0
    isLightShown = false
end

function dxDrawRoundedRectangle(x, y, width, height, radius, color, postGUI, subPixelPositioning)
    
    dxDrawRectangle(x+radius, y+radius, width-(radius*2), height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawCircle(x+radius, y+radius, radius, 180, 270, color, color, 16, 1, postGUI)
    dxDrawCircle(x+radius, (y+height)-radius, radius, 90, 180, color, color, 16, 1, postGUI)
    dxDrawCircle((x+width)-radius, (y+height)-radius, radius, 0, 90, color, color, 16, 1, postGUI)
    dxDrawCircle((x+width)-radius, y+radius, radius, 270, 360, color, color, 16, 1, postGUI)
    dxDrawRectangle(x, y+radius, radius, height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y+height-radius, width-(radius*2), radius, color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+width-radius, y+radius, radius, height-(radius*2), color, postGUI, subPixelPositioning)
    dxDrawRectangle(x+radius, y, width-(radius*2), radius, color, postGUI, subPixelPositioning)
end