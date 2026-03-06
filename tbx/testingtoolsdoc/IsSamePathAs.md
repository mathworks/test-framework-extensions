# `IsSamePathAs`

A custom MATLAB unit test constraint for asserting that two file or folder paths refer to the **same location**, with platform-appropriate case sensitivity.

## Overview

`IsSamePathAs` is a subclass of [`matlab.unittest.constraints.BooleanConstraint`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.booleanconstraint-class.html) designed to verify that the actual path is equivalent to the expected path. On Windows, comparisons are case-insensitive; on other platforms, they are case-sensitive. Both paths are normalized using `fullfile` to help ensure consistent comparison.

## Properties

| Property       | Access     | Description                                             |
|----------------|------------|---------------------------------------------------------|
| `ExpectedPath` | Read-only  | The reference path to which the actual path is compared.|

## Constructor

### `IsSamePathAs(expected)`

- **Description**: Constructs the constraint to check that a given path is equivalent to the expected path.
- **Inputs**:
  - `expected` (`string`): The expected file or folder path.

```matlab
c = IsSamePathAs("C:\Users\foo\Documents"); % Windows-style path
c = IsSamePathAs("/home/foo/Documents");    % UNIX-style path
```

## Example

```matlab
classdef tIsSamePathAs < matlab.unittest.TestCase

    methods ( Test )

        function tWindowsCaseInsensitive( testCase )

            if ispc
                testCase.verifyThat("C:\Users\FOO", IsSamePathAs("c:\users\foo"))
            end

        end

        function tUnixCaseSensitive( testCase )

            if isunix
                testCase.verifyThat("/tmp/data", IsSamePathAs("/tmp/data"))
                testCase.verifyThat("/tmp/Data", ~IsSamePathAs("/tmp/data"))
            end

        end

        function tFail( testCase )

            testCase.verifyThat("folder1", IsSamePathAs("folder2"))

        end

    end

end
```

## Constraint Behavior

- **Satisfied if**:  
  The actual path and the expected path, after normalization, refer to the same location, using case-insensitive comparison on Windows and case-sensitive comparison on other platforms.
- **Not satisfied if**:  
  The actual and expected paths differ in any way that is significant for the current platform.

## See Also

- [`matlab.unittest.constraints.BooleanConstraint`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.booleanconstraint-class.html)
- [`fullfile`](https://www.mathworks.com/help/matlab/ref/fullfile.html)
- [`strcmp`](https://www.mathworks.com/help/matlab/ref/strcmp.html)
- [`strcmpi`](https://www.mathworks.com/help/matlab/ref/strcmpi.html)
- [`ispc`](https://www.mathworks.com/help/matlab/ref/ispc.html)
- [`isunix`](https://www.mathworks.com/help/matlab/ref/isunix.html)