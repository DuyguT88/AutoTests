*** Settings ***
Library    Collections
Library    String
Library    RequestsLibrary
Resource   ../../Resources/API_Resources/DataChecker.robot
Resource   ../../Resources/API_Resources/UserKeywords.robot
Resource  ../../TestData/Variables/enviroment.resource

Test Setup   User Logout
Default Tags   API  API_USER

*** Variables ***
${new_lastName}     Brown
${new_phone}     1876865
${invalid_username}     ***invalidName***
${nonExisted_username}     Henry
${new_password}     ***#!@@$%
${login_user}     adminUser
${login_passwd}   986/*#^$&

*** Test Cases ***
API_TS001_Test_1: Add an user  #NEEDS LOGIN
    Given User Logins     user=${login_user}      passwd=${login_passwd}
    ${create_req_body}=   And Get reference json    reference_schema_path=${GLOBAL_SCHEMA_SEND_ADD_USER}
    Set Global Variable    ${create_req_body}
    ${post_response}=   When POST  url=${API_URL}/user  json=${create_req_body}  expected_status=200
    Then Validate the response schema with reference schema   input=${post_response.json()}   ref_path=${GLOBAL_SCHEMA_RESP_CREATE_USER}

API_TS001_Test_2: Update the lastname and phone of the user  #NEEDS LOGIN
    Given User Logins     user=${login_user}      passwd=${login_passwd}
    ${username} =	And Get From Dictionary   ${create_req_body}	 key=username
    And Set Global Variable    ${username}
    And Set To Dictionary	 dictionary=${create_req_body}   lastName=${new_lastName}   phone=${new_phone}
    ${put_response}=   When PUT  url=${API_URL}/user/${username}   json=${create_req_body}   expected_status=200
    Then The response should have correct data     expected_value=${put_response.json()}[type]    actual_value=unknown

API_TS001_Test_3: Get the user from username
    ${get_response}=   When GET  url=${API_URL}/user/${username}   expected_status=200
    When Validate the response schema with reference schema  input=${get_response.json()}   ref_path=${GLOBAL_SCHEMA_RESP_GET_USER}

 API_TS001_Test_4: Delete the user    #NEEDS LOGIN
    Given User Logins     user=${login_user}      passwd=${login_passwd}
   ${delete_response}=   When DELETE  url=${API_URL}/user/${username}  expected_status=200
    Then The response should have correct data     expected_value=${delete_response.json()}[type]    actual_value=unknown
    And The response should have correct data     expected_value=${delete_response.json()}[message]    actual_value=${username}

### NEGATIVE TESTS ####
API_TS001_Test_5: Add an user without login (Negative test)
    ${create_req_body}=   Given Get reference json    reference_schema_path=${GLOBAL_SCHEMA_SEND_ADD_USER}
    ${post_response}=   When POST  url=${API_URL}/user  json=${create_req_body}  expected_status=anything
    ${failed}=   Then Run Keyword And Return Status	   Status should be    status=200    url=${post_response}
    And Run Keyword If	  ${failed}	  FAIL   message=Status should not be 200 since user is not login

API_TS001_Test_6: Try to update invalid user (Negative test)  #NEEDS LOGIN
    Given User Logins     user=${login_user}      passwd=${login_passwd}
    Set To Dictionary	 dictionary=${create_req_body}   password=${new_password}
    ${invalid_response}=   When PUT  url=${API_URL}/user/${invalid_username}   json=${create_req_body}   expected_status=400
    Then The response should have correct data     expected_value=${invalid_response.json()}[type]    actual_value=error
    And The response should have correct data     expected_value=${invalid_response.json()}[message]    actual_value=Invalid user supplied

API_TS001_Test_7: Try to update non-existed user (Negative test)  #NEEDS LOGIN
    Given User Logins     user=${login_user}      passwd=${login_passwd}
    And Set To Dictionary	 dictionary=${create_req_body}   password=${new_password}
    ${nonExistedPut_response}=   When PUT  url=${API_URL}/user/${nonExisted_username}  json=${create_req_body}   expected_status=404
    Then The response should have correct data     input=${nonExistedPut_response.json()}[type]    actual_value=error
    And The response should have correct data     input=${nonExistedPut_response.json()}[message]    actual_value=User not found