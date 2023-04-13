#!/usr/bin/env bash

# Fail early if an error occurs
set -Eeuo pipefail

usage() {
    cat <<EOF
Usage: $(basename "${BASH_SOURCE[0]}") CATALOG_XML RESULT_PDF [ADDITIONAL_ARGS]

Transforms and formats an OSCAL XML Catalog into PDF using Saxon, FOP and XML Calabash invoked from Maven.
Please install Maven first.

Additional arguments should be specified in the `key=value` format.
EOF
}

if ! [ -x "$(command -v mvn)" ]; then
  echo 'Error: Maven (mvn) is not in the PATH, is it installed?' >&2
  exit 1
fi

[[ -z "${1-}" ]] && { echo "Error: CATALOG_XML not specified"; usage; exit 1; }
CATALOG_XML=$1
[[ -z "${2-}" ]] && { echo "Error: RESULT_PDF not specified"; usage; exit 1; }
RESULT_PDF=$2

ADDITIONAL_ARGS=$(shift 2; echo $@)

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
POM_FILE="${SCRIPT_DIR}/../pom.xml"

MAIN_CLASS="com.xmlcalabash.drivers.Main" # XML Calabash

PIPELINE="render-oscal-catalog.xpl"

mvn \
    -f "$POM_FILE" \
    exec:java \
    -Dexec.mainClass="$MAIN_CLASS" \
    -Dcom.xmlcalabash.fo-processor="com.xmlcalabash.util.FoFOP" \
    -Dexec.args="-iOSCAL=$CATALOG_XML -oHTML=/dev/null -oFO=/dev/null $ADDITIONAL_ARGS $PIPELINE result-pdf-path=$RESULT_PDF"
