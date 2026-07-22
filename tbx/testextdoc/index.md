# Test Framework Extensions Toolbox

The Test Framework Extensions toolbox provides custom [constraints](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.constraint-class.html), [fixtures](https://www.mathworks.com/help/matlab/ref/matlab.unittest.fixtures.fixture-class.html), and [plugins](https://www.mathworks.com/help/matlab/ref/matlab.unittest.plugins.testrunnerplugin-class.html) to aid the testing of MATLAB code.

### [Constraints](Constraints.md)
* [`DatetimeTolerance`](DatetimeTolerance.md) - allow non-exact matching of datetimes and durations.
* [`HasStringLengthLessThan`](HasStringLengthLessThan.md) - check that string length is less than a set value.
* [`IsEqualVector`](IsEqualVector.md) - are two vectors equal irrespective of row or column orientation.
* [`IsEquivalentText`](IsEquivalentText.md) - is text equal irrespective of `string`, `char`, or `cellstr` type.
* [`IsSamePathAs`](IsSamePathAs.md) - are paths equal irrespective of data type, file separator, and (Windows) capitalization.
* [`MatchesStatistically`](MatchesStatistically.md) - are at least a certain percentage of elements equal within a tolerance.
* [`NotifiesEvent`](NotifiesEvent.md) - check that a function or method call notifies an event.
* [`NotifiesPropertyEvent`](NotifiesPropertyEvent.md) - check that a function or method call notifies a property event.
* [`PassesEventData`](PassesEventData.md) - check that a function or method call notifies an event with custom event data.

### [Fixtures](Fixtures.md)
* [`FigureFixture`](FigureFixture.md) - create a figure and close it on teardown.
* [`GridLayoutFixture`](GridLayoutFixture.md) - create a grid layout and delete it on teardown.
* [`PreferenceFixture`](PreferenceFixture.md) - override a MATLAB preference and restore it on teardown.
* [`SimulinkModelFixture`](SimulinkModelFixture.md) - load a Simulink model and close it on teardown.
* [`SuppressParpoolAutocreateFixture`](SuppressParpoolAutocreateFixture.md) - suppress the automatic creation of parpools and restore the original setting in teardown.

### [Plugins](Plugins.md)
* [`FailOnSpecificWarningsPlugin`](FailOnSpecificWarningsPlugin.md) - fail tests that issue selected warnings.

### [Alias](Alias.md)
* [`Testable`](Testable.md) - alias for [`matlab.uitest.TestCase`](https://www.mathworks.com/help/matlab/ref/matlab.uitest.testcase-class.html)

The documentation provides examples of how to use these constraints, fixtures, and plugins.
