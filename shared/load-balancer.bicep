param location string

var lbName_var = 'xxx-lb'
var lbSkuName = 'Standard'
var lbProbeName = 'loadBalancerHealthProbe'
var lbPublicIpAddressName_var = '-lbPublicIP'
var lbPublicIPAddressNameOutbound_var = '-lbPublicIPOutbound'
var lbFrontEndName = 'LoadBalancerFrontEnd'
var lbFrontEndNameOutbound = 'LoadBalancerFrontEndOutbound'
var lbBackendPoolName = 'LoadBalancerBackEndPool'
var lbBackendPoolNameOutbound = 'LoadBalancerBackEndPoolOutbound'
var vNetAddressPrefix = '10.0.0.0/16'
var vNetSubnetName = 'BackendSubnet'
var vNetSubnetAddressPrefix = '10.0.0.0/24'
var vmStorageAccountType = 'Premium_LRS'

resource loadBalancer 'Microsoft.Network/loadBalancers@2021-08-01' = {
  name: 'load-balancer'
  location: location
  properties: {
    properties: {
      frontendIPConfigurations: [
        {
          name: lbFrontEndName
          properties: {
            publicIPAddress: {
              id: lbPublicIPAddressName.id
            }
          }
        }
        {
          name: lbFrontEndNameOutbound
          properties: {
            publicIPAddress: {
              id: lbPublicIPAddressNameOutbound.id
            }
          }
        }
      ]
      backendAddressPools: [
        {
          name: lbBackendPoolName
        }
        {
          name: lbBackendPoolNameOutbound
        }
      ]
      loadBalancingRules: [
        {
          name: 'myHTTPRule'
          properties: {
            frontendIPConfiguration: {
              id: resourceId('Microsoft.Network/loadBalancers/frontendIPConfigurations', lbName_var, lbFrontEndName)
            }
            backendAddressPool: {
              id: resourceId('Microsoft.Network/loadBalancers/backendAddressPools', lbName_var, lbBackendPoolName)
            }
            frontendPort: 80
            backendPort: 80
            enableFloatingIP: false
            idleTimeoutInMinutes: 15
            protocol: 'Tcp'
            enableTcpReset: true
            loadDistribution: 'Default'
            disableOutboundSnat: true
            probe: {
              id: resourceId('Microsoft.Network/loadBalancers/probes', lbName_var, lbProbeName)
            }
          }
        }
      ]
      probes: [
        {
          name: lbProbeName
          properties: {
            protocol: 'Tcp'
            port: 80
            intervalInSeconds: 5
            numberOfProbes: 2
          }
        }
      ]
      outboundRules: [
        {
          name: 'myOutboundRule'
          properties: {
            allocatedOutboundPorts: 10000
            protocol: 'All'
            enableTcpReset: false
            idleTimeoutInMinutes: 15
            backendAddressPool: {
              id: resourceId('Microsoft.Network/loadBalancers/backendAddressPools', lbName_var, lbBackendPoolNameOutbound)
            }
            frontendIPConfigurations: [
              {
                id: resourceId('Microsoft.Network/loadBalancers/frontendIPConfigurations', lbName_var, lbFrontEndNameOutbound)
              }
            ]
          }
        }
      ]
    }
  }
}

resource lbPublicIPAddressName 'Microsoft.Network/publicIPAddresses@2020-06-01' = {
  name: lbPublicIpAddressName_var
  location: location
  sku: {
    name: lbSkuName
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
  }
}

resource lbPublicIPAddressNameOutbound 'Microsoft.Network/publicIPAddresses@2020-06-01' = {
  name: lbPublicIPAddressNameOutbound_var
  location: location
  sku: {
    name: lbSkuName
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
  }
}

output backentPool array = loadBalancer.properties.backendAddressPools
