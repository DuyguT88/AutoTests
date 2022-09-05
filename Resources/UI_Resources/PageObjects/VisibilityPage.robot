*** Settings ***
Library    SeleniumLibrary
Resource  ../../../TestData/Variables/enviroment.resource
Resource  ../ClickActions.robot

*** Keywords ***
Check a button status after clicking on Hide button
    [Arguments]    ${button_name}
    IF  "${button_name}" == "Removed"
        Page Should Not Contain Element    xpath=//button[text()="${buttonName}"]
    ELSE IF  "${button_name}" == "Zero Width"
         Page Should Contain Element    xpath=//button[text()="${buttonName}" and @class="btn btn-warning zerowidth"]
    ELSE IF  "${button_name}" == "Overlapped"
         Page Should Contain Element    xpath=//button[text()="${buttonName}"]/following-sibling::div[contains(@style,absolute)]
    ELSE IF  "${button_name}" == "Opacity 0"
         Page Should Contain Element    xpath=//button[text()="${button_name}" and @style="opacity: 0;"]
    ELSE IF  "${button_name}" == "Visibility Hidden"
         Page Should Contain Element    xpath=//button[text()="${button_name}" and @style="visibility: hidden;"]
    ELSE IF  "${button_name}" == "Display None"
         Page Should Contain Element    xpath=//button[text()="${button_name}" and @style="display: none;"]
    ELSE IF  "${button_name}" == "Offscreen"
         Page Should Contain Element    xpath=//button[text()="${button_name}" and @class="btn btn-info offscreen"]
    END




