#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck source=../common/subcommand_common.bash

source "$SCRIPT_DIR/../../../common/subcommand_common.bash"

# XProc produces Inspector XSLT with a fail-safe check by compiling and running it
XPROC_FILE="${SCRIPT_DIR}/COMPUTER-INSPECTOR-PRODUCE.xpl"

usage() {
    cat <<EOF
Usage: ${BASE_COMMAND:-$(basename "${BASH_SOURCE[0]}")} [ADDITIONAL_ARGS]

Generates an Inpspector XSLT on computer_metaschema.xml and applies it to a document.

As a smoke test, this fails if either an XSLT cannot be produced, or if it errors on known inputs.

See pipeline COMPUTER-INSPECTOR-TEST.xpl for dependencies.

EOF
}

ADDITIONAL_ARGS=$(echo "${*// /\\ }")

CALABASH_ARGS="-oINSPECTOR-XSLT=/dev/null $ADDITIONAL_ARGS \"${XPROC_FILE}\""

# echo "${CALABASH_ARGS}"

invoke_calabash "${CALABASH_ARGS}"

echo Computer Model Inspector XSLT produced and run - without apparent error