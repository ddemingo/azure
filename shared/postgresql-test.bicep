var location = 'francecentral'

module postgresql 'postgresql.bicep' = {
  name: 'shared-postgresql-test'
  params: {
    location: location
    name: 'asix'
  }
}
