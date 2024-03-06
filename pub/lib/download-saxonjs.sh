#!/bin/bash

# This script downloads SaxonJS from Saxonica for distribution
# See https://www.saxonica.com/saxon-js/index.xml
# A license file is included

# NB this script removes saxon-js/SaxonJS2.js leaving only saxon-js/SaxonJS2.rt.js for distribution
# this is a MINIMIZED VERSION that does not support the transform() function
# If that functionality is needed, SaxonJS2.js will also be needed

# cf https://www.saxonica.com/saxon-js/documentation2/index.html#!about/components

# Thanks to NDW for script example to emulate

if [ ! -f saxon-js/SaxonJS2.rt.js ]; then
    echo "Downloading SaxonJS ..."
    curl -s -L -o SaxonJS-2.6.zip https://downloads.saxonica.com/SaxonJS/2/SaxonJS-2.6.zip
    unzip -q -o SaxonJS-2.6.zip "*.*"
    rm -f SaxonJS-2.6.zip saxon-js/SaxonJS2.js
fi

