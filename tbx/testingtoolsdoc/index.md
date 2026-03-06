# MATLAB Testing Tools

The MATLAB Testing Tools toolbox provides a number of utilities (custom [constraints](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.constraint-class.html) and [fixtures](https://www.mathworks.com/help/matlab/ref/matlab.unittest.fixtures.fixture-class.html)) to aid the testing of MATLAB code.

### Constraints
* [`DatetimeTolerance`](DatetimeTolerance.md) - allow non-exact matching of datetimes and durations.
* [`HasStringLengthLessThan`](HasStringLengthLessThan.md) - check that string length is less than a set value.
* [`IsEqualVector`](IsEqualVector.md) - are two vectors equal irrespective of row or column orientation.
* [`IsEquivalentText`](IsEquivalentText.md) - is text equal irrespective of `string`, `char`, or `cellstr` type.
* [`IsSamePathAs`](IsSamePathAs.md) - are paths equal irrespective of data type, file separator, and (Windows) capitalization.
* [`MatchesStatistically`](MatchesStatistically.md) - are at least a certain percentage of elements equal within a tolerance.
* [`NotifiesEvent`](NotifiesEvent.md) - check that a function or method call notifies an event.
* [`NotifiesPropertyEvent`](NotifiesPropertyEvent.md) - check that a function or method call notifies a property event.
* [`PassesEventData`](PassesEventData.md) - check that a function or method call notifies an event with custom event data.

### Fixtures
* [`FigureFixture`](FigureFixture.md) - create a figure and close it on teardown.
* [`PreferenceFixture`](PreferenceFixture.md) - override a MATLAB preference and restore it on teardown.
* [`SimulinkModelFixture`](PreferenceFixture.md) - load a Simulink model and close it on teardown.
* [`SuppressParpoolAutocreateFixture`](SuppressParpoolAutocreateFixture.md) - suppress the automatic creation of parpools and restore the original setting in teardown.

The documentation provides examples of how to use these constraints and fixtures.