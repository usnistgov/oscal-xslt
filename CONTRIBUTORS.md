# Contributing to oscal-xslt

This project is a spinoff of a spinoff ([OSCAL Tools](http://pages.nist.gov/oscal-tools)). It currently represents work in progress and work always-in-progress. All code is being placed in the public domain in order to make it free to use.

Note that in view of the possibility that it may receive public contributions, and in the hope and expectation that users and contributors all find themselves to be welcome to participate in its development, this site also has a [Code of Conduct](CODE_OF_CONDUCT.md).

## PRs and code

The easiest way to contribute to the code base is in a fork under your own control. This can serve as a platform for demonstration as well as development. You can use and benefit from your fork, and decide separately whether to contribute it to this (or any) common codebase.

PRs nicely squashed can be accepted into the `main` branch from feature and bugfix branches.

## Site maintenance steps

In order to provide accessibility to demonstrations, a web site is produced for this repository, but it is not the site "of" the repository or any comphrehensive guide to it (which is still considered to be [the repo itsef](https://github.com/usnistgov/oscal-xslt))> Instead it provides a demonstration platform for some capabilities offered by the XSLT in the repo.

As such this site is maintained "by hand", that is to say *not* produced by a static site generator (Jekyll, Hugo or other), but instead staged, tested and delivered from a folder in the repo, namely [`pub`](pub).

For testing, this site can be served locally from the `pub` directory using commodity web server software such as Apache or NodeJS `http-server`.

## Issues, feature requests, ideas and bug reports

Please use Issues on this site or contact us through the [OSCAL Project](http://pages.nist.gov/OSCAL).
