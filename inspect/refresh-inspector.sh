#!/usr/bin/env bash

# Simple invocation of the pipeline OSCAL-INSPECTOR-XSLT.xpl
# which hard-wires the production of InspectorXSLT for OSCAL formats (currently catalog)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../common/subcommand_common.bash
source "$SCRIPT_DIR/../common/subcommand_common.bash"

usage() {
    cat <<EOF
Usage: ${BASE_COMMAND:-$(basename "${BASH_SOURCE[0]}")} SCHEMA_CODE [ADDITIONAL_ARGS]

If SCHEMA_CODE is given as 'catalog', this script updates oscal-catalog_inspector.xsl using XProc pipeline generate/OSCAL-CATALOG-INSPECTOR-XSLT.xpl

Until other models are supported, any other argument returns this message.

EOF
}

if ! [ -x "$(command -v mvn)" ]; then
  echo 'Error: Maven (mvn) is not in the PATH, is it installed?' >&2
  exit 1
fi


[[ -z "${1-}" ]] && { echo "Error: OSCAL module not specified with SCHEMA_CODE ('catalog')"; usage; exit 1; }
METASCHEMA_SOURCE=$1

ADDITIONAL_ARGS=$(shift 1; echo ${*// /\\ })

# The XProc is hard-wired to save its InspectorXSLT results in 
PIPELINE="${SCRIPT_DIR}/generate/OSCAL-CATALOG-INSPECTOR-XSLT.xpl"

CALABASH_ARGS="$ADDITIONAL_ARGS \"$PIPELINE\""

## the single argument has to be 'catalog' or we stop
if [ "$1" = 'catalog' ]

then

  echo Refreshing oscal-catalog_inspector.xsl ...
  invoke_calabash "${CALABASH_ARGS}"
  ECHO ... Done
  
else

  usage

fi
