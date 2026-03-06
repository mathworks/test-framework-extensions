# Testing Tools

[![Open in MATLAB Online](readme/open-in-matlab-online.svg)](https://matlab.mathworks.com/open/github/v1?repo=mathworks/matlab-testing-tools&project=TestingTools.prj)

Testing tools provides a number of utilities (custom [constraints](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.constraint-class.html) and [fixtures](https://www.mathworks.com/help/matlab/ref/matlab.unittest.fixtures.fixture-class.html)) to aid the testing of MATLAB code.

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
* `PreferenceFixture` - override a MATLAB preference and restore it on teardown.
* `SimulinkModelFixture` - load a Simulink model and close it on teardown.
* `SuppressParpoolAutocreateFixture` - suppress the automatic creation of parpools and restore the original setting in teardown.

The documentation provides examples of how to use these constraints and fixtures.

See also the [database testing framework](https://www.mathworks.com/matlabcentral/fileexchange/77101-database-testing-framework).

## Installation and Getting Started
1. Testing Tools is provided as a [MATLAB Toolbox](https://www.mathworks.com/help/matlab/creating-help.html). Download the toolbox file (`TestingTools.mltbx`).
2. Double-click on the file `TestingTools.mltbx` to install it.
3. Complete the installation process.
4. Verify the toolbox installation by entering `>> ver testingtools` at the MATLAB command line.

### [MathWorks](https://www.mathworks.com) Product Requirements

Testing Tools was updated in R2025b, but is compatible with earlier releases.

- [MATLAB&reg;](https://www.mathworks.com/products/matlab.html)
- The `SimulinkModelFixture` requires [Simulink&reg;](https://www.mathworks.com/products/simulink.html).
- Usually, you will use the `SuppressParpoolAutocreateFixture` with [Parallel Computing Toolbox&trade;](https://www.mathworks.com/products/parallel-computing.html).

## License
The license is available in the [LICENSE.txt](LICENSE.txt) file in this GitHub repository.

## Community Support
[MATLAB Central](https://www.mathworks.com/matlabcentral)

Copyright 2026 The MathWorks, Inc.
