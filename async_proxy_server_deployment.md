# [Async API Proxy Server](https://github.com/vidiun/AsyncApiProxy) Deployment Instructions

## Machine Prerequisites
- Node 6.10.2 or above: installation reference: https://github.com/joyent/node/wiki/Installing-Node.js-via-package-manager#ubuntu-mint-elementary-os
- Node Packaged Modules (npm) 1.4.3 or above
- NVM version 0.30.1 or above

*IMPORTANT NOTE: 
The Async API Proxy Server requires [Vidiun Server](https://github.com/vidiun/server) of version Lynx-12.14.0 and above.*


## Initial Enviorment Setup
1. Clone https://github.com/vidiun/AsyncApiProxy to /opt/vidiun/asyncProxyServer/master
2. Navigate to the checkout dir
3. npm install
4. npm install -g forever

## Configuration
1. Create a log directory (mkdir /opt/vidiun/log/AsyncApiProxy)
2. ln -s /opt/vidiun/AsyncApiProxy/master /opt/vidiun/AsyncApiProxy/latest
3. cp -p /opt/vidiun/AsyncApiProxy/latest/config/default.template.json /opt/vidiun/AsyncApiProxy/latest/config/default.json
4. cp -p /opt/vidiun/AsyncApiProxy/latest/bin/async-proxy-server.template.sh /opt/vidiun/AsyncApiProxy/latest/bin/async-proxy-server.sh

5. ln -s /opt/vidiun/AsyncApiProxy/latest/bin/async-proxy-server.sh /etc/init.d/vidiun_async_proxy
6. Replace the following tokens in default.json:
```
@LOG_DIR@ - Your logs directory
@WWW_HOST@ - Your API machine host
@HTTP_PORT@ - HTTP port to run the server with
@HTTPS_PORT@ - HTTPS port to run the server with
@APP_REMOTE_ADDR_HEADER_SALT@ - Should be identical to "remote_addr_header_salt" configured in you Vidiun Server configuration
```

7. Replace the following tokens in async-proxy-server.sh:
```
@ASYNC_API_PROXY_PREFIX@ - Async API Proxy prefix
@LOG_DIR@ - Your logs directory
```

8. Start the server:
```
# /etc/init.d/vidiun_async_proxy start
```
You may also want to call chkconfig or update-rc.d so the daemon will be started during system init and stopped during shutdown.
```
# update-rc.d vidiun_async_proxy defaults
```

## Upgrading
Run ```vidiun_upgrade_async_proxy_server @RELEASE_ID@```

For example, to upgrade to 1.0 you need to execute: 
```
# vidiun_upgrade_async_proxy_server 1.0
```

The upgrade will sync all the configuration files and will restart the service.

Make sure that tokens in bin/async-proxy-server.sh file (ASYNC_PROXY_PATH and LOG_PATH) are pointing to the correct paths
