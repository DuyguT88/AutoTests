*** Settings ***
Library    SeleniumLibrary
Resource   ../../Resources/UI_Resources/PageObjects/VerifyTextPage.robot
Resource   ../../Resources/UI_Resources/PageObjects/MainPage.robot
Resource   ../../Resources/UI_Resources/Generic.robot
Resource  ../../TestData/Variables/enviroment.resource

Test Setup   Preconditions
Test Teardown   Teardowns
Default Tags   UI   TextVerify

*** Test Cases ***
UI_TS002_Test_1: Check if 'Welcome UserName!' text field is available
   Then User see 'Welcome UserName!' text field on the verify test page

*** Keywords ***
Preconditions
   Open the web page    ${WEB_URL}   ${BROWSER}
   Click on the scenario name   Verify Text

Teardowns
   Run Keyword If Test Failed    Capture Page Screenshot
   Close Browser