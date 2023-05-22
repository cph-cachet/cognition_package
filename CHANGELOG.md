## 1.5.0

- Added translation support for English (`en`), Danish (`da`), French (`fr`), and Portuguese (`pt`).
- Upgrade to research_package 1.4.0 and audioplayers 4.0.0

## 1.4.1

- Upgrade to `carp_serializable: ^1.1.0` and `research_package: ^1.3.0`. Note that this entails that all polymorphic json serialization uses the type key `__type`. Hence, the json format for all the domain classes is NOT compatible with earlier versions.
- Added the `CognitionPackage.ensureInitialized()` static method to be compliant with the other CARP packages.
- Small updates to README

## 1.3.2

- Removal of all `late` Timer objects.

## 1.3.1

- Implementation of `dispose()` methods on all tests to support cancellation of a test.

## 1.3.0

- Upgrade to Research Package v. 1.1.0
- Added support for JSON serialization of Steps and Results objects
- Upgraded to Dart 2.18 and Fluter 3
- Refactoring to comply to [official Dart recommended lint rules](https://pub.dev/packages/flutter_lints)
- Update and clean up in API documentation.

## 1.2.1

- Small updates to documentation
- Code cleanup based on linter
- Removal of old serialization code (which did not work - will be implemented in a later version)

## 1.2.0

- Upgraded to Research Package 0.9.3 incl. `carp_serializable`
- Major cleanup in demo app.

## 1.1.0

- Upgraded to Flutter 3.0.0 and fixed related issues.
- Upgraded to reorderables: ^0.5.0 and fixed a bug with missing ScrollController

## 1.0.5

- Bugfixes
- Added dark mode support

## 1.0.4

- Copyright notice in the README file

## 1.0.3

- Fixed visual bug in stroop effect test
- Fixed bug in corsi bloc tapping test
- Updated example app

## 1.0.2

- Updated README.md
- Updated pubspec.yaml

## 1.0.1

- Updated README.md

## 1.0.0

- Initial release
- Supports 14 cognitive tests
