# Testing Tools

Testing tools provides a number of utilities to aid testing of MATLAB code:
1.  `matlab.unittest.fixtures.PreferenceFixture` - override a MATLAB preference and restore it on teardown.
2.  `matlab.unittest.constraints.TriggersEvent` - constraint to check that an object has triggered a particular event.

Unit tests in the `tests` folder provides examples of how to use them.