# Cognition Package

[![pub package](https://img.shields.io/pub/v/research_package.svg)](https://pub.dartlang.org/packages/research_package)
[![style: recommended](https://img.shields.io/badge/style-lint-4BC0F5.svg)](https://pub.dev/packages/lints)
[![github stars](https://img.shields.io/github/stars/cph-cachet/cognition_package.svg?style=flat&logo=github&colorB=deeppink&label=stars)](https://github.com/cph-cachet/cognition_package)
[![MIT License](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)

Cognition Package is a Flutter [package](https://pub.dartlang.org/packages/research_package) for building cognitive tests for study apps on Android and iOS built using [CARP Research Package](https://pub.dartlang.org/packages/research_package) using [Flutter](https://flutter.dev).


Cognition Package is a Flutter implementation of a Cognitive test battery including 14 validated gold-standard cognitive tests spanning all 8 Neurocognitive domains:
1. Sensation
2. Perception
3. Motor skills and construction
4. Attention and concentration
5. Memory
6. Executive functioning
7. Processing speed
8. Language and verbal skills

The tests in Cognition Package are implemented as ActivitySteps from [Research Package](https://pub.dartlang.org/packages/research_package). They derive from Apple’s ResearchKit’s Active Tasks but were transformed to Steps instead so that they may be used inside an RPTask along with other types of Steps. Each test consists of 3 key sections - the instructions for the test, the test itself, and the test results.

Each test includes 3 classes that define it, 

1. The model class which extends ActivityStep and defines the parameters available for the specific test (eg. length of the test, the amount of repetitions), as well as the function to calculate the final score of the test after it is run.
2. The UI class which describes how the test is rendered on screen and the logic of running the test.
3. The Results class which describes the data collected from the test and adds it to the list of all results from the study.

The overarching goal of the Cognition Package is to enable developers and researchers to design and build cross-platform (iOS and Android) cognitive assessment applications that rely on validated gold-standard cognitive tests. 

When combined with [Research Package](https://pub.dartlang.org/packages/research_package), Cognition Package meets the requirements of most scientific research, including capturing participant consent, extensible input tasks, and the security and privacy needs necessary for IRB approval.
The current set of cognitive tests in the Cognition Package are:

1. [Multiple Object Tracking (MOT)](https://www.cambridgecognition.com/cantab/cognitive-tests/attention/adaptive-tracking-task-att/)
2. [Corsi Block Tapping(CBT)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5619435/)
3. [Verbal Recognition Memory (VRM)](https://www.cambridgecognition.com/cantab/cognitive-tests/memory/verbal-recognition-memory-vrm/)
4. [Delayed Recall](https://www.psychdb.com/cognitive-testing/moca#delayed-recall)
5. [Flanker](https://cognitionlab.com/project/flanker-task/)
6. [Letter Tapping](https://www.psychdb.com/cognitive-testing/moca#attention-vigilance)
7. [Paired Associative Learning (PAL)](https://www.cambridgecognition.com/cantab/cognitive-tests/memory/paired-associates-learning-pal/)
8. [Picture Sequence Memory (PSMT)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4254833/)
9. [Rapid Visual Information Processing (RVP)](https://www.cambridgecognition.com/cantab/cognitive-tests/attention/rapid-visual-information-processing-rvp/)
10. [Reaction Time (RTI)](https://www.cambridgecognition.com/cantab/cognitive-tests/attention/reaction-time-rti/)
11. [Stroop Effect](https://www.frontiersin.org/articles/10.3389/fpsyg.2017.00557/full)
12. [Finger Tapping](https://www.sciencedirect.com/topics/medicine-and-dentistry/finger-tapping-test)
13. [Trail Making](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3141679/)
14. [Visual Array Change](https://jov.arvojournals.org/article.aspx?articleid=2422328)

Cognition Package is part of the overall [CACHET Research Platform (CARP)](https://carp.cachet.dk) which also provides a Flutter package for mobile and wearable sensing called [CARP Mobile Sensing](https://pub.dev/packages/carp_mobile_sensing). 

## Documentation

There is a set of tutorials, describing:

- the overall [software architecture](https://carp.cachet.dk/research-package-api/) of Cognition Package
- how to create a [cognitive assessment application](https://www.researchpackage.org/cognitive-tests)
- how to implement your own [test](https://www.researchpackage.org/cognitive-tests#implementing-your-own-test)

The [Cognition_package Flutter API](https://pub.dev/documentation/research_package/latest/) is available (and maintained) as part of the package release at pub.dev.

## Example Application

There is an [example app](https://github.com/ossi0004/speciale_cognition_app) which demonstrates the different features of Cognition Package as implemented in a Flutter app.

In the [example](/example) several configuration file can be found. A `.env` file has to be placed in the example folder for the application to work properly and the following constants has to be defined in this `.env` file: 
`````
USERNAME = ...
PASSWORD = ...
URI = ...
ID = ...
`````
These environmental variables are necessary to upload the data to the CARP server. if you want to use the example app locally, the `.env` is not necessary.

## Who is backing this project?

Cognition Package is made by the [Copenhagen Center for Health Technology (CACHET)](https://www.cachet.dk/) and is a component in the [CACHET Research Platform (CARP)](https://carp.cachet.dk), which is used in a number of applications and studies. 
The current project maintainer is [Ossi kallunki](https://github.com/ossi0004).

## How can I contribute?

We are more than happy to take contributions and feedback. 
Use the [Issues](https://github.com/cph-cachet/cognition_package/issues) page to file an issue or feature request. 
Besides general help for enhacement and quality assurance (bug fixing), we welcome input on new answer types.

## License

This software is copyright (c) [Copenhagen Center for Health Technology (CACHET)](https://www.cachet.dk/) 
at the [Technical University of Denmark (DTU)](https://www.dtu.dk).
This software is available 'as-is' under a [MIT license](https://github.com/cph-cachet/research.package/blob/master/LICENSE).
