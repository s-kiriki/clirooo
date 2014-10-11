#!/bin/bash

if [[ ! -r client/webroot/js/source/setting.coffee ]]; then
 /bin/cp client/webroot/js/source/setting.coffee.default client/webroot/js/source/setting.coffee
fi