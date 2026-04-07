# `DatetimeTolerance`

A custom MATLAB unit test tolerance constraint for comparing `datetime` or `duration` arrays within a specified tolerance, with optional handling of `NaT` values.

## Overview

`DatetimeTolerance` is a subclass of [`matlab.unittest.constraints.Tolerance`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.tolerance-class.html) designed to assert that two `datetime` or `duration` arrays differ by no more than a specified `duration` tolerance. Optionally, it can ignore pairs of `NaT` values during comparison.

## Properties

| Property      | Access      | Description                                                                           |
|---------------|------------|---------------------------------------------------------------------------------------|
| `Tolerance`   | Read-only  | The maximum allowed difference (of type `duration`) between actual and expected values.|
| `IgnoreNaT`   | Read-only  | If true, matching pairs of `NaT` are ignored in the comparison.                       |

## Constructor

### `DatetimeTolerance(value)`
### `DatetimeTolerance(value, "IgnoringNaT", true|false)`

- **Description**: Constructs the tolerance constraint for `datetime` or `duration` comparisons.
- **Inputs**:
  - `value` (`duration`, optional): The tolerance to use (default: `seconds(eps)`).
  - `"IgnoringNaT"` (`logical`, optional): Whether to ignore pairs of `NaT` values (default: `false`).

```matlab
tol = DatetimeTolerance(seconds(1)); % 1-second tolerance
tol = DatetimeTolerance(minutes(5), "IgnoringNaT", true); % 5-minute tolerance, ignore NaT pairs 
```

## Example

```matlab
classdef MyDatetimeTest < matlab.unittest.TestCase

    methods( Test )

        function tDatetimeWithinTolerance( testCase )

            actual = datetime(2024,1,1,12,0,1); % 1 second later
            expected = datetime(2024,1,1,12,0,0);
            testCase.verifyThat(actual, IsEqualTo(expected, "Within", DatetimeTolerance(seconds(2))))

        end

        function tIgnoreNaT( testCase )

            actual = [datetime(2024,1,1), NaT];
            expected = [datetime(2024,1,1), NaT];
            testCase.verifyThat(actual, IsEqualTo(expected, "Within", DatetimeTolerance(seconds(0), "IgnoringNaT", true)))

        end

    end

end 
```

## Constraint Behavior

- **Satisfied if**:  
  For all elements, `abs(actual - expected) <= Tolerance`.  
  If `IgnoreNaT` is `true`, any position where both `actual` and `expected` are `NaT` is always considered within tolerance.
- **Not satisfied if**:  
  Any element differs by more than the specified tolerance, or if `NaT` handling is not ignored and there is a mismatch.

## See Also

- [`matlab.unittest.constraints.Tolerance`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.tolerance-class.html)
- [`IsEqualTo`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.isequalto.html)
- [`datetime`](https://www.mathworks.com/help/matlab/ref/datetime.html)
- [`duration`](https://www.mathworks.com/help/matlab/ref/duration.html)
- [`isnat`](https://www.mathworks.com/help/matlab/ref/isnat.html)