#!/bin/bash

#********************************************************************************
# Copyright 2014 IBM
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#********************************************************************************

set +e
set +x 





# need node 4.x and above to run grunt-idra3 now
export PATH=/opt/IBM/node-v4.2/bin:$PATH



# install dev version of the plugin in stage1
if [[ $IDS_URL == *"stage1"* ]]; then
    npm install -g grunt-idra3@dev &>/dev/null
else
    npm install -g grunt-idra3 &>/dev/null
fi



if [ -n "${DRA_CRITERIA}" ] && [ "${DRA_CRITERIA}" != " " ]; then
    idra --evaluategate --policy="${DRA_CRITERIA}" --forcedecision=true
else
    echo "The Policy Name must be declared."
    exit 1
fi