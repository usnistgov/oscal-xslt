# OSCAL XSLT Inspector

This is an implementation of the (XSLT Inspector)[] Metaschema-based XML validator.

## Testing

Testing is described in [testing.md](testing.md).

## XSLT architecture

While relying on a library to produce an InspectorXSLT from OSCAL Metaschema source, the XSLT so produced is a standalone artifact that can be applied to any OSCAL (or any XML) indiscriminately, to produce meaningful results.

This single file will typically be named after the model whose rules it validates, e.g. `oscal-catalog-inspector.xsl` for an XSLT that assesses XML according to the rules of the [OSCAL Catalog metaschema](https://pages.nist.gov/OSCAL-Reference/models/develop/catalog/).

### InspectorXSLT production

Run a script to update InspectorXSLT for any supported OSCAL model. Currently the Catalog model is supported.

```bash
> ./refresh-inspector.sh catalog
```

The script executes a Java process, requiring Maven, a JDK and (to initiate it) `bash`.

Internal dependencies on Saxon, XML Calabash (XProc engine) and other libraries is managed by Maven.

The script produces an XSLT file as output, a standalone InspectorXSLT for the metaschema module designated.

As such, this XSLT can be applied to any XML document to determine validity against the metaschema's rule set, using a standard XSLT 3.0 engine (Saxon is recommended).

### Browser deployment

One of the uses of the InspectorXSLT application is browser deployment.

See the Pages site for this repository to see a prototype demonstration, delivering logic produced using the utility here for use in a browser. The site is maintained in the `pub` directory of this repository, with the application in folder [pub/InspectorXSLT](../pub/InspectorXSLT/).

This is accomplished by means of an "outfitter" XSLT that imports the Inspector XSLT and uses its templates. This configuration, integration and interfacing XSLT is then compiled for use by the SaxonJS Node JS application framework into a static object for delivery over the web.

Consequently any web page 


## Punchlist

1. XProc to produce an InspectorXSLT (XSLT stylesheet) from a designated metaschema source.
 - Maintain both the XProc subpipeline for generating, and the sources, off site in respective repositories
 - Script this so it works under bash/Maven reliably
   - `generate-oscal-catalog-inspector.sh`
   - Using `OSCAL-INSPECTOR-XSLT.xpr`

 2. OSCAL model workout
  - OSCAL examples as tests
  - Emulate/shadow metaschema-xslt/InspectorXSLT testing
  - Need both 'good' and 'known bad' examples
    - Load Example from page
  - XSpec this! for batch testing    

3. Site setup
  - In `pub`
  - Minimalistic landing page adapted from OSCAL Tools
  - Separate pages per OSCAL document type? to start (maybe merge later)
  - Support incremental approach
    - one model at a time
    - tracking implementation issues as we go
  - Scripts to support compiling XSLT into `.sef.json`, with instructions 

4. "Adapter" XSLT `oscal-inspector-fixup.xsl` shows the delta between OSCAL requirements and current InspectorXSLT capabilities.
  - Work this down to zero Δ

### Enhancements to Inspector

- Current hangups:
  - `allowed-values` semantics
    - constraint cascade can tunnel allowed values through as a parameter
    - received by a catch-all allowed-values tester at the bottom
  - Anytime `@target` is not a pattern ...
    - detect these with a Schematron with iXML grammar?
    - throw them into match="*" with a dead-reckoned path (not pattern) for matching?
      - (that could be expensive if every node is tested for every constraint in the cascade)
  - `index`, `index-has-key` build their own indexes as maps
- Warn about constraints not being tested

 
