# `NotifiesEvent`

A custom MATLAB unit test constraint to verify that a specified event has been notified by a function or method.

## Overview

`NotifiesEvent` is a subclass of [`matlab.unittest.constraints.Constraint`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.constraint-class.html) that checks whether a function, when called, triggers (notifies) a specific event on a given handle object.

## Properties

| Property           | Access     | Description                                                                                       |
|--------------------|------------|---------------------------------------------------------------------------------------------------|
| `EventSource`      | Read-only  | Handle to the source of the event.                                                                |
| `EventName`        | Read-only  | Name of the event to listen for.                                                                  |
| `Negated`          | Private    | Logical flag for the constraint being negated (used for `not`).                                   |
| `TestPassed`       | Private    | Flag indicating whether the test has passed.                                                      |
| `EvaluatedFunction`| Private    | Function handle that has been evaluated.                                                          |

## Constructor

### `NotifiesEvent(source, eventName)`

- **Description**: Constructs the constraint.
- **Inputs**:
  - `source` (`handle`): The handle object that is the source of the event.
  - `eventName` (`string`): The name of the event to listen for.

**Example:**

```matlab
c = NotifiesEvent(myObj, "MyEvent");
```

## Usage Example

```matlab
classdef MyHandle < handle

    events ( NotifyAccess = private )
        MyEvent
    end

    methods

        function trigger( obj )

            obj.notify( "MyEvent")

        end

    end

end

classdef tNotifiesEvent < matlab.unittest.TestCase

    methods ( Test )

        function tEventNotified( testCase )

            obj = MyHandle();
            testCase.verifyThat(@() obj.trigger(), NotifiesEvent(obj, "MyEvent"))

        end

        function tEventNotNotified( testCase )

            obj = MyHandle();
            testCase.verifyThat(@() disp("no event"), ~NotifiesEvent(obj, "MyEvent"))

        end

    end

end
```
## Constraint Behavior

- **Satisfied if**:  
  The provided function, when called, notifies the specified event on the given event source handle.
- **Negation**:  
  Use `~` (`not`) to assert that the event is **not** notified by the function.

## See Also

- [`matlab.unittest.constraints.Constraint`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.constraint-class.html)
- [`listener`](https://www.mathworks.com/help/matlab/ref/handle.listener.html)
- [`notify`](https://www.mathworks.com/help/matlab/ref/handle.notify.html)