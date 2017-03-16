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




#
# Build Grunt-Idra call
#
#   $1  Criteria
#   $2  Environment
#
function dra_command_for_decision {
    debugme echo -e "${no_color}"
    node_modules_dir=`npm root`

    if [ -n "$2" ] && [ "$2" != " " ]; then
        grunt --gruntfile="$node_modules_dir/grunt-idra3/idra.js" -decision="$1" -env="$2" --no-color
        GRUNT_RESULT=$?
    else
        grunt --gruntfile="$node_modules_dir/grunt-idra3/idra.js" -decision="$1" --no-color
        GRUNT_RESULT=$?
    fi

    debugme echo "GRUNT_RESULT: $GRUNT_RESULT"

    if [ $GRUNT_RESULT -ne 0 ]; then
        exit 1
    fi
    
    echo -e "${no_color}"
}










callOpenToolchainAPI

printInitialDRAMessage

installDRADependencies


echo -e "${no_color}"
debugme echo "DRA_CRITERIA: ${DRA_CRITERIA}"
debugme echo "DRA_ENVIRONMENT: ${DRA_ENVIRONMENT}"

debugme echo "CF_CONTROLLER: ${CF_CONTROLLER}"
debugme echo "DRA_SERVER: ${DRA_SERVER}"
debugme echo "DLMS_SERVER: ${DLMS_SERVER}"
debugme echo "CF_ORG: $CF_ORG"
debugme echo "CF_ORGANIZATION_ID: $CF_ORGANIZATION_ID"
debugme echo "SLACK_WEBHOOK_URL: $SLACK_WEBHOOK_URL"
debugme echo "PIPELINE_INITIAL_STAGE_EXECUTION_ID: $PIPELINE_INITIAL_STAGE_EXECUTION_ID"
debugme echo -e "${no_color}"




if [ -n "${DRA_CRITERIA}" ] && [ "${DRA_CRITERIA}" != " " ]; then

    dra_command_for_decision "${DRA_CRITERIA}" "${DRA_ENVIRONMENT}"
    
else
    echo -e "${no_color}"
    echo -e "${red}The Policy Name must be declared."
    echo -e "${no_color}"
fi




