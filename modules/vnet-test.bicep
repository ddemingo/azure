//
// https://docs.microsoft.com/es-es/learn/modules/improve-app-scalability-resiliency-with-load-balancer/4-exercise-configure-public-load-balancer?pivots=bash
// 
// 2 horas: vm
//

var location = 'francecentral'

module vnet 'vnet.bicep' = {
  name: 'vnet'
  params: {
    location: location
    id: 1
  }
}

module vm 'vm.bicep' = {
  name: 'vm'
  params: {
    location: location
    id: 1
    adminPassword: 'P@ssw0rdxxxx'
    subnetId: vnet.outputs.subnets[0].id
  }
}
