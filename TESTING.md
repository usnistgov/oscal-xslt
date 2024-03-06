# Testing

This repository contains XSLT transformations in various stages of maturity, including both well-developed application code, ad-hoc utility code accomplishing transformation 'chores', and everything in between.

They are included here because even less-mature applications can be useful as demonstrations or starting points for reuse. By and large they also constitute work product in the public domain (as developed as part of ongoing research into data processing conducted under US government auspices with its support), and so are published without warranty, but with provision for reuse.

Because of the 'research' nature of the capabilities here, however, users and developers should keep in mind that ongoing, continuing testing is both necessary and proper - as it is not only for immature applications but mature well-tested ones as well. 

## Bottom-up incremental maturity model

As a mix of more and less mature, well-tested and well-documented utilities, this repository relies on a "distributed knowledge" model wherein expertise developed in the branches is gradually attracted into the core.

In practical terms, this means that in subprojects where testing is relatively weak or underdeveloped, it can be improved by borrowing testing capabilities from other branches (including scripts and pipelines, as adapted) and by refactoring those capabilities to be available to all subprojects, when they are usefully generalized.

In this way each development branch can improve by emulating the others.

Keep in mind that some processes lend themselves better to black-box testing than others. XSpec tests (`*.xspec`) are essential for some applications, if only for assurance purposes, while less so for others.

### Hint: learn by trying

While many of the components here are designed for use and deployment in a range of environments (where they may work without being seen), everything is also designed so it can 'degrade gracefully' to use with commodity tools on an open-source platform. This helps facilitate use by developers, adaptation to new platforms and environments, and third-party analysis.

As a counter to 'blind trust', include the source code of scripts, pipelines and even stylesheets themselves in your review of documentation, prior to running scripts or executing pipelines or transformations. These are made to be as legible and self-explanatory as possible even to readers unfamiliar with the languages or idioms in use -- not only to aid users and stakeholders for assessment purposes, but to make them easier to copy and adapt.

If you have first reviewed documentation and (to whatever extent is useful) source code, you should be able to open a `bash` shell (with a copy, clone or fork of the repository) and execute any scripts available, along with `make` (starting with `make help`), to assess their functionality. Usual caveats apply regarding assumptions of risk. The commodity tools used here (including XSLT and XProc processors) support fourth-generation (4GL) languages designed on principles of no-side-effects and Least Power; so compared to other stacks (especially web-based and internet-enabled stacks) they are relatively secure to run, despite their power and versatility. However, caution is always warranted when running scripts of any nature.

## Dependencies, off-line testing, and portability

While many of these processes are designed to work on the Internet, they should not require access to the Internet or any network or out-of-band resources to run. Some of the infrastucture (such as Maven) may require network access for acquisition of dependencies (libraries), but once these have been cached locally, no further connection should be necessary.

Since [XSLT](https://www.w3.org/TR/xslt-30/) and [XProc](https://www.w3.org/TR/xproc/) are standard technologies, these resources at least should be portable to other environments relying on the same or other conformant implementations.

## Testing per project

Each subdirectory in this repository may have its own `TESTING.md` file describing testing appropriate for that project, and/or a `testing` folder.

## Interactive testing

XSLT can always be tested by running transformations on known inputs and inspecting results (output artifacts) for conformance to requirements.

This can be done in an isolated environment (not on the Internet) to help ensure process integrity. Everything on this site should work standalone without dependency on external processes or resources, *unless noted per project*. Consult project docs and poll XSLT source files for assurance.

## Functional (unit) testing

Since the security impacts of process failures here are generally fairly low, not much functional testing has been formalized and externalized for these projects, but where this is necessary or useful, [XSpec](https://github.com/xspec/xspec) is the preferred mechanism.

A notable exception to the above is the OSCAL Inspector application (in development), which as a *validation* application is an exception to the above - if the impacts of false results (if documents are incorrectly reported to be valid or invalid, against OSCAL's definitions) can be said to have security implications, which they might.

Accordingly this application unlike others should be provided with a set of functional unit tests demonstrating correctness against requirements. At time of writing, this work remains to be done.

See any available notes on testing in project folders for more details.
