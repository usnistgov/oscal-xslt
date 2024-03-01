#!/bin/bash

# This script attempts to download current OSCAL XSDs, as indicated

mkdir -p lib

# Script follows an example by NTW, with thanks
# https://github.com/usnistgov/OSCAL/releases/download/v1.1.2/oscal_catalog_schema.xsd

# calling curl (required) with options
# -s run silently
# -L retry at new location if redirected
# -o (output location)
download() {
    model=$1
    lcmodel=`echo $model | tr '[:upper:'] '[:lower:]'`
    schemafilename=oscal_"$lcmodel"_schema.xsd
    uri="https://github.com/usnistgov/OSCAL/releases/download/v1.1.2/$schemafilename"
    echo "Updating lib/$schemafilename --"
    echo "-- from $uri"
    curl -s -L -o lib/$schemafilename $uri
}

download catalog
download complete
