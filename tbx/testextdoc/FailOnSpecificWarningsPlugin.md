# `FailOnSpecificWarningsPlugin`

A custom MATLAB unit test plugin that fails tests when selected warning identifiers are issued.

## Overview

`FailOnSpecificWarningsPlugin` is a subclass of [`matlab.unittest.plugins.QualifyingPlugin`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.plugins.qualifyingplugin-class.html) that records warnings during test execution and fails tests only for warning identifiers that you specify. Warnings verified with [`verifyWarning`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.qualifications.verifiable.verifywarning.html) are treated as expected and do not fail the test.

## Properties

| Property             | Access    | Description                                  |
|----------------------|-----------|----------------------------------------------|
| `WarningIdentifiers` | Read-only | Warning identifiers that cause test failure. |

## Constructor

### `FailOnSpecificWarningsPlugin(identifiers)`

- **Description**: Constructs a plugin that fails tests when any warning identifier in `identifiers` is issued.
- **Inputs**:
  - `identifiers` (text): Warning identifier or vector of warning identifiers to fail on.

```matlab
plugin = FailOnSpecificWarningsPlugin("myComponent:DeprecatedWorkflow");
plugin = FailOnSpecificWarningsPlugin([
    "myComponent:DeprecatedWorkflow"
    "myComponent:SlowFallback"
]);
```

## Example

```matlab
import matlab.unittest.TestRunner

suite = testsuite("myTestClass");
runner = TestRunner.withTextOutput;
runner.addPlugin(FailOnSpecificWarningsPlugin("myCode:UnexpectedWarning"));

results = runner.run(suite);
```

## Plugin Behavior

- **Fails a test if**:
  A warning with one of the configured identifiers is issued during test method setup, test method execution, test method teardown, test class setup, test class teardown, shared fixture setup, or shared fixture teardown.
- **Allows a test to pass if**:
  No configured warning is issued, a warning has a different identifier, or the configured warning is expected with `verifyWarning`.

## See Also

- [`matlab.unittest.plugins.QualifyingPlugin`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.plugins.qualifyingplugin-class.html)
- [`matlab.unittest.TestRunner`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.testrunner-class.html)
- [`verifyWarning`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.qualifications.verifiable.verifywarning.html)
