# `PreferenceFixture`

A custom MATLAB unit test fixture for overriding a MATLAB preference or preference group during testing, with automatic restoration or cleanup after the test.

## Overview

`PreferenceFixture` is a subclass of [`matlab.unittest.fixtures.Fixture`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.fixtures.fixture.html) designed to temporarily set a MATLAB preference or preference group for the duration of a unit test. It automatically restores the original value (or removes the preference/group if it did not exist) during teardown, ensuring tests do not affect the user's environment.

## Properties

| Property          | Access      | Description                                                                 |
|-------------------|------------|-----------------------------------------------------------------------------|
| `Group`           | Read-only  | Name of the preference group to override.                                   |
| `Name`            | Read-only  | Name of the specific preference (empty if working with the whole group).    |
| `ValueOriginal`   | Read-only  | Original value of the preference or group before the fixture was applied.   |
| `ValueFixture`    | Read-only  | Value set by the fixture during the test.                                   |

## Constructor

### `PreferenceFixture(group)`
### `PreferenceFixture(group, name)`
### `PreferenceFixture(group, name, value)`

- **Description**: Constructs the fixture for a specific preference group, optionally for a specific preference and value.
- **Inputs**:
  - `group` (string): Name of the preference group to override.
  - `name` (string, optional): Name of the preference within the group.
  - `value` (optional): Value to set for the preference.

```matlab
% Override an entire preference group (no preference name or value)
fixture = PreferenceFixture("MyToolbox");

% Override a specific preference within a group
fixture = PreferenceFixture("MyToolbox", "ShowTips");

% Override a specific preference and set it to a value
fixture = PreferenceFixture("MyToolbox", "ShowTips", false);
```

## Example

```matlab
classdef MyPreferenceTest < matlab.unittest.TestCase

    methods( Test )

        function tPreference( testCase )
            
            % Add the fixture to the test - sets ShowTips to false
            fix = PreferenceFixture("MyToolbox", "ShowTips", false);
            testCase.applyFixture(fix);
            
            % Test code that depends on the preference
            testCase.verifyFalse(getpref("MyToolbox", "ShowTips"))

        end

    end

end
```

## Fixture Lifecycle

- **Setup**:
  - If overriding a group, stores the existing group structure (if present).
  - If overriding a specific preference, stores its value (if present).
  - Sets the specified value (if provided).
- **Teardown**:
  - Restores the original value or group structure.
  - Removes the preference or group if it did not exist prior to the test.

## Compatibility

Two `PreferenceFixture` instances are considered compatible if they reference the same group, preference name, and original value.

## See Also

- [`matlab.unittest.fixtures.Fixture`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.fixtures.fixture-class.html)
- [`getpref`](https://www.mathworks.com/help/matlab/ref/getpref.html)
- [`setpref`](https://www.mathworks.com/help/matlab/ref/setpref.html)
- [`rmpref`](https://www.mathworks.com/help/matlab/ref/rmpref.html)