# OSCAL XSLT Inspector

This is an implementation of the (XSLT Inspector)[] Metaschema-based XML validator.

## Punchlist

1. XProc to produce an InspectorXSLT (XSLT stylesheet) from a designated metaschema source.
 - Maintain both the XProc subpipeline for generating, and the sources, off site in respective repositories
 - Script this so it works under bash/Maven reliably
   - `generate-oscal-catalog-inspector.sh` 
 - Or should the pipeline move the OSCALizer into this repo? (it probably should)

2. Site setup
  - In `pub`
  - Minimalistic landing page adapted from OSCAL Tools
  - Separate pages per OSCAL document type? to start (maybe merge later)
  - Support incremental approach
    - one model at a time
    - tracking implementation issues as we go
  - Scripts to support compiling XSLT into `.sef.json`, with instructions 

3. OSCAL model workout
  - OSCAL examples as tests
  - Emulate/shadow metaschema-xslt/InspectorXSLT testing
  - Need both 'good' and 'known bad' examples
    - Load Example from page
  - XSpec this! for batch testing    

4. "Adapter" XSLT `oscal-inspector-fixup.xsl` shows the delta between OSCAL requirements and current InspectorXSLT capabilities.
  - Work this down to zero Δ

### Enhancements to Inspector

- Current hangups:
  - `allowed-values` semantics
  - Anytime `@target` is not a pattern ...
    - detect these with a Schematron with iXML grammar?
- Warn about constraints not being tested

 
