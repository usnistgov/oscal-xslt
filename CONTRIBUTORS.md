# Contributing to oscal-xslt

This project began as a spinoff of a spinoff ([OSCAL Tools](http://pages.nist.gov/oscal-tools)). It currently represents work in progress and work always-in-progress. All code is being placed in the public domain in order to make it free to use.

Note that in view of the possibility that it may receive public contributions, and in the hope and expectation that users and contributors all find themselves to be welcome to participate in its development, this site also has a [Code of Conduct](CODE_OF_CONDUCT.md).

## PRs and code

This project welcomes interest from developers (individuals or organizations) who wish to use it as a resource or contribute to it.

The easiest way to contribute to the code base is in a fork under your own control. This can serve as a platform for demonstration as well as development. You can use and benefit from your fork, and decide separately whether to contribute it to this (or any) common codebase.

If you wish to contribute to the common effort, but don't know how to begin, consider learning about testing XSLT (using [XSpec](https://github.com/xspec/xspec)) and contributing tests.

PRs nicely squashed can be accepted into the `main` branch from feature and bugfix branches.

## Site maintenance steps

In order to provide accessibility to demonstrations, a web site is produced for this repository, but it is not the site "of" the repository or any comprehensive guide to it, which is still considered to be [the repository itsef](https://github.com/usnistgov/oscal-xslt). Instead it provides a demonstration platform for some of the capabilities offered by the XSLT in the repo.

As such this site is maintained "by hand", that is to say *not* produced by a static site generator (Jekyll, Hugo or other), but instead coded in HTML, staged, tested and delivered from a folder in the repository, namely [`pub`](pub).

Typically, an application deployed on the site may have only a very small host page, with transformations in the background responsible for accessing and displaying contents in line with application requirements, as well as for interactivity.

For testing, the site can be served locally from the `pub` directory using commodity web server software such as Apache or NodeJS `http-server`.

Learn more in the [pub/readme.md](pub/readme.md).

## Issues, feature requests, ideas and bug reports

Please use [Issues](../../issues) on this site or contact us through the [OSCAL Project](http://pages.nist.gov/OSCAL).
