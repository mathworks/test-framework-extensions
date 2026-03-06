# `NotifiesPropertyEvent`

A custom MATLAB unit test constraint to verify that a specific property event (e.g., `PreSet`, `PostSet`, `PreGet`, `PostGet`) has been notified for a property of a handle object.

## Overview

`NotifiesPropertyEvent` is a subclass of [`matlab.unittest.constraints.Constraint`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.constraint-class.html) that checks whether a function, when called, triggers a specific property event on a given property of a handle object.

## Properties

| Property         | Access     | Description                                                                                                    |
|------------------|------------|----------------------------------------------------------------------------------------------------------------|
| `EventSource`    | Read-only  | Handle to the source object for the property event.                                                            |
| `PropertyName`   | Read-only  | Name of the property being monitored for the event.                                                            |
| `EventName`      | Read-only  | Name of the property event (`"PreGet"`, `"PostGet"`, `"PreSet"`, or `"PostSet"`). Default is `"PostSet"`.      |
| `Negated`        | Private    | Logical flag indicating whether the constraint is negated (used for `.not`).                                   |
| `TestPassed`     | Private    | Logical flag indicating whether the test has passed (the event was notified).                                  |
| `EvaluatedFunction` | Private | Function handle that has been evaluated.                                                                       |

## Constructor

### `NotifiesPropertyEvent(eventSource, propertyName, eventName)`

- **Description**: Constructs the constraint.
- **Inputs**:
  - `eventSource` (`handle`): The handle object that is the source of the property event.
  - `propertyName` (`string`): The name of the property to monitor.
  - `eventName` (`string`): The name of the property event (`"PreGet"`, `"PostGet"`, `"PreSet"`, `"PostSet"`). Default is `"PostSet"`.

**Example:**

```matlab
c = NotifiesPropertyEvent(myObj, "MyProp", "PostSet");
```

## Usage Example

```matlab
classdef MyHandle < handle

    properties ( SetObservable )
        MyProp
    end

end

classdef tNotifiesPropertyEvent < matlab.unittest.TestCase

    methods ( Test )

        function tPropertyEventNotified( testCase )

            obj = MyHandle();
            testCase.verifyThat(@setMyProp, ...
                NotifiesPropertyEvent(obj, "MyProp", "PostSet"))

            function setMyProp()
                obj.MyProp = 42;
            end

        end

        function tPropertyEventNotNotified( testCase )

            obj = MyHandle();
            testCase.verifyThat(@() disp("No property event"), ...
                ~NotifiesPropertyEvent(obj, "MyProp", "PostSet"))

        end

    end

end
```

## Constraint Behavior

- **Satisfied if**:  
  The provided function, when called, notifies the specified property event (e.g., `"PostSet"`) for the given property on the event source object.
- **Negation**:  
  Use `~` (`not`) to assert that the property event is **not** notified by the function.

## See Also

- [`matlab.unittest.constraints.Constraint`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.constraint-class.html)
- [`listener`](https://www.mathworks.com/help/matlab/ref/handle.listener.html)
- [Events](https://www.mathworks.com/help/matlab/events-sending-and-responding-to-messages.html)
