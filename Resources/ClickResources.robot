*** Settings ***
Library    SeleniumLibrary
Library    String
Variables  ../Variables/enviroment.py

*** Keywords ***
Click on the scenario name
   [Arguments]   ${hyperlink_name}
   Click Element  //a[@href="/click"]

Get CSS Property Value
    [Documentation]
    ...    Get the CSS property value of an Element.
    ...
    ...    This keyword retrieves the CSS property value of an element. The element
    ...    is retrieved using the locator.
    ...
    ...    Arguments:
    ...    - locator           (string)    any Selenium Library supported locator xpath/css/id etc.
    ...    - property_name     (string)    the name of the css property for which the value is returned.
    ...
    ...    Returns             (string)    returns the string value of the given css attribute or fails.
    ...
    [Arguments]    ${locator}    ${attribute name}
    ${css}=         Get WebElement    ${locator}
    ${prop_val}=    Call Method       ${css}    value_of_css_property    ${attribute name}
    [Return]     ${prop_val}

The button is visible with the expected color
  [Arguments]   ${buttonName}  ${expectedColor}
  ${actualColor}=  Get CSS Property Value   //button[text()="${buttonName}"]   background-color
  Should Be Equal As Strings    ${expectedColor}    ${actualColor}