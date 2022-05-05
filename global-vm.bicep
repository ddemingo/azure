// 001

// TODO https://github.com/ChristopherGLewis/vNet-Bicep

param locations array = [
    'westus'
    'northeurope'
    'eastasia'
]

module vnets 'modules/vnet.bicep' = [for (location, i) in locations: {
    name: 'vnet-${location}'
    params: {
        location: location
        id: i + 1
    }
}]

module peer 'modules/vnet-peering.bicep' = {
    name: 'peer'
    params: {
        localVnetId: vnets[0].outputs.vnetId
        remoteVnetId: vnets[1].outputs.vnetId
    }
}

// resourceId('Microsoft.Network/virtualNetworks/subnets', vnet_eu.name, 'vnet-eu-0')
module vms 'modules/vm.bicep' = [for (location, i) in locations: {
    name: 'vm-${location}'
    params: {
        location: location
        id: 1
        adminPassword: 'P@ssw0rdxxxx'
        subnetId: vnets[i].outputs.subnets[0].id
    }
}]

//  

/*

resource peer_us_eu 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-05-01' = {
    parent: vnet_us
    name: 'peer-us-eu'
    properties: {
        allowVirtualNetworkAccess: true
        allowForwardedTraffic: false
        allowGatewayTransit: false
        useRemoteGateways: false
        remoteVirtualNetwork: {
            id: vnet_eu.id
        }
    }
}



resource peer_eu_us 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-05-01' = {
    parent: vnet_eu
    name: 'peer-eu-us'
    properties: {
        allowVirtualNetworkAccess: true
        allowForwardedTraffic: false
        allowGatewayTransit: false
        useRemoteGateways: false
        remoteVirtualNetwork: {
            id: vnet_us.id
        }
    }
}

module vmUS1 'modules/vm-linux.bicep' = {
    name: 'vmUS1'
    params: {
        name: 'vm-us-1'
        location: location_us
        subnetId: resourceId('Microsoft.Network/virtualNetworks/subnets', vnet_us.name, 'vnet-us-0')
    }
}

module vmEU1 'modules/vm-linux.bicep' = {
    name: 'vmEU1'
    params: {
        name: 'vm-eu-1'
        location: location_eu
        subnetId: resourceId('Microsoft.Network/virtualNetworks/subnets', vnet_eu.name, 'vnet-eu-0')
    }
}

//output sshCommand string = 'ssh -o StrictHostKeyChecking=no ${admin_user_name}@${pip_us_1.properties.servicePublicIPAddress}'
*/
