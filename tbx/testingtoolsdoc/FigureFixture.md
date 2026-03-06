# `FigureFixture`

A custom MATLAB unit test fixture for managing the lifecycle of a `uifigure` during testing.

## Overview

`FigureFixture` is a subclass of [`matlab.unittest.fixtures.Fixture`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.fixtures.fixture.html) designed to create and clean up a `uifigure` for use in unit tests. It enables tests to use a new figure, optionally configured via name-value arguments, and ensures the figure is deleted after the test completes.

## Properties

| Property         | Access         | Description                                                  |
|------------------|---------------|--------------------------------------------------------------|
| `Figure`         | Read-only    | Handle to the test `uifigure` instance (scalar or empty).    |
| `FigureArguments`| Read-only     | Struct of arguments used to create the figure.               |

## Constructor

### `FigureFixture(name, value, ...)`

- **Description**: Constructs the fixture, optionally accepting name-value pairs for figure creation.  
- **Input**:  Name-value pairs corresponding to `matlab.ui.Figure` properties.

```matlab
fixture = FigureFixture("Name", "Test Figure", "Position", [100 100 400 300]);
```

## Example

```matlab
classdef MyUITest < TestCase

    methods(Test)

        function tFigure(testCase)
            
            % Add the fixture to the test
            fix = FigureFixture();
            testCase.applyFixture( fix );
            
            % Access the figure handle
            fig = fix.Figure;
            testCase.verifyTrue( isvalid( fig ) )

        end

    end

end
```
## Fixture Lifecycle

- **Setup**:  
  - Creates a new `uifigure` with the specified properties.
- **Teardown**:  
  - Deletes the created figure to ensure no side effects between tests.

## See Also

- [`matlab.unittest.fixtures.Fixture`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.fixtures.fixture-class.html)
- [`uifigure`](https://www.mathworks.com/help/matlab/ref/uifigure.html)