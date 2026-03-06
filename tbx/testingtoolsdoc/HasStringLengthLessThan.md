# `HasStringLengthLessThan`

A custom MATLAB unit test constraint for asserting that all strings in an array have lengths less than a specified maximum.

## Overview

`HasStringLengthLessThan` is a subclass of [`matlab.unittest.constraints.BooleanConstraint`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.booleanconstraint-class.html) designed to verify that every element of a string array has a length strictly less than a given maximum value.

## Properties

| Property              | Access     | Description                                                                 |
|-----------------------|------------|-----------------------------------------------------------------------------|
| `MaximumStringLength` | Read-only  | The exclusive upper bound for allowed string lengths (default: `namelengthmax()`). |

## Constructor

### `HasStringLengthLessThan(maxVal)`

- **Description**: Constructs the constraint to check that all strings are shorter than `maxVal` characters.
- **Inputs**:
  - `maxVal` (`double`, optional): The maximum allowed string length (default: `namelengthmax()`).

```matlab
c = HasStringLengthLessThan(10); % All strings must have length < 10
c = HasStringLengthLessThan();   % Uses MATLAB's default name length limit
```

## Example

```matlab
classdef tStringLength < matlab.unittest.TestCase

    methods ( Test )

        function tShortStrings( testCase )

            strs = ["abc", "hello"];
            testCase.verifyThat(strs, HasStringLengthLessThan(10))

        end

        function tLongStringsFail( testCase )

            strs = ["short", "thisIsWayTooLong"];
            testCase.verifyThat(strs, HasStringLengthLessThan(8))

        end

    end

end
```

## Constraint Behavior

- **Satisfied if**:  
  All elements of the input string array have length strictly less than `MaximumStringLength`.
- **Not satisfied if**:  
  Any element of the input string array has length greater than or equal to `MaximumStringLength`.

## See Also

- [`matlab.unittest.constraints.BooleanConstraint`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.booleanconstraint-class.html)
- [`strlength`](https://www.mathworks.com/help/matlab/ref/strlength.html)
- [`namelengthmax`](https://www.mathworks.com/help/matlab/ref/namelengthmax.html)