# OSCAL XSLT

XSLT-based applications, utilities and tools for [OSCAL](https://pages.nist.gov/OSCAL), the Open Security Controls Assessment Language.

## Software description

This repository offers a library of XSLT stylesheets and pipelines supporting operations related to [OSCAL, the Open Security Controls Assessment Language](https://pages.nist.gov/OSCAL), a set of data models designed to facilitate data exchange between parties concerning the documentation, implementation and assessment of security controls and control-based policies, considered broadly but especially within the content of the [Risk Management Framework](https://csrc.nist.gov/Projects/risk-management/about-rmf).

To use these transformations (commonly called 'stylesheets') you need a conformant XSLT 3.0 transformation engine such as [Saxon 11](https://saxonica.com/documentation11/documentation.xml) from Saxonica (see SourceForge for the free-to-use HE version), which is available on several platforms and sometimes bundled with commercial software. Outside that practical requirement, this library is free to use and open for contributions.

Applications here for the most part assume inputs to be OSCAL XML, as distinct from OSCAL in other data formats such as JSON and YAML. Please convert your data first into XML before attempting to work further with these tools. XSLT-based data converters for OSCAL (capable of generating OSCAL XML from valid OSCAL JSON) are available in the [main repository](https://github.com/usnistgov/OSCAL/tree/main/xml/convert).

If there is interest in XSLT to support OSCAL JSON, YAML or other notations, please express this requirement to the developers.

###  Project purpose and maturity

The OSCAL project has published XSLT since 2018. As the technology matures and other platforms emerge, it becomes useful and necessary to separate and support the XSLT-based implementations of OSCAL processes -- many of whose capabilities may be supported using other tools -- from the main project. Consequently, these various utilities have been consolidated in this repository for long-term maintenance. We hope that a greater number of simpler dedicated repositories will be more useful to a broader range of consumers than a centralized approach.

An aspect of this design is that different projects and applications here reflect different levels of maturity. Many applications including display applications (producing HTML or PDF outputs) are also built with the purpose of supporting further customization as well, so that even 'finished' applications can be further finished. See the readme in each project to gauge its scope of application, approach to design, and level of testing. Several of the applications are also accompanied by test suites using the [XSpec XSLT Unit Testing framework](https://github.com/xspec/xspec/).

###  Repository contents

See the subdirectory list for projects and applications currently supported.

### Rights and license

See the [LICENSE.md](LICENSE.md) file. As work product of a Bureau of the Department of Commerce (U.S. Government), code in this repository is in the public domain.

To confirm the currency of the license, see the NIST Open license page at https://www.nist.gov/open/license#software.

###  Installation and use

Generally speaking these are XSLT applications, either single transformations, stacked transformations (in which imported layers provide fallbacks and importing layers, customizations), or pipelines of transformations, requiring XSLT versions as recent as [XSLT Version 3.0](https://www.w3.org/XML/Group/qtspecs/specifications/xslt-30/html/) with [XPath Version 3.1](https://www.w3.org/TR/xpath-31/).

As such they will run on any platform supporting this industry-standard, publicly available and externally specified language. The leading open-source XSLT implementation currently is Saxon from [Saxonica](https://saxonica.com/welcome/welcome.xml), available for several platforms and frequently bundled with XML editors or IDE software. However, we also welcome reports respecting other XSLT implementations supporting the appropriate XSLT version (generally 3.0).

See each project for details on its runtime requirements. Most often, single and stacked XSLTs can be executed using simple calls from a command prompt, or easily configured within tools. Pipelines may be implemented in XSLT 3.0, or may be supported via [XProc](https://xproc.org/), or both. Each folder should give further details in its README documentation.

## Contact information

Principal software engineers responsible for these projects are

- Wendell Piez, w e n d e l l (dot) p i e z (at) n i s t (dot) g o v
- David Waltermire, d a v i d (dot) w a l t e r m i r e (at) n i s t (dot) g o v

In the case of applications with significant contributions from community members there may be further contact information in the project `readme`.

For help with invocation, configuration, or diagnostics, consider using the [OSCAL Gitter chat channel](https://gitter.im/usnistgov-OSCAL/Lobby) (requires Github login), where community members can offer assistance often synchronously.

Feature requests, bug reports, and ideas for further development can be submitted to the [repository Issues board](https://github.com/usnistgov/oscal-xslt/issues).

## Citation

Cite this repository as:

Piez, Wendell, and David Waltermire, et al. *OSCAL XSLT Repository*. https://github.com/usnistgov/oscal-xslt.

## Related Material

### OSCAL

This project supports the [OSCAL project](https://pages.nist.gov/OSCAL), a family of data models supporting activities in the domain of Systems Security, which entails not only securing systems and designing and deploying secure systems; but also the assessment, documentation and validation of security.

- [OSCAL web site](https://pages.nist.gov/OSCAL)
- [OSCAL repository](https://github.com/usnistgov/OSCAL)
- [OSCAL tools site](https://pages.nist.gov/oscal-tools) and [repository](https://github.com/usnistgov/oscal-tools) (with [client-side XSLT demos](https://pages.nist.gov/oscal-tools/demos/csx))

### XSLT

XSLT, [Extensible Stylesheet Language Transformations](https://www.w3.org/XML/Group/qtspecs/specifications/xslt-30/html/), is a [fourth-generation programming language](https://en.wikipedia.org/wiki/Fourth-generation_programming_language) designed for the task of expediting tree-to-tree data transformations, where the trees concerned are abstracted representations of XML documents. That is, in addition to in-memory query, copy and manipulation, they are capable of being routinely and reliably produced by parsing XML, and persisted -- saved and exchanged across the system -- by serializing XML.

Originally intended for the purpose of making human-legible output formats such as PDF or HTML, XSLT also has more general uses, in data extraction and acquisition, normalization, rules enforcement (validation), and others. While maintaining its heritage as a declarative, functional language well-suited for prototyping, rapid deployment and agile development, the most recent version of XSLT also adds new features such as higher-order functions and pseudo-random number generation.

