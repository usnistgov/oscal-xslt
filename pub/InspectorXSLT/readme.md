# InspectorXSLT Web Application - Validator Emulator

## to refresh

Run a script TBD to refresh SEF file

This XSLT is an 'outfitter' for XSLT in the repository here: ../../inspect/oscal-catalog-inspector.xsl

The oscal-inspect.xsl stylesheet calls templates in ../../inspect/oscal-catalog-inspector.xsl for default (copying), 'validate' and 'test' mode functionality

It then converts these validation results into HTML for pouring into the page.

## Interactivity:

1. Page nav: expand/collapse, dynamic expand, jump-to-error
1. Load your own OSCAL and validate accordingly
1. Try with some larger files
1. Load OSCAL from test repo? (../../inspect/ might have XSpec testing OSCAL?)
1. Save out error/warnings report (XML or plain text?)
