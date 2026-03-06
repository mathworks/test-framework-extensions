# `IsEquivalentText`

A custom MATLAB unit test constraint for asserting that two text arrays (`string` or `cellstr`) are equivalent, ignoring the vector orientation and data type and considering only the text content.
## Overview

`IsEquivalentText` is a subclass of [`matlab.unittest.constraints.BooleanConstraint`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.booleanconstraint-class.html) designed to verify that the actual text array contains the same text elements as the expected text array, regardless of whether they are row vectors, column vectors, or different shapes. All arrays are compared as column vectors of strings.

## Properties

| Property                | Access     | Description                                                         |
|-------------------------|------------|---------------------------------------------------------------------|
| `ArrayWithExpectedValue`| Read-only  | The expected text array, stored as a string column vector.           |

## Constructor

### `IsEquivalentText(txt)`

- **Description**: Constructs the constraint to check that a given text array is equivalent to the expected text array, ignoring shape and orientation.
- **Inputs**:
  - `txt` (array convertible to string): The expected text array for comparison.

```matlab
c = IsEquivalentText(["foo", "bar"]); % Must match ["foo", "bar"], any orientation
c = IsEquivalentText({'foo', 'bar'}); % Cellstr also supported
c = IsEquivalentText("hello");         % Single string
```

## Example

```matlab
classdef tIsEquivalentText < matlab.unittest.TestCase

    methods ( Test )

        function tEquivalentRegardlessOfShape( testCase )

            testCase.verifyThat(["a", "b"], IsEquivalentText(["a"; "b"]))
            testCase.verifyThat({'x', 'y'}, IsEquivalentText(["x", "y"]))

        end

        function tCharMatrix( testCase )

            testCase.verifyThat(['cat'; 'dog'], IsEquivalentText(["cat"; "dog"]))

        end

        function tFail( testCase )

            testCase.verifyThat(["foo", "bar"], IsEquivalentText(["bar", "foo"]))

        end

    end

end
```

## Constraint Behavior

- **Satisfied if**:  
  The actual value, when converted to a string column vector, matches the expected value (also as a string column vector), element-wise and in order.
- **Not satisfied if**:  
  The actual and expected values differ in any element or in their order, after conversion to string column vectors.

## See Also

- [`matlab.unittest.constraints.BooleanConstraint`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.booleanconstraint-class.html)
- [`IsEqualTo`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.isequalto-class.html)
- [`string`](https://www.mathworks.com/help/matlab/ref/string.html)
- [`convertCharsToStrings`](https://www.mathworks.com/help/matlab/ref/convertcharstostrings.html)