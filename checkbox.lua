function addLightCheckBox(text, color, check)
    if type(color) == "string" then
        color = tocolor(getColorFromString(color))
    end
    color = color or tocolor(255, 255, 255)
    local table = {
        ["type"] = "checkbox",
        ["color"] = color,
        ["text"] = text,
        ["actual"] = check
    }
    window.items[#window.items+1] = table
end

function LightSetCheckBoxSelection(id, selection)
    if not id or not selection then return end
    assert(tonumber(id),"Bad argument @ LightSetCheckBoxSelection [expected number at argument 1,  got "..type(id).." '"..id.."'']")
    if not selection then
        selection = 0
    else
        selection = 1
    end
    if window.items[id].type == "checkbox" then 
        window.items[id].actual = selection
    end
end

function LightGetCheckBoxSelection(id)
    if not id then return end
    assert(tonumber(id),"Bad argument @ LightSetCheckBoxSelection [expected number at argument 1,  got "..type(id).." '"..id.."'']")
    if window.items[id].type == "checkbox" then 
        if window.items[id].actual == 1 then 
            return true
        else
            return false
        end
    else
        return false
    end
end
