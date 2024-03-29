# MTASA-LightUI
This is an edited version of NativeUI called LightUI

NativeUI: https://github.com/Allerek/MTASA-NativeUI



**Screen:**

![Menu Image](https://github.com/Marcouzz/MTASA-LightUI/blob/main/menuimg.png)

## Client Functions

## Menu


**createLightUI**


Description:

*This function will create a menu*

Parameters:

 - string Menu Title
 -  color Menu color(if image passed **false**)
 -  color Title color
 - bool Show counter
 - int Quantity of items per page **Recommended 10, Maximum 10**
 - string Position that the menu title will be **Possible positions right, left, center**

**clearLightUI**

Description:
*This function will remove all menu items.*

Parameters:

*This function has no parameters*

**removeLightItem**

Description:
*This function will remove the item from the specified id.*

Parameters:

 - int Item ID

**removeLightUI**

Description:
*This function will remove the menu.*

Parameters:

*This function has no parameters*

## Button

**addLightButton**

Description:
*This function will create a button*

Parameters:

 - string Button Title
 - color Button title color
 - string Button icon **Possible icons accept, ammo, armour, art, barber, clothing**

**setLightButtonIcon**

Description:
*This function will set the icon of the specified button.*

Parameters:

 - int Button ID
 - string Button icon **Possible icons accept, ammo, armour, art, barber, clothing**

**removeLightButtonIcon**

Description:
*This function will remove the icon from the specified button.*

Parameters:

- int Button ID

## Checkbox

**addLightCheckBox**

Description:
*This function will create a checkbox*

Parameters:

 - string Checkbox Title
 - color Checkbox Title Color
 - bool Set whether the check box is selected or cleared by default.

**LightSetCheckBoxSelection**

Description:
*This function will set the tick box to be checked or unchecked.*

Parameters:

 - int Checkbox ID
 - bool Checked or unchecked

**LightGetCheckBoxSelection**

Description:
*This function returns whether the check box is selected or not.*

Parameters:

 - int Checkbox ID

## Switch

**addLightSwitch**

Description:
*This function will create a switch*

Parameters:

 - string Switch Title
 - table A table with switch values
 - color Switch title color

**getSwitchText**

Description:
*This function will return the selected switch value.*

Parameters:
	
- int Switch ID

**setLightSwitchSelection**

Description:
*This function will set the value of the switch.*

Parameters:

 - Switch ID
 - int/string Switch value **This value must have in the table when creating the switch**

## Client Events

## Button

**onClientAcceptButton**

Description:
*This event is triggered when the player presses the "enter" key on any button.*

```lua
addEventHandler("onClientAcceptButton", getRootElement(), function(id, text)

	print(id, text)

end)
```

## Switch

**onClientAcceptSwitch**

Description:  
*This event is triggered when the player presses the “enter” key on any switch.*

```lua
addEventHandler("onClientAcceptSwitch", getRootElement(), function(id, value)
    print(value)
end)
```

**onClientChangeSwitch**

Description:  
*This event is triggered every time the switch value changes*

```lua
addEventHandler("onClientChangeSwitch", getRootElement(), function(id, value)
    print(value)
end)
```
## CheckBox
**onClientCheckBoxChange**

Description:  
*This event is triggered every time the check box is checked or unchecked.*

```lua
addEventHandler("onClientCheckBoxChange", getRootElement(), function(id, checked)
    print(checked)
end)
```
