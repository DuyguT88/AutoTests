*** Settings ***
Library    Collections
Library    RequestsLibrary
Resource   ../../Resources/API_Resources/DataChecker.robot
Resource  ../../TestData/Variables/enviroment.resource

Default Tags   API   API_STORE

*** Variables ***
${invalid_orderId}   15  #For valid response try integer IDs with value >= 1 and <= 10. Other values will generated exceptions

*** Test Cases ***
API_TS003_Test_1: Request an order
    ${add_order}=   Given Get reference json    reference_schema_path=${GLOBAL_SCHEMA_SEND_CREATE_ORDER}
    And Set Global Variable    ${add_order}
    ${response_body}=   When POST  url=${API_URL}/store/order  json=${add_order}  expected_status=200
    And Validate the response schema with reference schema   input=${response_body.json()}   ref_path=${GLOBAL_SCHEMA_RESPONSE_CREATE_ORDER}

API_TS003_Test_2: Get the order from order id
    ${orderId}=	  Given Get From Dictionary	  ${add_order}	id
    And Set Global Variable    ${orderId}
    ${get_response}=   When GET  url=${API_URL}/store/order/${orderId}   expected_status=200
    And Validate the response schema with reference schema   input=${get_response.json()}   ref_path=${GLOBAL_SCHEMA_RESPONSE_CREATE_ORDER}

 API_TS003_Test_3: Delete the order
   ${delete_response}=   When DELETE  url=${API_URL}/store/order/${orderId}   expected_status=200
    Then The response should have correct data     expected_value=${delete_response.json()}[type]    actual_value=unknown
    And The response should have correct data     expected_value=${delete_response.json()}[message]    actual_value=${orderId}

### NEGATIVE TESTS ####
API_TS003_Test_4: Get with non-existed orderId (Negative Test)
    ${response}=   When GET  url=${API_URL}/store/order/${invalid_orderId}   expected_status=400
    Then The response should have correct data     expected_value=${response.json()}[type]    actual_value=error
    And The response should have correct data     expected_value=${response.json()}[message]    actual_value=Invalid ID supplied

API_TS004_Test_5: Add an order with invalid order Id (Negative test)
    Given Set To Dictionary   ${add_order}   id=${invalid_orderId}
    ${response_body}=   When POST  url=${API_URL}/store/order  json=${add_order}  expected_status=400
    Then The response should have correct data     expected_value=${response_body.json()}[type]    actual_value=error
    And The response should have correct data     expected_value=${response_body.json()}[message]    actual_value=Invalid Order






