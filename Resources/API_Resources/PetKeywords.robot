*** Settings ***
Library    Validate_json.py
Library    RequestsLibrary
Resource  ../../TestData/Variables/enviroment.resource

*** Keywords ***
Upload Pet Image
    [Arguments]   ${imageFile_name}
    ${image_file}=    Get File For Streaming Upload    ${GLOBAL_SCHEMA_PET_DIRECTORY}\\${imageFile_name}
    ${files}=    Create Dictionary    file    ${image_file}
    [Return]    ${files}