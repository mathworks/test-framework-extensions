# Fixtures

Custom fixtures for creating and restoring test state in MATLAB.

## Available Fixtures

* [`FigureFixture`](FigureFixture.md) - create a figure and close
  it on teardown.
* [`GridLayoutFixture`](GridLayoutFixture.md) - create a grid
  layout and delete it on teardown.
* [`PreferenceFixture`](PreferenceFixture.md) - override a MATLAB
  preference and restore it on teardown.
* [`SimulinkModelFixture`](SimulinkModelFixture.md) - load a
  Simulink model and close it on teardown.
* [`SuppressParpoolAutocreateFixture`](
  SuppressParpoolAutocreateFixture.md) - suppress the automatic
  creation of parpools and restore the original setting in
  teardown.

## See Also

* [Test Framework Extensions Toolbox](index.md)
* [Constraints](Constraints.md)
* [Plugins](Plugins.md)
* [Alias](Alias.md)
