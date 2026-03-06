# `SuppressParpoolAutocreateFixture`

A custom MATLAB unit test fixture for suppressing automatic parallel pool (`parpool`) creation during testing.

## Overview

`SuppressParpoolAutocreateFixture` is a subclass of [`matlab.unittest.fixtures.Fixture`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.fixtures.fixture.html) designed to temporarily disable the automatic creation of a parallel pool (`parpool`) for the duration of a unit test. It stores the original `AutoCreate` setting and restores it after the test, ensuring the test does not affect the user's parallel environment.

## Properties

| Property    | Access      | Description                                               |
|-------------|------------|-----------------------------------------------------------|
| `AutoCreate`| Read-only  | Original value of `parallel.Settings().Pool.AutoCreate`.  |

## Constructor

### `SuppressParpoolAutocreateFixture()`

- **Description**: Constructs the fixture and prepares to suppress automatic parallel pool creation.

```matlab
fixture = SuppressParpoolAutocreateFixture();
```

## Example

```matlab
classdef MyParallelTest < matlab.unittest.TestCase

    methods( Test )

        function tNoAutoParpool( testCase )
            
            % Add the fixture to the test
            fix = SuppressParpoolAutocreateFixture();
            testCase.applyFixture( fix );
            
            % Verify automatic pool creation is disabled
            ps = parallel.Settings();
            testCase.verifyFalse( ps.Pool.AutoCreate )

        end

    end

end
```

## Fixture Lifecycle

- **Setup**:  
  - Deletes any existing parallel pool.
  - Stores the current value of `parallel.Settings().Pool.AutoCreate`.
  - Sets `AutoCreate` to `false` to suppress automatic pool creation.
- **Teardown**:  
  - Restores the original `AutoCreate` value.

## See Also

- [`matlab.unittest.fixtures.Fixture`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.fixtures.fixture-class.html)
- [Specify Your Parallel Settings](https://www.mathworks.com/help/parallel-computing/parallel-preferences.html)
- [`parpool`](https://www.mathworks.com/help/parallel-computing/parpool.html)
- [`gcp`](https://www.mathworks.com/help/parallel-computing/gcp.html)