# Testing Tools

Testing tools provides a number of utilities to aid testing of MATLAB code.

Fixtures:
1.  `matlab.unittest.fixtures.PreferenceFixture` - override a MATLAB preference and restore it on teardown.
2.  `matlab.unittest.fixtures.FigureFixture` - create a figure and close it on teardown.
3.  `matlab.unittest.fixtures.SimulinkModelFixture` - load a Simulink model and close it on teardown.

Constraints:
1.  `matlab.unittest.constraints.DatetimeTolerance` - allow non-exact matching of datetimes.
2.  `matlab.unittest.constraints.HasStringLengthLessThan` - check that string length is less than a set value.
3.  `matlab.unittest.constraints.IsMemberOfSet` - check to see if value is a member of a string, celltr, or double array.
4.  `matlab.unittest.constraints.TriggersEvent` - constraint to check that an object has triggered a particular event.
5.  `matlab.unittest.constraints.MatchesStatistically` - are at least a certain percentage of elements equal within a tolerance.

Unit tests in the `tests` folder provides examples of how to use them.

See also the [database testing framework](https://insidelabs-git.mathworks.com/timjohns/database-testing-framework).
