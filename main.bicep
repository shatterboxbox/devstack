param location string = resourceGroup().location

@maxLength(24)
param storageAccountName string = 'stislh${uniqueString(resourceGroup().id)}'

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: storageAccountName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2024-01-01' = {
  name: 'vnet'
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: ['10.0.0.0/16']
    }
    subnets: [
      {
        name: 'Subnet1'
        properties: {
          addressPrefix: '10.0.1.024'
        }
      }
      {
        name: 'Subnet2'
        properties: {
          addressPrefix: '10.0.2.0/24'
        }
      }
    ]
  }
}

//use for the deploy stack 

// az group create --name 'demoRg' --location 'centralus'
// az stack group create --name 'demoStack' --resource-group 'demoRg' --template-file './main.bicep' --action-on-unmanage 'detachAll' --deny-settings-mode 'none'
