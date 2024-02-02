# OSCAL XSLT Demo Site

## Principles

Keep the site and CSS as lean, simple and declarative as possible.

Specialized UI features in interfaces should be coded in XSLT first - so running a "lean page" with no scripting other than the XSLT engine. No Javascript where XSLT will do (reduces complexity).

Aim to become gradually and steadily more 'complete' in commenting and reproducible testing, while reducing overhead over time by streamlining and removing (gefuffle like this).

Look to guidance from the experts such as USWDS, NIST design team and others.

Use robots, but don't be one.

### Links

- NIST guidelines
- USWDS site with design principles we seek to follow

## Maintenance plan

Some XSLTs in this site may include or import logic from other XSLTs in this repository. Since to run in the client (browser), the entire package is compiled into a single SEF for distribution, it poses no problem for deployment if XSLT modules are maintained outside the site hierarchy. As long as their dependencies are available when they are compiled and packaged they should be fully functional.

Nonetheless to aid in transparency, this project places all entry-point XSLTs in appropriate directories, so they can be linked to, examined and downloaded, and their dependencies traced. So each project will have at least one XSLT to be used as a 'root' for applications. In general, this XSLT is kept next do the SEF file produced from it. So a page that uses an SEF `oscal-transform.sef.json` is likely to have a corresponding XSLT next to it, `oscal-transform.xsl`, from which the distribution JSON file is compiled (and see below).

### Saxon library update

The SaxonJS distribution must be available in the [lib](lib) subdirectory for scripts to function.

Specifically, the file `lib/saxon-js/SaxonJS2.rt.js` will be called from scripts in the loaded HTML pages. This reduced runtime supports all of XSLT 3.0/XPath 3.1 except the `transform()` function, which requires an on-board compiler (available in `SaxonJS3.js`) but not used by any transformations here. (At time of writing.)

Download the library by running [the script](lib/download-saxonjs.sh) given in the directory (bash script requiring `curl` and `zip`).

For SaxonJS and Saxon in the browser see https://www.saxonica.com/saxon-js/documentation2/index.html.

### Regenerating SEF files

When an XSLT is updated or improved, the SEF compiled version must be refreshed.

Compiling the XSLT into SEF requires Saxon, either licensed SaxonJ (Java, versions PE or EE) or SaxonJS running under NodeJS. SaxonJS with its `xslt3` command line utility is used here for consistency but license-holders of Saxon should be able to use any version since version 10 (see their docs).

For NodeJS, install [SaxonJS](https://www.npmjs.com/package/saxon-js) and [xslt3](https://www.npmjs.com/package/xslt3) via NPM.

Scripts or documents per project will commonly capture command-line configurations and options.
