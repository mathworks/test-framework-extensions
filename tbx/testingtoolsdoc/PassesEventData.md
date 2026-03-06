# `PassesEventData`

A custom MATLAB unit test constraint to verify that a specific event passes custom event data when notified.

## Overview

`PassesEventData` is a subclass of [`matlab.unittest.constraints.Constraint`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.constraint-class.html) that checks whether a function, when called, triggers a specific event on a given handle object and passes event data of the expected type and property values.

## Properties

| Property         | Access     | Description                                                                                                    |
|------------------|------------|----------------------------------------------------------------------------------------------------------------|
| `EventSource`    | Read-only  | Handle to the source object for the event.                                                                     |
| `EventName`      | Read-only  | Name of the event being monitored.                                                                             |
| `EventData`      | Read-only  | Custom event data object of type derived from `event.EventData`, expected to be passed with the event.         |
| `Negated`        | Private    | Logical flag indicating whether the constraint is negated (used for `.not`).                                   |
| `TestPassed`     | Private    | Logical flag indicating whether the test has passed (the event data matched).                                  |
| `EvaluatedFunction` | Private | Function handle that has been evaluated.                                                                       |

## Constructor

### `PassesEventData(source, eventName, eventData)`

- **Description**: Constructs the constraint.
- **Inputs**:
  - `source` (`handle`): The handle object that is the source of the event.
  - `eventName` (`string`): The name of the event to listen for.
  - `eventData` (`event.EventData`): The expected custom event data object.

**Example:**

```matlab
evtData = MyCustomEventData("SomeValue");
c = PassesEventData(myObj, "MyEvent", evtData);
```

## Usage Example

Suppose you have a class that notifies an event with custom event data:

```matlab
classdef MyEventData < event.EventData

    properties
        Value
    end

    methods

        function obj = MyEventData(val)
            obj.Value = val;
        end

    end

end

classdef MyHandle < handle

    events ( NotifyAccess = private )
        MyEvent
    end

    methods

        function trigger( obj, val )
            obj.notify( "MyEvent", MyEventData(val) )
        end

    end

end

classdef tPassesEventData < matlab.unittest.TestCase

    methods ( Test )

        function tCustomEventData( testCase )

            obj = MyHandle();
            evtData = MyEventData(42);
            testCase.verifyThat(@() obj.trigger(42), ...
                PassesEventData(obj, "MyEvent", evtData))

        end

        function tEventDataNotPassed( testCase )

            obj = MyHandle();
            evtData = MyEventData(99);
            testCase.verifyThat(@() obj.trigger(42), ...
                ~PassesEventData(obj, "MyEvent", evtData))

        end

    end

end
```

## Constraint Behavior

- **Satisfied if**:  
  The provided function, when called, notifies the specified event on the event source and passes event data of the same class and with all property values equal to those in `EventData`.
- **Negation**:  
  Use `~` (`not`) to assert that the event data does **not** match the expected data.

## See Also

- [`matlab.unittest.constraints.Constraint`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.constraints.constraint-class.html)
- [`listener`](https://www.mathworks.com/help/matlab/ref/handle.listener.html)
- [`event.EventData`](https://www.mathworks.com/help/matlab/ref/event.eventdata-class.html)
- [`notify`](https://www.mathworks.com/help/matlab/ref/handle.notify.html)
