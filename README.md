a. How to run the tests locally;
- Go local project directory on the command prompt of your computer and run the following command which runs test suites parallel:
"pabot -d ./TestResults -x result.xml ./TestSuites"

b. How to run the test in a CI/CD pipeline;
- I use AzureDevOps as CI/CD environment and project repository. The tests code is pushed by Git to AzureDevOps git repository:
https://dev.azure.com/duygulu-05/_git/AutoTestsInterviewProject
- The Azure pipeline is created and configured for this project as well (./azure-pipelines.yml).
The project pipelines are in: https://dev.azure.com/duygulu-05/AutoTestsInterviewProject/_build?definitionId=2
- Whenever test code is updated by git push, the tests are triggered on the azure pipeline as configured in azure-pipelines.yml.
- You can also trigger tests on the azure pipeline manually with clicking on "Run Pipeline" button in this azure pipeline.
- For each pipeline publish test result report with visual charts and robot test report can be downloaded, 
since they are configured in ./azure-pipelines.yml file.

c. Has a link to the results in Calliope.pro;
The generated XUnit output file (result.xml) is imported to Calliope.pro automatically by the every trigger of pipeline, 
so the auto-created Calliope.pro reports are available now for this project in:
https://app.calliope.pro/profiles/4454/reports

d. Describe one improvement point and one new feature for the Calliope.pro platform:
- Improvements:
  1.The following explanation for robot framework test report generation is not correct in the Calliope.pro documentation.

""Supported files
We accept the whole /results/ folder from RobotFramework:
output.xml
log.html (optional)
report.html (optional)""

Uploading only output.xml or
whole all test results (includes output.xml,log.html, report.html files) result file separately or
zip format to Calliope.pro does not create test report in Calliope.pro.
It accepts only XUnit output file to generate test result report for robot framework.

  2. It was hard to find "API-key" and "profile-id" values to link and upload test result file to calliope.pro in azure yaml file.
It should be explicit in the documentation as path base. The added small screenshot without any tab/location info is useless to find them out.

New Feature: 
- Azure Devops which is one of the most common sw development tool, but it is not mentioned in
Calliope (https://docs.calliope.pro/import/manual-import/). It can be added.

e. What you used to select the scenarios, what was your approach?;
I selected more common scenarios and high risky ones to be able use these software.

f. Why are they the most important;
- For UI tests I selected more common scenarios and high risky ones.
If clicking, the text and visibility of the page do not work, you can not use this web application. 
- For API tests, again I selected more common scenarios and high risky ones.
If API software cannot response of create (POST), update (PUT), fetch (GET), and delete (DELETE) for the endpoints, the application 
cannot be used. So I focused on these functions to test and automate first.
- For the security reasons, I also focus on authorization which user login are considering mandatory for add, update and delete user
in the API documentation. Because, protecting user's data is important for the customers legally and ethically.
- I also added the negative tests, since the application should work consistently and handle invalid or non-existed data request 
properly.

g. What could be the next steps to your project;
- For UI tests; I would add negative tests and prioritize other UI scenarios to automate. 
- I would consider more on negative tests and non-automated endpoints in API documentation with considering risk assessment 
for the priority.
- API documentation does not have details about some features which should be clarified for better sw quality and testing.
For example; the meaning of invalid data is not clear for the endpoints. Also, The "id" key is used in the json files for several 
endpoints but different purposes, the Id for what should be clarified.
- I can check the report properties of Calliope.pro app if any feature I can add for better reporting.

# NOTES:
The project is added Github as well: https://github.com/DuyguT88/AutoTests

# ABOUT THE FOUND ISSUES WHEN TESTING API:
- User login and logout should not be GET api request, it should be POST api request. 
- A token should be needed in the header of user login and logout endpoints (also other POST and PUT api requests).
However it is not mentioned in api documentation.
- The auto-test failures in test result report are bugs of the api software.
(robot framework test results are committed https://github.com/DuyguT88/AutoTests/tree/main/TestResults/).
