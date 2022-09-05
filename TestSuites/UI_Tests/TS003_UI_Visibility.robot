*** Settings ***
Library    SeleniumLibrary
Resource   ../../Resources/UI_Resources/PageObjects/MainPage.robot
Resource   ../../Resources/UI_Resources/Generic.robot
Resource   ../../Resources/UI_Resources/ClickActions.robot
Resource   ../../Resources/UI_Resources/PageObjects/VisibilityPage.robot
Resource  ../../TestData/Variables/enviroment.resource

Test Setup   Preconditions
Test Teardown   Teardowns
Default Tags   UI   Visibility

*** Test Cases ***
UI_TS003_Test_1: Check if all buttons visible after clicking on Hide button
   Given The button is visible with the expected color   buttonName=Hide    expectedColor=rgba(0, 123, 255, 1)
   And The button is visible with the expected color   buttonName=Removed   expectedColor=rgba(220, 53, 69, 1)
   And The button is visible with the expected color   buttonName=Zero Width  expectedColor=rgba(255, 193, 7, 1)
   And The button is visible with the expected color   buttonName=Overlapped  expectedColor=rgba(40, 167, 69, 1)
   And The button is visible with the expected color   buttonName=Opacity 0   expectedColor=rgba(23, 162, 184, 1)
   And The button is visible with the expected color   buttonName=Visibility Hidden    expectedColor=rgba(23, 162, 184, 1)
   And The button is visible with the expected color   buttonName=Display None   expectedColor=rgba(23, 162, 184, 1)
   And The button is visible with the expected color   buttonName=Offscreen   expectedColor=rgba(23, 162, 184, 1)
   When Click on the button   buttonName=Hide
   Then Check a button status after clicking on Hide button   buttonName=Removed
   And Check a button status after clicking on Hide button   buttonName=Zero Width
   And Check a button status after clicking on Hide button   buttonName=Overlapped
   And Check a button status after clicking on Hide button   buttonName=Opacity 0
   And Check a button status after clicking on Hide button   buttonName=Visibility Hidden
   And Check a button status after clicking on Hide button   buttonName=Display None
   And Check a button status after clicking on Hide button   buttonName=Offscreen
   And The button is visible with the expected color   buttonName=Hide   expectedColor=rgba(0, 123, 255, 1)


*** Keywords ***
Preconditions
   Open the web page    url=${WEB_URL}   browser=${BROWSER}
   Click on the scenario name   hyperlink_name=Visibility

Teardowns
   Run Keyword If Test Failed    Capture Page Screenshot
   Close Browser