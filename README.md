# Test Framework Extensions Toolbox

[![View Test Framework Extensions Toolbox on File Exchange](readme/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/183681-test-framework-extensions-toolbox)
[![Open in MATLAB Online](readme/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=mathworks/test-framework-extensions&project=TestFrameworkExtensions.prj)
[![Test Framework Extensions Actions](https://github.com/mathworks/test-framework-extensions/actions/workflows/testext-ci.yml/badge.svg)](https://github.com/mathworks/test-framework-extensions/actions/workflows/testext-ci.yml)

The Test Framework Extensions toolbox provides a number of custom [constraints](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.constraint-class.html), [fixtures](https://www.mathworks.com/help/matlab/ref/matlab.unittest.fixtures.fixture-class.html), and [plugins](https://www.mathworks.com/help/matlab/ref/matlab.unittest.plugins.testrunnerplugin-class.html) to aid the testing of MATLAB code.

### Constraints
* `DatetimeTolerance` - allow non-exact matching of datetimes and durations.
* `HasStringLengthLessThan` - check that string length is less than a set value.
* `IsEqualVector` - are two vectors equal irrespective of row or column orientation.
* `IsEquivalentText` - is text equal irrespective of `string`, `char`, or `cellstr` type.
* `IsSamePathAs` - are paths equal irrespective of data type, file separator, and (Windows) capitalization.
* `MatchesStatistically` - are at least a certain percentage of elements equal within a tolerance.
* `NotifiesEvent` - check that a function or method call notifies an event.
* `NotifiesPropertyEvent` - check that a function or method call notifies a property event.
* `PassesEventData` - check that a function or method call notifies an event with custom event data.

### Fixtures
* `FigureFixture` - create a figure and close it on teardown.
* `GridLayoutFixture` - create a grid layout and delete it on teardown.
* `PreferenceFixture` - override a MATLAB preference and restore it on teardown.
* `SimulinkModelFixture` - load a Simulink model and close it on teardown.
* `SuppressParpoolAutocreateFixture` - suppress the automatic creation of parpools and restore the original setting in teardown.

### Plugins
* `FailOnSpecificWarningsPlugin` - fail tests that issue selected warnings.

The documentation provides examples of how to use these constraints, fixtures, and plugins.

See also the [database testing framework](https://www.mathworks.com/matlabcentral/fileexchange/77101-database-testing-framework).

## Installation and Getting Started
1. Test Framework Extensions is provided as a [MATLAB Toolbox](https://www.mathworks.com/help/matlab/creating-help.html). Download the toolbox file (`TestFrameworkExtensions.mltbx`).
2. Double-click on the file `TestFrameworkExtensions.mltbx` to install it.
3. Complete the installation process.
4. Verify the toolbox installation by entering `>> ver testframeworkextensions` at the MATLAB command line.

### [MathWorks](https://www.mathworks.com) Product Requirements

Test Framework Extensions is compatible with R2023b and later versions.

- [MATLAB&reg;](https://www.mathworks.com/products/matlab.html)
- The `SimulinkModelFixture` requires [Simulink&reg;](https://www.mathworks.com/products/simulink.html).
- Usually, you will use the `SuppressParpoolAutocreateFixture` with [Parallel Computing Toolbox&trade;](https://www.mathworks.com/products/parallel-computing.html).

## License
The license is available in the [LICENSE.txt](LICENSE.txt) file in this GitHub repository.

## Community Support
[MATLAB Central](https://www.mathworks.com/matlabcentral)

Copyright 2026 The MathWorks, Inc.
