# `GridLayoutFixture`

A custom MATLAB unit test fixture for managing the lifecycle of a `uigridlayout` object during testing.

## Overview

`GridLayoutFixture` is a subclass of [`matlab.unittest.fixtures.Fixture`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.fixtures.fixture.html) designed to create and clean up a `uigridlayout` for use in unit tests. It enables tests to use a new grid layout, optionally configured via name-value arguments, and ensures the grid layout is deleted after the test completes.

## Properties

| Property         | Access         | Description                                                  |
|------------------|---------------|--------------------------------------------------------------|
| `GridLayout`         | Read-only    | Handle to the test `uigridlayout` instance (scalar or empty).    |
| `GridLayoutArguments`| Read-only     | Struct of arguments used to create the grid layout.               |

## Constructor

### `GridLayoutFixture(name, value, ...)`

- **Description**: Constructs the fixture, optionally accepting name-value pairs for grid layout creation.  
- **Input**:  Name-value pairs corresponding to `matlab.ui.container.GridLayout` properties.

```matlab
fixture = GridLayoutFixture("RowHeight", "1x", "ColumnWidth", ["fit", "1x"]); 
```

## Example

```matlab
classdef MyUITest < TestCase

    methods(Test)

        function tGridLayout(testCase)
            
            % Add the fixture to the test
            fix = GridLayoutFixture();
            testCase.applyFixture( fix );
            
            % Access the figure handle
            layout = fix.GridLayout;
            testCase.verifyTrue( isvalid( layout ) )

        end

    end

end 
```
## Fixture Lifecycle

- **Setup**:  
  - Creates a new `uigridlayout` object with the specified properties.
- **Teardown**:  
  - Deletes the created grid layout to ensure no side effects between tests.

## See Also

- [`matlab.unittest.fixtures.Fixture`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.fixtures.fixture-class.html)
- [`uigridlayout`](https://www.mathworks.com/help/matlab/ref/matlab.ui.container.gridlayout.html)
