#!/usr/bin/env bash
#
# Usage: ./generate-cloudformation-template.sh [name]
# The [name] is the CloudFormation stack name, and defaults to 'deis'
# Outputs the json for cloud formation updates, upload this as a change-set in cloudformation to see
# the resulting changes

if [ -z "$1" ]
  then
    NAME=deis
  else
    NAME=$1
fi

set -e

THIS_DIR=$(cd $(dirname $0); pwd) # absolute path
CONTRIB_DIR=$(dirname $THIS_DIR)

source $CONTRIB_DIR/utils.sh

# check that the CoreOS user-data file is valid
$CONTRIB_DIR/util/check-user-data.sh

$THIS_DIR/gen-json.py --channel $COREOS_CHANNEL --version $COREOS_VERSION --stack-name $NAME
