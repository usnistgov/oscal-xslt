# OSCAL XSLT Inspector

This is an implementation of the (XSLT Inspector)[] Metaschema-based XML validator.

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

 
