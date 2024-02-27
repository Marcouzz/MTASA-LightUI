function addLightButton(text, color,icon)
    if icon then
        assert(icon ~= "box","Invalid icon type @ addLightButton [got"..type(icon).." '"..icon.."'']")
    end
    if type(color) == "string" then
        color = tocolor(getColorFromString(color))
    end
    color = color or tocolor(255, 255, 255)
    local table = {
        ["type"] = "button",
        ["color"] = color,
        ["text"] = text,
        ["icon"] = icon or false
    }
    window.items[#window.items+1] = table
end

function setLightButtonIcon(id,icon)
    if not id or not icon then return end
    assert(tonumber(id),"Bad argument @ setLightButtonIcon [expected number at argument 1,  got "..type(id).." '"..id.."'']")
    assert(icon ~= "box","Invalid icon type @ addLightButton [got"..type(icon).." '"..icon.."'']")
    window.items[id].icon = icon
end

function removeLightButtonIcon(id)
    if not id then return end
    assert(tonumber(id),"Bad argument @ setLightButtonIcon [expected number at argument 1,  got "..type(id).." '"..id.."'']")
    window.items[id].icon = false
end

