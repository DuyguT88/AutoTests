*** Settings ***
Library    Validate_json.py
Library    RequestsLibrary
Library    Collections
Resource  ../../TestData/Variables/enviroment.resource

*** Keywords ***
User Logins
    [Arguments]    ${user}   ${passwd}
    &{authorization}    Create Dictionary    username=${user}   password=${passwd}
    ${login_response}=   GET  url=${API_URL}/user/login  json=${authorization}  expected_status=anything
    IF    "${user}" != "${EMPTY}" and "${passwd}" != "${EMPTY}"
          Status should be    200   ${login_response}
    ELSE
         Fail   message=Invalid login
    END

User Logout
    GET  url=${API_URL}/user/logout   expected_status=200


