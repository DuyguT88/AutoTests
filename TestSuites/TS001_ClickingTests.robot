*** Settings ***
Library    SeleniumLibrary
Resource   ../Resources/ClickResources.robot
Resource   ../Resources/Login.robot
Resource   ../Resources/PageControls.robot
Variables  ../Variables/enviroment.py

Test Setup   Preconditions
Test Teardown   Teardowns

*** Variables ***
${buttonName}   Button That Ignores DOM Click Event
${rgbaBlue}   rgba(0, 123, 255, 1)
${rgbaGreen}  rgba(33, 136, 56, 1)

*** Test Cases ***
TS001_Test_1: Check if the button before and after the click
   Given The button is visible with the expected color  ${buttonName}  ${rgbaBlue}
   When Click on the button  ${buttonName}
   Then The button is visible with the expected color  ${buttonName}  ${rgbaGreen}

*** Keywords ***
Preconditions
   Open the web page    ${URL}   ${BROWSER}
   Click on the scenario name   Click

Teardowns
   Run Keyword If Test Failed    Capture Page Screenshot
   Close Browser




