# `IsEqualVector`

A custom MATLAB unit test constraint for asserting that a vector is equal to an expected vector, **up to orientation** and using optional absolute and/or relative tolerances.

## Overview

`IsEqualVector` is a subclass of [`matlab.unittest.constraints.BooleanConstraint`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.booleanconstraint-class.html) designed to verify that the actual vector contains the same values as the expected vector (regardless of being a row or column), within specified absolute and/or relative tolerances.

## Properties

| Property                | Access     | Description                                                                                           |
|-------------------------|------------|-------------------------------------------------------------------------------------------------------|
| `VectorWithExpectedValue` | Read-only  | The expected vector to compare against.                                                                |
| `AbsoluteTolerance`       | Read-only  | [`AbsoluteTolerance`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.absolutetolerance-class.html) used for comparison (default: 0). |
| `RelativeTolerance`       | Read-only  | [`RelativeTolerance`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.relativetolerance-class.html) used for comparison (default: 0). |

## Constructor

### `IsEqualVector(vector)`
### `IsEqualVector(vector, opts)`

- **Description**: Constructs the constraint to check that a given vector is equal to the expected vector (up to orientation), with optional tolerances.
- **Inputs**:
  - `vector` (vector): The expected vector for comparison.
  - `opts.AbsTol` ([`AbsoluteTolerance`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.absolutetolerance-class.html), optional): Absolute tolerance (default: 0).
  - `opts.RelTol` ([`RelativeTolerance`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.relativetolerance-class.html), optional): Relative tolerance (default: 0).

```matlab
c = IsEqualVector([1 2 3]); % Must match [1 2 3] exactly, any orientation
c = IsEqualVector([1 2 3], "AbsTol", 1e-5);
c = IsEqualVector([1 2 3], "RelTol", 1e-3);
c = IsEqualVector([1 2 3], "AbsTol", 1e-5, "RelTol", 1e-3);
```

## Example

```matlab
classdef tIsEqualVector < matlab.unittest.TestCase

    methods ( Test )

        function tEqualRegardlessOfOrientation( testCase )

            testCase.verifyThat([1 2 3], IsEqualVector([1; 2; 3]))
            testCase.verifyThat([1; 2; 3], IsEqualVector([1 2 3]))

        end

        function tWithTolerance( testCase )

            testCase.verifyThat([1.0001 2.0001 3.0001], ...
                IsEqualVector([1 2 3], "AbsTol", 1e-3)

        end

        function tFail( testCase )

            testCase.verifyThat([1 2 4], IsEqualVector([1 2 3]))

        end

    end

end
```

## Constraint Behavior

- **Satisfied if**:  
  The actual value is a vector, and all its elements match the expected vector (regardless of row or column orientation), within the specified absolute and/or relative tolerances.
- **Not satisfied if**:  
  The actual value is not a vector, or any element differs from the expected value by more than the allowed tolerance.

## See Also

- [`matlab.unittest.constraints.BooleanConstraint`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.booleanconstraint-class.html)
- [`IsEqualTo`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.isequalto-class.html)
- [`AbsoluteTolerance`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.absolutetolerance-class.html)
- [`RelativeTolerance`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.relativetolerance-class.html)