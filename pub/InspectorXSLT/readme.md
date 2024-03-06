# InspectorXSLT Web Application - Metaschema-based XML Validator

The [Metaschema XSLT Inspector](https://github.com/usnistgov/metaschema-xslt/tree/develop/src/schema-gen/InspectorXSLT) provides a simple way of determining the validity of an XML document against the rules defined by a metaschema. This includes the models (dictating serialization formats in XML and object notations including JSON and YAML) defined by [OSCAL](https://pages.nist.gov/OSCAL/), the Open Controls Security Assessment Language.

Metaschemas for OSCAL are maintained in its repository at https://github.com/usnistgov/OSCAL/tree/main/src/metaschema.

OSCAL validators for these sources can be produced using metaschema-xslt processing logic(https://github.com/usnistgov/metaschema-xslt/tree/develop/src/schema-gen/InspectorXSLT) and packaged and validated using testing harnesses in this repository(../../inspect/).

For delivery in the browser, this XSLT is compiled into a JSON 'plan' or configuration called 'sef' (Saxon Execution Format). This can be done using either a licensed copy of Saxon (Saxon-PE/EE) or (a cost-free option) SaxonJS, from the command line.

#### Install or refresh SaxonJS in Node JS

Find SaxonJS in [NPM](https://www.npmjs.com/package/saxon-js).

#### Run `xslt3` application to compile XSLT into SaxonJS

As noted above, the XSLT transformation to be deployed imports the XSLT `../../inspect/oscal-catalog-inspector.xsl`, located outside the web application. It is maintained separately to facilitate testing along with demonstration of its standalone use. Note that this dependency will prevent compiling or running `apply-validator.xsl` outside a copy of the repository - you should get a compile-time error.

The XSLT `apply-validator.xsl` in this folder provides "outfitter" logic for the Inspector XSLT application, defining layout, display and interaction for the browser application.

It is compiled for delivery to consuming applications (browsers) as a Saxon `sef.json` file, to be called from page script.

Accordingly, recompiling is how we update whenever time the upstream dependency changes, i.e. the Inspector XSLT source.

This will typically happen for bug fixes, new features, and new OSCAL metaschema releases and versions.

```
$ xslt3 -export:site/apply-validator.sef.json -xsl:apply-validator.xsl -nogo
```

Note that presently only the catalog model is supported. TBD is a plan for other models either via the 'Complete' metaschema, or per model.

## Interactivity:

1. Page nav: expand/collapse, dynamic expand, jump-to-error
1. 'modeling rules only' i.e. setting aside asserted constraints
1. Load your own OSCAL and validate accordingly
1. Try with some larger files
1. Load OSCAL from test repo? (../../inspect/ might have XSpec testing OSCAL?)
1. Save out error/warnings report (XML or plain text?)

## To do

Write SaxonJS script to refresh and update the Inspector XSLT dynamically
straight from metaschema source

https://github.com/usnistgov/OSCAL/releases/download/v1.1.2/oscal_catalog_metaschema_RESOLVED.xml

(RESOLVED version has no dependence on entity resolution)

step 1 - pipeline Metaschema composition?
step 2 - Metaschema->OSCAL Inspector - InspectorXSLT followed by OSCAL fixup i.e. duplicating ../inspect production pipeline in NodeJS
step 3 - Compile this XSLT producing SEF

