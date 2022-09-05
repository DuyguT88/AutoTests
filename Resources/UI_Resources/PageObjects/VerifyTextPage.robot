*** Settings ***
Library    SeleniumLibrary
Resource  ../../../TestData/Variables/enviroment.resource

*** Keywords ***
User see 'Welcome UserName!' text field on the verify test page
   Page Should Contain Element  //span[normalize-space(.)='UserName']/parent::span[contains(text(),'Welcome')]