addEventHandler("onClientResourceStart", resourceRoot, function()
    createLightUI("Test", tocolor(38,38,38,220), tocolor(255, 255, 255), 'right', true,10)
    for i = 1, 50 do
        if (i % 2 == 0) then
            icontype = "clothing"
        else
            icontype = "ammo"
        end
        addLightCheckBox("CheckBox ["..i.."]", "#ff9800", 0)
        addLightButton("Button ["..i.."]", "#ff9800",icontype)
        addLightSwitch("Switch ["..i.."]", {"Ketchup", "Majonez"})
    end
    setTimer(function()
        setLightSwitchSelection(2,"Majonez")
    end, 2000, 1)

    setTimer(function()
        LightSetCheckBoxSelection(1, true)
    end, 1000, 1)

    setTimer(function()
        LightSetCheckBoxSelection(1, false)
    end, 3000, 1)

end)

addEventHandler("onClientAcceptSwitch", getRootElement(), function(id, value)
    print(value)
end)

addEventHandler("onClientChangeSwitch", getRootElement(), function(id, value)
    print(value)
end)

addEventHandler("onClientAcceptButton", getRootElement(), function(id, text)
    print(id, text)
end)

addEventHandler("onClientCheckBoxChange", getRootElement(), function(id, checked)
    print(checked)
end)
