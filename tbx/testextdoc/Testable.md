# `Testable`

Convenience alias for
[`matlab.uitest.TestCase`](https://www.mathworks.com/help/matlab/ref/matlab.uitest.testcase-class.html).

## Overview

`Testable` is a thin subclass of `matlab.uitest.TestCase`. It does not
add behavior, properties, or methods. Its purpose is to make UI test
classes shorter and easier to read.

Use `Testable` when you want the full UI testing API provided by
`matlab.uitest.TestCase`, including methods such as `press`,
`choose`, `type`, and `drag`.

## Example

```text
classdef tMyButton < Testable

    methods ( Test )

        function tPressButton( testCase )
            clicked = false;
            fig = uifigure();
            testCase.addTeardown( @() delete( fig ) )

            btn = uibutton( fig, ...
                "Text", "Run", ...
                "ButtonPushedFcn", @(~,~) onPress() );

            testCase.press( btn )

            testCase.verifyTrue( clicked )

            function onPress()
                clicked = true;
            end

        end

    end

end
```

## Notes

- `Testable` is functionally equivalent to subclassing
  `matlab.uitest.TestCase` directly.
- Use `matlab.unittest.TestCase` instead when the test does not require
  UI interaction helpers.

## Testing UI Properties

When a UI class needs to expose handles for UI tests, keep those
properties read-only to production code and grant read access to
`Testable` subclasses.

```text
classdef MyView < matlab.ui.componentcontainer.ComponentContainer

    properties ( GetAccess = ?Testable, SetAccess = private )
        Button(:, 1) matlab.ui.control.Button {mustBeScalarOrEmpty}
        Grid(:, 1) matlab.ui.container.GridLayout {mustBeScalarOrEmpty}
    end

    methods ( Access = protected )

        function setup( obj )
            obj.Grid = uigridlayout( obj, [1 1] );
            obj.Button = uibutton( obj.Grid, "Text", "Run" );
        end

    end

end
```

This pattern lets UI tests inspect or interact with internal handles
while avoiding a wider public API. It also keeps mutation inside the
component implementation by pairing `GetAccess = ?Testable` with
`SetAccess = private`.

## See Also

- [`matlab.uitest.TestCase`](https://www.mathworks.com/help/matlab/ref/matlab.uitest.testcase-class.html)
- [`matlab.unittest.TestCase`](https://www.mathworks.com/help/matlab/ref/matlab.unittest.testcase-class.html)
