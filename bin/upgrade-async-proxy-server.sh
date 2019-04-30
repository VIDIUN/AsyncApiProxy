#!/bin/bash
# For upgrade just type ./upgrade-async-proxy-server.sh <version>
# This uploads NVM
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" || (echo "nvm not found in $NVM_DIR, nvm is required to continue, Exiting!!!" ; exit 1 )

##### Navigate to async proxy server directory #####
cd /opt/vidiun/asyncProxyServer/
echo updating async-proxy-server to version $1

##### Check if requested version was already pulled to the machine #####
if [ ! -d "$1" ] ; then
    ##### Check if initial setup was already made following the deployment instructions #####
    if [ ! -L "$latest" ] ; then
        ##### Download the requested version release from git ##### 
        echo Try to download  https://github.com/vidiun/AsyncApiProxy/archive/$1.tar.gz
        wget https://github.com/vidiun/AsyncApiProxy/archive/$1.tar.gz
        
        ##### Unzip the source code #####
        echo try to unzip $1.tar.gz
        tar -xvzf $1.tar.gz
        mv AsyncApiProxy-$1 $1

        ##### Navigate to the downloaded version dir and install project pre-requisites #####
        cd $1
        nvm install
        npm install
        cd ..
        
        ##### Copy config file from previous latest dir to the current version being installed ##### 
        cp -p /opt/vidiun/asyncProxyServer/latest/config/default.json /opt/vidiun/asyncProxyServer/$1/config/default.json
        ##### Copy sh file from previous latest dir to the current version being installed ##### 
        cp -p /opt/vidiun/asyncProxyServer/latest/bin/async-proxy-server.sh /opt/vidiun/asyncProxyServer/$1/bin/async-proxy-server.sh
        
        ##### Copy upgarde script from previous latest dir to the current version being installed ##### 
        cp -p /opt/vidiun/asyncProxyServer/latest/bin/async-proxy-server.sh /opt/vidiun/asyncProxyServer/$1/bin/async-proxy-server.sh
        
        ##### Unlink previous version ##### 
        unlink /opt/vidiun/asyncProxyServer/latest
        unlink /etc/init.d/vidiun_upgrade_async_proxy_server
        unlink /etc/init.d/vidiun_async_proxy
        
        ##### Link new version to latest and sync execution scripts #####
        ln -s /opt/vidiun/asyncProxyServer/$1 /opt/vidiun/asyncProxyServer/latest
        ln -s /opt/vidiun/asyncProxyServer/latest/bin/upgrade-async-proxy-server.sh /etc/init.d/vidiun_upgrade_async_proxy_server
        ln -s /opt/vidiun/asyncProxyServer/latest/bin/async-proxy-server.sh /etc/init.d/vidiun_async_proxy
     
        ##### Delete downloaded zipped source files ##### 
        rm -rf /opt/vidiun/asyncProxyServer/$1.tar.gz
    else
        echo "No previous version found"
    fi
else
    echo $1 is already exist
fi
