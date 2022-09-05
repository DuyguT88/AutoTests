*** Settings ***
Library    SeleniumLibrary
Library    String
Resource   Generic.robot
Resource  ../../TestData/Variables/enviroment.resource

*** Keywords ***
The button is visible with the expected color
   [Arguments]   ${buttonName}  ${expectedColor}
   ${element_xpath}=  Set Variable  xpath=//button[text()="${buttonName}"]
   Mouse Out   locator=${element_xpath}
   ${actualColor}=  Get CSS Property Value   ${element_xpath}   background-color
   Should Be Equal As Strings    first=${expectedColor}    second=${actualColor}

Click on the button
   [Arguments]   ${buttonName}
   ${button_xpath}=  Set Variable  //button[text()="${buttonName}"]
   Wait Until Element Is Visible  ${button_xpath}
   Click Element   ${button_xpath}
   Mouse Out    ${button_xpath}