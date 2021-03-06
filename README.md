# Preventive Care Screening and Patient-Directed Care Plans

This repository houses the source for building a CPG-on-FHIR content implementation guide for preventive care screening and personalized, patient-directed care plans based on the [U.S. Preventive Services Task Force (USPSTF) guidelines](https://www.uspreventiveservicestaskforce.org/uspstf/recommendation-topics).

The contents of this repository are licensed under an Apache 2.0 License with an additional healthcare related disclaimer and limitation of warranty. See the [LICENSE](LICENSE) page for details.

## Publication

This Implementation Guide is published in the following locations:

* Continuous Build: https://chronic-care.github.io/preventive-care-ig/
* QA Report: https://chronic-care.github.io/preventive-care-ig/qa.html

## Content IG Walkthrough: Setup and Build

The first step is to get a local [clone](https://docs.github.com/en/free-pro-team@latest/github/creating-cloning-and-archiving-repositories/cloning-a-repository) of this repository.

Once you have a local clone, you'll need to build:

### Dependencies

Before you're able to build this IG you'll need to install several dependencies

#### Java / IG Publisher

Go to [https://adoptopenjdk.net/](https://adoptopenjdk.net/) and download the latest (version 8 or higher) JDK for your platform, and install it.

There are scripts in this repository that will download and run the latest HL7 IG Publisher.

Please make sure that the Java bin directory is added to your path.

This project includes scripts that will automatically download the correct version of the IG-Publisher.

Documentation for the IG-Publisher is available at [https://confluence.hl7.org/display/FHIR/IG+Publisher+Documentation](https://confluence.hl7.org/display/FHIR/IG+Publisher+Documentation).

#### Ruby / Jekyll

Jekyll requires Ruby version 2.1 or greater. Depending on your operating system, you may already have Ruby bundled with it. Otherwise, or if you need a newer version, go to [https://www.ruby-lang.org/en/downloads/](https://www.ruby-lang.org/en/downloads/) for directions.

Jekyll

Go to [https://jekyllrb.com](https://jekyllrb.com) and follow the instructions there, for example gem install jekyll bundler. The end result of this should be that the binary "jekyll" is now in your path.

### Build

Once you have the dependencies installed, you can build the IG by first updating the publisher:

```
_updatePublisher
```

Once the publisher has been downloaded to your local environment, you can build the IG:

```
_genonce
```

Whenever you make changes to the source content, just rerun the `_genonce` script to rebuild the IG. The IG output will be in the output folder. Using a browser, open the `index.html` page to see the IG.

## Atom CQL Support

To validate and test CQL, use the [Atom CQL Plugin](https://github.com/cqframework/atom_cql_support). Follow the instructions there to install the plugin, then open Atom on the root folder of this  content IG walkthrough.

## Publishing as an NPM Package

The IG can be packaged as an [`npm` package](https://docs.npmjs.com/packages-and-modules) for use in JavaScript applications.
