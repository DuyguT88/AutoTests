*** Settings ***
Library    Collections
Library    RequestsLibrary
Library    String
Resource   ../../Resources/API_Resources/DataChecker.robot
Resource   ../../Resources/API_Resources/PetKeywords.robot
Resource  ../../TestData/Variables/enviroment.resource

Default Tags   API   API_PET

*** Variables ***
${nonExisted_pedId}   787878446790
${invalid_ped_status}    unavailable   #valid statuses are available, pending, sold

*** Test Cases ***
API_TS002_Test_1: Add a pet
    ${send_body}=   Given Get reference json    reference_schema_path=${GLOBAL_SCHEMA_SEND_CREATE_PET}
    Set Global Variable    ${send_body}
    ${response_body}=   When POST  url=${API_URL}/pet  json=${send_body}  expected_status=200
    Then Validate the response schema with reference schema   input=${response_body.json()}   ref_path=${GLOBAL_SCHEMA_RESP_CREATE_PET}

API_TS002_Test_2: Update the pet image
    ${pet_id} =	Get From Dictionary   dictionary=${send_body}	 key=id
    Set Global Variable    ${pet_id}
    ${files}   Upload Pet Image   imageFile_name=lovely_dog.jpg
    ${response_body}=   POST   url=${API_URL}/pet/${pet_id}/uploadImage   files=${files}   expected_status=200
    Then Validate the response schema with reference schema   input=${response_body.json()}   ref_path=${GLOBAL_SCHEMA_RESP_UPDATE_PET_IMAGE}

API_TS002_Test_3: Get the pet from id
    ${get_response_body}=   When GET  url=${API_URL}/pet/${pet_id}   expected_status=200
    Then Validate the response schema with reference schema  input=${get_response_body.json()}   ref_path=${GLOBAL_SCHEMA_RESP_GET_PET}

API_TS002_Test_4: Delete the pet
   ${delete_response}=   When DELETE  url=${API_URL}/pet/${pet_id}  expected_status=200
   Then Validate the response schema with reference schema  input=${delete_response.json()}   ref_path=${GLOBAL_SCHEMA_RESP_DELETE_PET}

### NEGATIVE TESTS ####
API_TS002_Test_6: Add a ped non-invalid keys and values (Negative Test)
    ${send_body}=   Given Get reference json    reference_schema_path=${GLOBAL_SCHEMA_SEND_INVALID_PET}
    ${response_body}=   When POST  url=${API_URL}/pet  json=${send_body}  expected_status=405
    Then The response should have correct data     expected_value=${response_body.json()}[type]    actual_value=error
    And The response should have correct data     expected_value=${response_body.json()}[message]    actual_value=Invalid input

API_TS002_Test_7: Get with non-existed pedId (Negative Test)
    ${response_body}=  When GET  url=${API_URL}/pet/${nonExisted_pedId}   expected_status=404
    Then The response should have correct data     expected_value=${response_body.json()}[type]    actual_value=error
    And The response should have correct data     expected_value=${response_body.json()}[message]    actual_value=Pet not found

API_TS002_Test_8: Not possible to add a pet with undefined status different than available,pending,sold (Negative Test)
    Set To Dictionary	 ${send_body}   status=${invalid_ped_status}
    ${response_body}=   When POST  url=${API_URL}/pet  json=${send_body}  expected_status=405
    Then Should Not Be Equal As Strings   first=${response_body.json()}[status]    second=${invalid_ped_status}