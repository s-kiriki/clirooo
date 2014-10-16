#!/bin/bash

if [[ ! -r webroot/js/source/setting.coffee ]]; then
 /bin/cp webroot/js/source/setting.coffee.default webroot/js/source/setting.coffee
fi