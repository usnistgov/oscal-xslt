# Testing

This repository contains XSLT transformations in various stages of maturity, including both well-developed application code, ad-hoc utility code accomplishing transformation 'chores', and everything in between.

They are included here because even less-mature applications can be useful as demonstrations or starting points for reuse. By and large they also constitute work product in the public domain (as developed as part of ongoing research into data processing conducted under US government auspices with its support), and so are published without warranty, but with provision for reuse.

Because of the 'research' nature of the capabilities here, however, users and developers should keep in mind that ongoing, continuing testing is both necessary and proper - as it is not only for immature applications but mature well-tested ones as well. 

## Testing per project

Each subdirectory in this repository may have its own `TESTING.md` file describing testing appropriate for that project.

## Interactive testing

XSLT can be tested by running transformations on known inputs and inspecting results (output artifacts) for conformance to requirements.

This can be done in an isolated environment (not on the Internet) to help ensure process integrity. Everything on this site should work standalone without dependency on external processes or resources, *unless noted per project*. Consult project docs and poll XSLT source files for assurance.

## Functional (unit) testing

Since the security impacts of process failures here are generally fairly low, not much functional testing has been formalized and externalized for these projects, but where this is necessary or useful, [XSpec](https://github.com/xspec/xspec) is the preferred mechanism.

A notable exception to the above is the OSCAL Inspector application (in development), which as a *validation* application is an exception to the above - if the impacts of false results (if documents are incorrectly reported to be valid or invalid, against OSCAL's definitions) can be said to have security implications, which they might.

Accordingly this application unlike others should be provided with a set of functional unit tests demonstrating correctness against requirements. At time of writing, this work remains to be done.

See any available notes on testing in project folders for more details.
