# `SimulinkModelFixture`

A custom MATLAB unit test fixture for managing the lifecycle of a Simulink model during testing.

## Overview

`SimulinkModelFixture` is a subclass of [`matlab.unittest.fixtures.Fixture`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.fixtures.fixture.html) designed to ensure a Simulink model is loaded for the duration of a unit test. If the model is not already loaded, the fixture loads it and automatically closes it after the test completes, ensuring a clean test environment.

## Properties

| Property     | Access      | Description                                       |
|--------------|------------|---------------------------------------------------|
| `ModelName`  | Read-only  | Name of the Simulink model managed by the fixture.|

## Constructor

### `SimulinkModelFixture(modelName)`

- **Description**: Constructs the fixture for a specific Simulink model.
- **Input**:  
  - `modelName` (string): Name of the Simulink model to load.

```matlab
fixture = SimulinkModelFixture("my_model"); 
```

## Example

```matlab
classdef MySimulinkTest < matlab.unittest.TestCase

    methods ( Test )

        function tSimulinkModel( testCase )
            
            % Add the fixture to the test
            fix = SimulinkModelFixture( "my_model" );
            testCase.applyFixture( fix );
            
            % Verify the model is loaded
            testCase.verifyTrue( bdIsLoaded("my_model") )

        end

    end

end 
```

## Fixture Lifecycle

- **Setup**:  
  - Loads the specified Simulink model if it is not already loaded.
- **Teardown**:  
  - Closes the model if it was loaded by the fixture, ensuring no side effects between tests.

## Compatibility

Two `SimulinkModelFixture` instances are considered compatible if they reference the same model name.

## See Also

- [`matlab.unittest.fixtures.Fixture`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.fixtures.fixture-class.html)
- [`load_system`](https://www.mathworks.com/help/simulink/slref/load_system.html)
- [`close_system`](https://www.mathworks.com/help/simulink/slref/close_system.html)
- [`bdIsLoaded`](https://www.mathworks.com/help/simulink/slref/bdisloaded.html)