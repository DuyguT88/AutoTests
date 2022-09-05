*** Settings ***
Library    SeleniumLibrary
Library    String
Resource  ../../../TestData/Variables/enviroment.resource

*** Keywords ***
Click on the scenario name
   [Arguments]   ${hyperlink_name}
   Click Element  //a[text()="${hyperlink_name}"]