# Changelog

## 0.1.2 (2019-08-24)

If the response didn't have a 200 status, the error message was raising trying to use Access behavior on a struct. This fixes it and adds a couple of tests.

## 0.1.1 (2019-08-20)

Build was failing when imported into another project, because global config was being used to determine test environment. Global config was replaced by local config.

## 0.1.0 (2019-08-18)

Initial (alpha) release, supporting only the `Telnyx.Message.create/2` action. Tests are passing and a lot of structure has been built.