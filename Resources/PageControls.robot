*** Settings ***
Library    SeleniumLibrary
Variables  ../Variables/enviroment.py

*** Keywords ***
Click on the button
   [Arguments]   ${buttonName}
   Click Element  //button[text()="${buttonName}"]
   Sleep   0.2s