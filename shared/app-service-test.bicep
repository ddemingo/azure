// https://docs.microsoft.com/en-us/learn/modules/host-a-web-app-with-azure-app-service/3-exercise-create-a-web-app-in-the-azure-portal?pivots=python

module app 'app-service.bicep' = {
  name: 'shared-app-service-test'
  params: {
    location: 'centralus'
    name: 'python'
    linuxFxVersion: 'PYTHON:3.9'
    repositoryUrl: 'https://github.com/ddemingo/python-webapp'
  }
}
