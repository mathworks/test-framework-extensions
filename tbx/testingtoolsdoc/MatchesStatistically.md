# `MatchesStatistically`

A custom MATLAB unit test constraint for asserting that **at least a given percentage** of elements in an array match an expected array, within absolute and/or relative tolerances.

## Overview

`MatchesStatistically` is a subclass of [`matlab.unittest.constraints.Constraint`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.constraint-class.html) that verifies whether a specified percentage (default 100%) of elements in an actual array match the corresponding elements of an expected array, up to an absolute and/or relative tolerance.

## Properties

| Property   | Access     | Description                                                                              |
|------------|------------|------------------------------------------------------------------------------------------|
| `Expected` | Read-only  | The expected array (row vector of doubles).                                              |
| `AbsTol`   | Read-only  | Absolute tolerance object ([`AbsoluteTolerance`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.absolutetolerance-class.html)); default is 0. |
| `RelTol`   | Read-only  | Relative tolerance object ([`RelativeTolerance`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.relativetolerance-class.html)); default is 0. |
| `Percentage` | Read-only | The minimum percentage (0–100) of elements that must match; default is 100.              |

## Constructor

### `MatchesStatistically(expected, NameValueArgs)`

- **Description**: Constructs the constraint.
- **Inputs**:
  - `expected` (`(1,:) double`): The expected array.
  - Name-value pairs:
    - `AbsTol`: `AbsoluteTolerance` (default: 0)
    - `RelTol`: `RelativeTolerance` (default: 0)
    - `Percentage`: double in `[0, 100]` (default: 100)

**Examples:**

```matlab
MatchesStatistically([1 2 3])
MatchesStatistically([1 2 3], "AbsTol", 1e-3)
MatchesStatistically([1 2 3], "RelTol", 1e-2, "Percentage", 90)
```

## Example Usage

```matlab
classdef tMatchesStatistically < matlab.unittest.TestCase

    methods ( Test )

        function tAllMatch( testCase )

            testCase.verifyThat([1.01 2.00 2.99], ...
                MatchesStatistically([1 2 3], 'AbsTol', 0.02))

        end

        function tPartialMatch( testCase )

            testCase.verifyThat([1 2 100], ...
                MatchesStatistically([1 2 3], "AbsTol", 0.1, "Percentage", 66.7))

        end

        function tFailMatch( testCase )

            testCase.verifyThat([1 99 100], ...
                MatchesStatistically([1 2 3], "AbsTol", 0.1, "Percentage", 67))

        end

    end

end
```

## Constraint Behavior

- **Satisfied if**:  
  At least the specified `Percentage` of elements in `actual` match the corresponding elements in `Expected`, within either the absolute or relative tolerance.
- **Not satisfied if**:  
  Fewer than the specified percentage of elements match.

- **Length Mismatch**:  
  If `actual` and `Expected` are not the same length, the constraint fails with a diagnostic from `HasLength`.

## See Also

- [`AbsoluteTolerance`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.absolutetolerance-class.html)
- [`RelativeTolerance`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.relativetolerance-class.html)
- [`matlab.unittest.constraints.Constraint`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.constraint-class.html)
- [`HasLength`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.haslength-class.html)
- [`IsGreaterThanOrEqualTo`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.isgreaterthanorequalto-class.html)