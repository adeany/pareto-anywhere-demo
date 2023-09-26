@secure()
param IotHubs_amdparetodemoIOTHub25_connectionString string

@secure()
param IotHubs_amdparetodemoIOTHub25_containerName string
param namespaces_aruba19508_name string = 'aruba19508'
param WebPubSub_pubsub2399_name string = 'pubsub2399'
param IotHubs_amdparetodemoIOTHub25_name string = 'amdparetodemoIOTHub25'
param sites_amd_pareto_handler_function25_name string = 'amd-pareto-handler-function25'
param storageAccounts_arubastorage28726_name string = 'arubastorage28726'
param serverfarms_pareto_premium_plan_21281_name string = 'pareto-premium-plan-21281'
param components_amd_pareto_handler_function25_name string = 'amd-pareto-handler-function25'
param actionGroups_Application_Insights_Smart_Detection_name string = 'Application Insights Smart Detection'
param smartdetectoralertrules_failure_anomalies_amd_pareto_handler_function25_name string = 'failure anomalies - amd-pareto-handler-function25'

resource IotHubs_amdparetodemoIOTHub25_name_resource 'Microsoft.Devices/IotHubs@2023-06-30' = {
  name: IotHubs_amdparetodemoIOTHub25_name
  location: 'westus'
  sku: {
    name: 'F1'
    tier: 'Free'
    capacity: 1
  }
  identity: {
    type: 'None'
  }
  properties: {
    ipFilterRules: []
    eventHubEndpoints: {
      events: {
        retentionTimeInDays: 1
        partitionCount: 2
      }
    }
    routing: {
      endpoints: {
        serviceBusQueues: []
        serviceBusTopics: []
        eventHubs: []
        storageContainers: []
        cosmosDBSqlContainers: []
      }
      routes: []
      fallbackRoute: {
        name: '$fallback'
        source: 'DeviceMessages'
        condition: 'true'
        endpointNames: [
          'events'
        ]
        isEnabled: true
      }
    }
    storageEndpoints: {
      '$default': {
        sasTtlAsIso8601: 'PT1H'
        connectionString: IotHubs_amdparetodemoIOTHub25_connectionString
        containerName: IotHubs_amdparetodemoIOTHub25_containerName
      }
    }
    messagingEndpoints: {
      fileNotifications: {
        lockDurationAsIso8601: 'PT5S'
        ttlAsIso8601: 'PT1H'
        maxDeliveryCount: 10
      }
    }
    enableFileUploadNotifications: false
    cloudToDevice: {
      maxDeliveryCount: 10
      defaultTtlAsIso8601: 'PT1H'
      feedback: {
        lockDurationAsIso8601: 'PT5S'
        ttlAsIso8601: 'PT1H'
        maxDeliveryCount: 10
      }
    }
    features: 'RootCertificateV2'
    allowedFqdnList: []
  }
}

resource namespaces_aruba19508_name_resource 'Microsoft.EventHub/namespaces@2023-01-01-preview' = {
  name: namespaces_aruba19508_name
  location: 'West US'
  sku: {
    name: 'Standard'
    tier: 'Standard'
    capacity: 1
  }
  properties: {
    minimumTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    disableLocalAuth: false
    zoneRedundant: false
    isAutoInflateEnabled: false
    maximumThroughputUnits: 0
    kafkaEnabled: true
  }
}

resource actionGroups_Application_Insights_Smart_Detection_name_resource 'microsoft.insights/actionGroups@2023-01-01' = {
  name: actionGroups_Application_Insights_Smart_Detection_name
  location: 'Global'
  properties: {
    groupShortName: 'SmartDetect'
    enabled: true
    emailReceivers: []
    smsReceivers: []
    webhookReceivers: []
    eventHubReceivers: []
    itsmReceivers: []
    azureAppPushReceivers: []
    automationRunbookReceivers: []
    voiceReceivers: []
    logicAppReceivers: []
    azureFunctionReceivers: []
    armRoleReceivers: [
      {
        name: 'Monitoring Contributor'
        roleId: '749f88d5-cbae-40b8-bcfc-e573ddc772fa'
        useCommonAlertSchema: true
      }
      {
        name: 'Monitoring Reader'
        roleId: '43d0d8ad-25c7-4714-9337-8ba259a9fe05'
        useCommonAlertSchema: true
      }
    ]
  }
}

resource components_amd_pareto_handler_function25_name_resource 'microsoft.insights/components@2020-02-02' = {
  name: components_amd_pareto_handler_function25_name
  location: 'westus'
  kind: 'web'
  properties: {
    Application_Type: 'web'
    RetentionInDays: 90
    IngestionMode: 'ApplicationInsights'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

resource WebPubSub_pubsub2399_name_resource 'Microsoft.SignalRService/WebPubSub@2023-06-01-preview' = {
  name: WebPubSub_pubsub2399_name
  location: 'westus'
  sku: {
    name: 'Free_F1'
    tier: 'Free'
    size: 'F1'
    capacity: 1
  }
  kind: 'WebPubSub'
  properties: {
    tls: {
      clientCertEnabled: false
    }
    networkACLs: {
      defaultAction: 'Deny'
      publicNetwork: {
        allow: [
          'ServerConnection'
          'ClientConnection'
          'RESTAPI'
          'Trace'
        ]
      }
      privateEndpoints: []
    }
    publicNetworkAccess: 'Enabled'
    disableLocalAuth: false
    disableAadAuth: false
  }
}

resource storageAccounts_arubastorage28726_name_resource 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccounts_arubastorage28726_name
  location: 'westus'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    minimumTlsVersion: 'TLS1_0'
    allowBlobPublicAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource serverfarms_pareto_premium_plan_21281_name_resource 'Microsoft.Web/serverfarms@2022-09-01' = {
  name: serverfarms_pareto_premium_plan_21281_name
  location: 'West US'
  sku: {
    name: 'EP1'
    tier: 'ElasticPremium'
    size: 'EP1'
    family: 'EP'
    capacity: 1
  }
  kind: 'elastic'
  properties: {
    perSiteScaling: false
    elasticScaleEnabled: true
    maximumElasticWorkerCount: 1
    isSpot: false
    reserved: false
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
  }
}

resource namespaces_aruba19508_name_RootManageSharedAccessKey 'Microsoft.EventHub/namespaces/authorizationrules@2023-01-01-preview' = {
  parent: namespaces_aruba19508_name_resource
  name: 'RootManageSharedAccessKey'
  location: 'westus'
  properties: {
    rights: [
      'Listen'
      'Manage'
      'Send'
    ]
  }
}

resource namespaces_aruba19508_name_arubahub20067 'Microsoft.EventHub/namespaces/eventhubs@2023-01-01-preview' = {
  parent: namespaces_aruba19508_name_resource
  name: 'arubahub20067'
  location: 'westus'
  properties: {
    retentionDescription: {
      cleanupPolicy: 'Delete'
      retentionTimeInHours: 168
    }
    messageRetentionInDays: 7
    partitionCount: 4
    status: 'Active'
  }
}

resource namespaces_aruba19508_name_default 'Microsoft.EventHub/namespaces/networkrulesets@2023-01-01-preview' = {
  parent: namespaces_aruba19508_name_resource
  name: 'default'
  location: 'westus'
  properties: {
    publicNetworkAccess: 'Enabled'
    defaultAction: 'Allow'
    virtualNetworkRules: []
    ipRules: []
    trustedServiceAccessEnabled: false
  }
}

resource components_amd_pareto_handler_function25_name_degradationindependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_amd_pareto_handler_function25_name_resource
  name: 'degradationindependencyduration'
  location: 'westus'
  properties: {
    RuleDefinitions: {
      Name: 'degradationindependencyduration'
      DisplayName: 'Degradation in dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_amd_pareto_handler_function25_name_degradationinserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_amd_pareto_handler_function25_name_resource
  name: 'degradationinserverresponsetime'
  location: 'westus'
  properties: {
    RuleDefinitions: {
      Name: 'degradationinserverresponsetime'
      DisplayName: 'Degradation in server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_amd_pareto_handler_function25_name_digestMailConfiguration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_amd_pareto_handler_function25_name_resource
  name: 'digestMailConfiguration'
  location: 'westus'
  properties: {
    RuleDefinitions: {
      Name: 'digestMailConfiguration'
      DisplayName: 'Digest Mail Configuration'
      Description: 'This rule describes the digest mail preferences'
      HelpUrl: 'www.homail.com'
      IsHidden: true
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_amd_pareto_handler_function25_name_extension_billingdatavolumedailyspikeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_amd_pareto_handler_function25_name_resource
  name: 'extension_billingdatavolumedailyspikeextension'
  location: 'westus'
  properties: {
    RuleDefinitions: {
      Name: 'extension_billingdatavolumedailyspikeextension'
      DisplayName: 'Abnormal rise in daily data volume (preview)'
      Description: 'This detection rule automatically analyzes the billing data generated by your application, and can warn you about an unusual increase in your application\'s billing costs'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/billing-data-volume-daily-spike.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_amd_pareto_handler_function25_name_extension_canaryextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_amd_pareto_handler_function25_name_resource
  name: 'extension_canaryextension'
  location: 'westus'
  properties: {
    RuleDefinitions: {
      Name: 'extension_canaryextension'
      DisplayName: 'Canary extension'
      Description: 'Canary extension'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/'
      IsHidden: true
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_amd_pareto_handler_function25_name_extension_exceptionchangeextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_amd_pareto_handler_function25_name_resource
  name: 'extension_exceptionchangeextension'
  location: 'westus'
  properties: {
    RuleDefinitions: {
      Name: 'extension_exceptionchangeextension'
      DisplayName: 'Abnormal rise in exception volume (preview)'
      Description: 'This detection rule automatically analyzes the exceptions thrown in your application, and can warn you about unusual patterns in your exception telemetry.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/abnormal-rise-in-exception-volume.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_amd_pareto_handler_function25_name_extension_memoryleakextension 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_amd_pareto_handler_function25_name_resource
  name: 'extension_memoryleakextension'
  location: 'westus'
  properties: {
    RuleDefinitions: {
      Name: 'extension_memoryleakextension'
      DisplayName: 'Potential memory leak detected (preview)'
      Description: 'This detection rule automatically analyzes the memory consumption of each process in your application, and can warn you about potential memory leaks or increased memory consumption.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/tree/master/SmartDetection/memory-leak.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_amd_pareto_handler_function25_name_extension_securityextensionspackage 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_amd_pareto_handler_function25_name_resource
  name: 'extension_securityextensionspackage'
  location: 'westus'
  properties: {
    RuleDefinitions: {
      Name: 'extension_securityextensionspackage'
      DisplayName: 'Potential security issue detected (preview)'
      Description: 'This detection rule automatically analyzes the telemetry generated by your application and detects potential security issues.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/application-security-detection-pack.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_amd_pareto_handler_function25_name_extension_traceseveritydetector 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_amd_pareto_handler_function25_name_resource
  name: 'extension_traceseveritydetector'
  location: 'westus'
  properties: {
    RuleDefinitions: {
      Name: 'extension_traceseveritydetector'
      DisplayName: 'Degradation in trace severity ratio (preview)'
      Description: 'This detection rule automatically analyzes the trace logs emitted from your application, and can warn you about unusual patterns in the severity of your trace telemetry.'
      HelpUrl: 'https://github.com/Microsoft/ApplicationInsights-Home/blob/master/SmartDetection/degradation-in-trace-severity-ratio.md'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_amd_pareto_handler_function25_name_longdependencyduration 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_amd_pareto_handler_function25_name_resource
  name: 'longdependencyduration'
  location: 'westus'
  properties: {
    RuleDefinitions: {
      Name: 'longdependencyduration'
      DisplayName: 'Long dependency duration'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_amd_pareto_handler_function25_name_migrationToAlertRulesCompleted 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_amd_pareto_handler_function25_name_resource
  name: 'migrationToAlertRulesCompleted'
  location: 'westus'
  properties: {
    RuleDefinitions: {
      Name: 'migrationToAlertRulesCompleted'
      DisplayName: 'Migration To Alert Rules Completed'
      Description: 'A configuration that controls the migration state of Smart Detection to Smart Alerts'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: true
      IsEnabledByDefault: false
      IsInPreview: true
      SupportsEmailNotifications: false
    }
    Enabled: false
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_amd_pareto_handler_function25_name_slowpageloadtime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_amd_pareto_handler_function25_name_resource
  name: 'slowpageloadtime'
  location: 'westus'
  properties: {
    RuleDefinitions: {
      Name: 'slowpageloadtime'
      DisplayName: 'Slow page load time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource components_amd_pareto_handler_function25_name_slowserverresponsetime 'microsoft.insights/components/ProactiveDetectionConfigs@2018-05-01-preview' = {
  parent: components_amd_pareto_handler_function25_name_resource
  name: 'slowserverresponsetime'
  location: 'westus'
  properties: {
    RuleDefinitions: {
      Name: 'slowserverresponsetime'
      DisplayName: 'Slow server response time'
      Description: 'Smart Detection rules notify you of performance anomaly issues.'
      HelpUrl: 'https://docs.microsoft.com/en-us/azure/application-insights/app-insights-proactive-performance-diagnostics'
      IsHidden: false
      IsEnabledByDefault: true
      IsInPreview: false
      SupportsEmailNotifications: true
    }
    Enabled: true
    SendEmailsToSubscriptionOwners: true
    CustomEmails: []
  }
}

resource storageAccounts_arubastorage28726_name_default 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  parent: storageAccounts_arubastorage28726_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: false
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_arubastorage28726_name_default 'Microsoft.Storage/storageAccounts/fileServices@2023-01-01' = {
  parent: storageAccounts_arubastorage28726_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_arubastorage28726_name_default 'Microsoft.Storage/storageAccounts/queueServices@2023-01-01' = {
  parent: storageAccounts_arubastorage28726_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_arubastorage28726_name_default 'Microsoft.Storage/storageAccounts/tableServices@2023-01-01' = {
  parent: storageAccounts_arubastorage28726_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource sites_amd_pareto_handler_function25_name_resource 'Microsoft.Web/sites@2022-09-01' = {
  name: sites_amd_pareto_handler_function25_name
  location: 'West US'
  kind: 'functionapp'
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${sites_amd_pareto_handler_function25_name}.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${sites_amd_pareto_handler_function25_name}.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: serverfarms_pareto_premium_plan_21281_name_resource.id
    reserved: false
    isXenon: false
    hyperV: false
    vnetRouteAllEnabled: false
    vnetImagePullEnabled: false
    vnetContentShareEnabled: false
    siteConfig: {
      numberOfWorkers: 1
      acrUseManagedIdentityCreds: false
      alwaysOn: false
      http20Enabled: true
      functionAppScaleLimit: 0
      minimumElasticInstanceCount: 1
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: false
    clientCertEnabled: false
    clientCertMode: 'Required'
    hostNamesDisabled: false
    customDomainVerificationId: 'C3C17DD63BDEB25692A14363EB60997BA8C024C7A994CED0C4263682EDAC3EFB'
    containerSize: 1536
    dailyMemoryTimeQuota: 0
    httpsOnly: false
    redundancyMode: 'None'
    storageAccountRequired: false
    keyVaultReferenceIdentity: 'SystemAssigned'
  }
}

resource sites_amd_pareto_handler_function25_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2022-09-01' = {
  parent: sites_amd_pareto_handler_function25_name_resource
  name: 'ftp'
  location: 'West US'
  properties: {
    allow: false
  }
}

resource sites_amd_pareto_handler_function25_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2022-09-01' = {
  parent: sites_amd_pareto_handler_function25_name_resource
  name: 'scm'
  location: 'West US'
  properties: {
    allow: false
  }
}

resource sites_amd_pareto_handler_function25_name_web 'Microsoft.Web/sites/config@2022-09-01' = {
  parent: sites_amd_pareto_handler_function25_name_resource
  name: 'web'
  location: 'West US'
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
    ]
    netFrameworkVersion: 'v4.0'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    httpLoggingEnabled: false
    acrUseManagedIdentityCreds: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: '$amd-pareto-handler-function25'
    scmType: 'None'
    use32BitWorkerProcess: true
    webSocketsEnabled: false
    alwaysOn: false
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    vnetRouteAllEnabled: false
    vnetPrivatePortsCount: 0
    localMySqlEnabled: false
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 2147483647
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: true
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.2'
    ftpsState: 'FtpsOnly'
    preWarmedInstanceCount: 1
    functionAppScaleLimit: 0
    functionsRuntimeScaleMonitoringEnabled: false
    minimumElasticInstanceCount: 1
    azureStorageAccounts: {}
  }
}

resource sites_amd_pareto_handler_function25_name_33672b2e6ca8421b9dbe7b5ef25b3689 'Microsoft.Web/sites/deployments@2022-09-01' = {
  parent: sites_amd_pareto_handler_function25_name_resource
  name: '33672b2e6ca8421b9dbe7b5ef25b3689'
  location: 'West US'
  properties: {
    status: 4
    author_email: 'N/A'
    author: 'N/A'
    deployer: 'GITHUB_ZIP_DEPLOY_FUNCTIONS_V1'
    message: '{"type":"deployment","sha":"5a3b81a5ba23f4131607101d0277805e7068dcbb","repoName":"adeany/pareto-anywhere-demo","actor":"adeany","slotName":"production"}'
    start_time: '2023-09-25T22:24:53.8351804Z'
    end_time: '2023-09-25T22:24:55.3531945Z'
    active: true
  }
}

resource sites_amd_pareto_handler_function25_name_negotiateConnection 'Microsoft.Web/sites/functions@2022-09-01' = {
  parent: sites_amd_pareto_handler_function25_name_resource
  name: 'negotiateConnection'
  location: 'West US'
  properties: {
    script_root_path_href: 'https://amd-pareto-handler-function25.azurewebsites.net/admin/vfs/site/wwwroot/negotiateConnection/'
    script_href: 'https://amd-pareto-handler-function25.azurewebsites.net/admin/vfs/site/wwwroot/negotiateConnection/index.js'
    config_href: 'https://amd-pareto-handler-function25.azurewebsites.net/admin/vfs/site/wwwroot/negotiateConnection/function.json'
    test_data_href: 'https://amd-pareto-handler-function25.azurewebsites.net/admin/vfs/data/Functions/sampledata/negotiateConnection.dat'
    href: 'https://amd-pareto-handler-function25.azurewebsites.net/admin/functions/negotiateConnection'
    config: {}
    invoke_url_template: 'https://amd-pareto-handler-function25.azurewebsites.net/app/wsconnection'
    language: 'node'
    isDisabled: false
  }
}

resource sites_amd_pareto_handler_function25_name_processIoTHubMessages 'Microsoft.Web/sites/functions@2022-09-01' = {
  parent: sites_amd_pareto_handler_function25_name_resource
  name: 'processIoTHubMessages'
  location: 'West US'
  properties: {
    script_root_path_href: 'https://amd-pareto-handler-function25.azurewebsites.net/admin/vfs/site/wwwroot/processIoTHubMessages/'
    script_href: 'https://amd-pareto-handler-function25.azurewebsites.net/admin/vfs/site/wwwroot/processIoTHubMessages/index.js'
    config_href: 'https://amd-pareto-handler-function25.azurewebsites.net/admin/vfs/site/wwwroot/processIoTHubMessages/function.json'
    test_data_href: 'https://amd-pareto-handler-function25.azurewebsites.net/admin/vfs/data/Functions/sampledata/processIoTHubMessages.dat'
    href: 'https://amd-pareto-handler-function25.azurewebsites.net/admin/functions/processIoTHubMessages'
    config: {}
    language: 'node'
    isDisabled: false
  }
}

resource sites_amd_pareto_handler_function25_name_serveWebApp 'Microsoft.Web/sites/functions@2022-09-01' = {
  parent: sites_amd_pareto_handler_function25_name_resource
  name: 'serveWebApp'
  location: 'West US'
  properties: {
    script_root_path_href: 'https://amd-pareto-handler-function25.azurewebsites.net/admin/vfs/site/wwwroot/serveWebApp/'
    script_href: 'https://amd-pareto-handler-function25.azurewebsites.net/admin/vfs/site/wwwroot/serveWebApp/index.js'
    config_href: 'https://amd-pareto-handler-function25.azurewebsites.net/admin/vfs/site/wwwroot/serveWebApp/function.json'
    test_data_href: 'https://amd-pareto-handler-function25.azurewebsites.net/admin/vfs/data/Functions/sampledata/serveWebApp.dat'
    href: 'https://amd-pareto-handler-function25.azurewebsites.net/admin/functions/serveWebApp'
    config: {}
    invoke_url_template: 'https://amd-pareto-handler-function25.azurewebsites.net/app/{folder?}/{filename?}'
    language: 'node'
    isDisabled: false
  }
}

resource sites_amd_pareto_handler_function25_name_sites_amd_pareto_handler_function25_name_azurewebsites_net 'Microsoft.Web/sites/hostNameBindings@2022-09-01' = {
  parent: sites_amd_pareto_handler_function25_name_resource
  name: '${sites_amd_pareto_handler_function25_name}.azurewebsites.net'
  location: 'West US'
  properties: {
    siteName: 'amd-pareto-handler-function25'
    hostNameType: 'Verified'
  }
}

resource smartdetectoralertrules_failure_anomalies_amd_pareto_handler_function25_name_resource 'microsoft.alertsmanagement/smartdetectoralertrules@2021-04-01' = {
  name: smartdetectoralertrules_failure_anomalies_amd_pareto_handler_function25_name
  location: 'global'
  properties: {
    description: 'Failure Anomalies notifies you of an unusual rise in the rate of failed HTTP requests or dependency calls.'
    state: 'Enabled'
    severity: 'Sev3'
    frequency: 'PT1M'
    detector: {
      id: 'FailureAnomaliesDetector'
    }
    scope: [
      components_amd_pareto_handler_function25_name_resource.id
    ]
    actionGroups: {
      groupIds: [
        actionGroups_Application_Insights_Smart_Detection_name_resource.id
      ]
    }
  }
}

resource namespaces_aruba19508_name_arubahub20067_aruba_hub_rule 'Microsoft.EventHub/namespaces/eventhubs/authorizationrules@2023-01-01-preview' = {
  parent: namespaces_aruba19508_name_arubahub20067
  name: 'aruba-hub-rule'
  location: 'westus'
  properties: {
    rights: [
      'Listen'
      'Send'
    ]
  }
  dependsOn: [

    namespaces_aruba19508_name_resource
  ]
}

resource namespaces_aruba19508_name_arubahub20067_Default 'Microsoft.EventHub/namespaces/eventhubs/consumergroups@2023-01-01-preview' = {
  parent: namespaces_aruba19508_name_arubahub20067
  name: '$Default'
  location: 'westus'
  properties: {}
  dependsOn: [

    namespaces_aruba19508_name_resource
  ]
}

resource storageAccounts_arubastorage28726_name_default_azure_webjobs_eventhub 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  parent: storageAccounts_arubastorage28726_name_default
  name: 'azure-webjobs-eventhub'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [

    storageAccounts_arubastorage28726_name_resource
  ]
}

resource storageAccounts_arubastorage28726_name_default_azure_webjobs_hosts 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  parent: storageAccounts_arubastorage28726_name_default
  name: 'azure-webjobs-hosts'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [

    storageAccounts_arubastorage28726_name_resource
  ]
}

resource storageAccounts_arubastorage28726_name_default_azure_webjobs_secrets 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  parent: storageAccounts_arubastorage28726_name_default
  name: 'azure-webjobs-secrets'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [

    storageAccounts_arubastorage28726_name_resource
  ]
}

resource storageAccounts_arubastorage28726_name_default_amd_pareto_handler_function25b6ae8eec1e57 'Microsoft.Storage/storageAccounts/fileServices/shares@2023-01-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_arubastorage28726_name_default
  name: 'amd-pareto-handler-function25b6ae8eec1e57'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 5120
    enabledProtocols: 'SMB'
  }
  dependsOn: [

    storageAccounts_arubastorage28726_name_resource
  ]
}
