require('./KalturaAsyncProxyServerErrors');

const validationFields = 
    ["logger", "logger.debugEnabled", "logger.logDir", "logger.accessLogName", 
        "logger.logName", "logger.errorLogName", "server", "server.version", 
        "server.remote_addr_header_salt", "server.remote_addr_header_timeout", 
        "cloud", "cdn_api_host"
    ];

class KalturaAsyncProxyServerValidator {

    static validateConfigurations(config) {

        //Validate config was loaded successfully
        if (!config)
            throw new Error(KalturaAsyncProxyServerErrors.SERVER_CONFIG_NOT_FOUND);

        validationFields.forEach(function(loggerVariable) {
            if (!config.has(loggerVariable))
                throw new Error(KalturaAsyncProxyServerErrors.MISSING_CONFIGURATION_PARAMETER + " [" + loggerVariable + "]")
        });

        if (!config.has('cloud.httpPort1') && !config.has('cloud.httpsPort1'))
            throw new Error(KalturaAsyncProxyServerErrors.MISSING_SERVER_PORT_CONFIGURATION);

        if (config.has('cloud.httpPort1') && !config.has('cdn_api_host.cdn_api_host_http'))
            throw new Error(KalturaAsyncProxyServerErrors.CANNOT_DEFINE_LISTEN_PORT_WITHOUT_DESTINATION_HOST + " [http]");

        if (config.has('cloud.httpsPort1') && !config.has('cdn_api_host.cdn_api_host_https'))
            throw new Error(KalturaAsyncProxyServerErrors.CANNOT_DEFINE_LISTEN_PORT_WITHOUT_DESTINATION_HOST + " [https]");
    }
}

module.exports = KalturaAsyncProxyServerValidator;
