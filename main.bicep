var password = 'P@ssw0rdxxxx'

module france 'france.bicep' = {
  name: 'france'
  params: {
    password: password
  }
}

module asia 'asia.bicep' = {
  name: 'asia'
  params: {
    password: password
  }
}
