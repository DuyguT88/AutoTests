*** Settings ***
Library    SeleniumLibrary
Resource   ../../Resources/UI_Resources/ClickActions.robot
Resource   ../../Resources/UI_Resources/Generic.robot
Resource   ../../Resources/UI_Resources/PageObjects/MainPage.robot
Resource  ../../TestData/Variables/enviroment.resource

Test Setup   Preconditions
Test Teardown   Teardowns
Default Tags   UI   ClickFunction

*** Variables ***
${buttonName}   Button That Ignores DOM Click Event
${rgbaBlue}   rgba(0, 123, 255, 1)
${rgbaGreen}  rgba(40, 167, 69, 1)

*** Test Cases ***
UI_TS001_Test_1: Check if the color of button before and after the click
   Given The button is visible with the expected color  buttonName=${buttonName}  expectedColor=${rgbaBlue}
   When Click on the button  buttonName=${buttonName}
   Then The button is visible with the expected color  buttonName=${buttonName}  expectedColor=${rgbaGreen}

*** Keywords ***
Preconditions
   Open the web page   url=${WEB_URL}   browser=${BROWSER}
   Click on the scenario name   hyperlink_name=Click

Teardowns
   Run Keyword If Test Failed    Capture Page Screenshot
   Close Browser