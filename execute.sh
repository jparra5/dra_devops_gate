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
#   $3  Application Name
#
function dra_command_for_decision {
    echo -e "${no_color}"
    
    grunt --gruntfile=node_modules/grunt-idra3/idra.js -decision="$1" -env="$2" -runtime="$3" --no-color
    GRUNT_RESULT=$?

    debugme echo "GRUNT_RESULT: $GRUNT_RESULT"

    if [ $GRUNT_RESULT -ne 0 ]; then
        exit 1
    fi
    
    echo -e "${no_color}"
}










callOpenToolchainAPI

printInitialDRAMessage

installDRADependencies

custom_cmd


echo -e "${no_color}"
debugme echo "DRA_CRITERIA: ${DRA_CRITERIA}"
debugme echo "DRA_ENVIRONMENT: ${DRA_ENVIRONMENT}"
debugme echo "DRA_APPLICATION_NAME: ${DRA_APPLICATION_NAME}"

debugme echo "CF_CONTROLLER: ${CF_CONTROLLER}"
debugme echo "DRA_SERVER: ${DRA_SERVER}"
debugme echo "DLMS_SERVER: ${DLMS_SERVER}"
debugme echo "CF_ORGANIZATION_ID: $CF_ORGANIZATION_ID"
debugme echo "PIPELINE_INITIAL_STAGE_EXECUTION_ID: $PIPELINE_INITIAL_STAGE_EXECUTION_ID"
debugme echo -e "${no_color}"




if [ -n "${DRA_CRITERIA}" ] && [ "${DRA_CRITERIA}" != " " ] && \
    [ -n "${DRA_ENVIRONMENT}" ] && [ "${DRA_ENVIRONMENT}" != " " ] && \
    [ -n "${DRA_APPLICATION_NAME}" ] && [ "${DRA_APPLICATION_NAME}" != " " ]; then

    dra_command_for_decision "${DRA_CRITERIA}" "${DRA_ENVIRONMENT}" "${DRA_APPLICATION_NAME}"
    
else
    echo -e "${no_color}"
    echo -e "${red}The Criteria Name, Environment Name, and Application Name must be declared."
    echo -e "${no_color}"
fi




