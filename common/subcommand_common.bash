# Provides common functions for subcommands

set -Eeuo pipefail

# Each subcommand will require Maven to invoke calabash or saxon
if ! [ -x "$(command -v mvn)" ]; then
  echo 'Error: Maven (mvn) is not in the PATH, is it installed?' >&2
  exit 1
fi

_SUBCOMMAND_COMMON_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
POM_FILE="${_SUBCOMMAND_COMMON_DIR}/../pom.xml"

function exec_maven() {
    mvn --quiet \
        -f "$POM_FILE" \
        exec:java \
        -Dexec.mainClass="$1" \
        -Dexec.args="$2"
}

CALABASH_MAIN_CLASS="com.xmlcalabash.drivers.Main"

function invoke_calabash() {
    exec_maven "$CALABASH_MAIN_CLASS" "$@"
}

SAXON_MAIN_CLASS="net.sf.saxon.Transform"

function invoke_saxon() {
    exec_maven "$SAXON_MAIN_CLASS" "$@"
}

# Clean up unneeded targets
unset -f _SUBCOMMAND_COMMON_DIR
