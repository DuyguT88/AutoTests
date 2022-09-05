*** Settings ***
Library    String
Library    Validate_json.py
Resource  ../../TestData/Variables/enviroment.resource

*** Keywords ***
The response should have correct data
   [Arguments]   ${expected_value}    ${actual_value}
   Should Be Equal As Strings    ${expected_value}    ${actual_value}

Validate the response schema with reference schema
    [Arguments]   ${input}   ${ref_path}
    ${ref}=   get reference json    reference_schema_path=${ref_path}
    Should Be Equal As Strings     ${input}   ${ref}