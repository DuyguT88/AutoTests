*** Settings ***
Library    SeleniumLibrary
Variables  ../Variables/enviroment.py

*** Keywords ***
Open the web page
   [Arguments]   ${url}  ${browser}
    Open Browser   ${url}  ${browser}
    Maximize Browser Window
    Wait Until Page Contains    UI Test Automation Playground   30s