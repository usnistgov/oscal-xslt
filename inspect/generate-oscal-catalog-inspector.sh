#!/usr/bin/env bash

# Simple invocation of the pipeline OSCAL-INSPECTOR-XSLT.xpl
# which hard-wires the production of InspectorXSLT for OSCAL formats (currently catalog)

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../common/subcommand_common.bash
source "$SCRIPT_DIR/../../../common/subcommand_common.bash"

usage() {
    cat <<EOF
Usage: ${BASE_COMMAND:-$(basename "${BASH_SOURCE[0]}")} [ADDITIONAL_ARGS]

Refreshes current/oscal-catalog_inspector.xsl along with other (debugging) artifacts -
Check `current` folder for outputs
EOF
}

if ! [ -x "$(command -v mvn)" ]; then
  echo 'Error: Maven (mvn) is not in the PATH, is it installed?' >&2
  exit 1
fi

ADDITIONAL_ARGS=$(echo "${*// /\\ }")

PIPELINE="${SCRIPT_DIR}/OSCAL-INSPECTOR-XSLT.xpl"

CALABASH_ARGS="$ADDITIONAL_ARGS \"$PIPELINE\""

invoke_calabash "${CALABASH_ARGS}"
