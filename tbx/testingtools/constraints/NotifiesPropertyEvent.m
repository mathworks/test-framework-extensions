classdef NotifiesPropertyEvent < ...
        matlab.unittest.constraints.Constraint & handle
    %NOTIFIESPROPERTYEVENT Constraint to verify that a property event has 
    %been notified.

    % Copyright 2026 The MathWorks, Inc.

    properties ( SetAccess = immutable )
        % Event source object.
        EventSource(:, 1) handle {isvalid, mustBeScalarOrEmpty} = ...
            gobjects( 0 )
        % Property name.
        PropertyName(1, 1) string = ""
        % Property event name.
        EventName(1, 1) string {mustBeMember( EventName, ...
            ["PreGet", "PostGet", "PreSet", "PostSet"] )} = "PostSet"
    end % properties ( SetAccess = immutable )

    properties ( Access = private )
        % Logical flag for the constraint being negated.
        Negated(1, 1) logical = false()
        % Logical flag for the test passing or failing.
        TestPassed(1, :) logical ...
            {mustBeScalarOrEmpty} = logical.empty( 1, 0 )
        % Function to evaluate.
        EvaluatedFunction(1, :) function_handle {mustBeScalarOrEmpty}
    end % properties ( Access = private )

    methods

        function constraint = NotifiesPropertyEvent( eventSource, ...
                propertyName, eventName )
            %NOTIFIESPROPERTYEVENT Constructor, accepting the event source,
            %property name, and event name.

            arguments ( Input )
                eventSource(1, 1) handle {isvalid}
                propertyName(1, 1) string
                eventName(1, 1) string ...
                    {mustBeMember( eventName, ["PreGet", "PostGet", ...
                    "PreSet", "PostSet"] )} = "PostSet"
            end % arguments

            constraint.EventSource = eventSource;
            constraint.PropertyName = propertyName;
            constraint.EventName = eventName;

        end % constructor

        function tf = satisfiedBy( constraint, fcnToCall )

            if ~constraint.Negated
                tf = constraint.evaluateConstraint( fcnToCall );
            else
                tf = ~constraint.evaluateConstraint( fcnToCall );
            end % if

        end % satisfiedBy

        function diag = getDiagnosticFor( constraint, fcn )

            if ~constraint.Negated

                constraint.evaluateConstraint( fcn );
                fcnName = func2str( constraint.EvaluatedFunction );

                if constraint.TestPassed
                    str = "Event " + constraint.EventName + ...
                        " for property " + constraint.PropertyName + ...
                        " was notified by " + fcnName + ".";
                elseif ~constraint.TestPassed
                    str = "Event " + constraint.EventName + ...
                        " for property " + constraint.PropertyName + ...
                        " was not notified by " + fcnName + ".";
                else
                    str = "The test has not been run yet";
                end % if

                diag = matlab.unittest.diagnostics.StringDiagnostic( str );

            else

                diag = getNegativeDiagnosticFor( constraint, fcn );

            end % if

        end % getDiagnosticFor

        function constraint = not( constraint )

            constraint.Negated = ~constraint.Negated;

        end % not (~)

    end % methods

    methods ( Access = protected )

        function diag = getNegativeDiagnosticFor( constraint, fcn )

            if constraint.Negated

                constraint.evaluateConstraint( fcn );
                fcnName = string( char( constraint.EvaluatedFunction ) );

                if ~constraint.TestPassed
                    str = "Event " + constraint.EventName + ...
                        " for property " + constraint.PropertyName + ...
                        " was not notified by " + fcnName + ".";
                elseif constraint.TestPassed
                    str = "Event " + constraint.EventName + ...
                        " for property " + constraint.PropertyName + ...
                        " was notified by " + fcnName + ".";
                else
                    str = "The test has not been run yet.";
                end % if

                diag = matlab.unittest.diagnostics.StringDiagnostic( str );

            else

                diag = getDiagnosticFor( constraint, fcn );

            end % if

        end % getNegativeDiagnosticFor

    end % methods ( Access = protected )

    methods ( Access = private )

        function tf = evaluateConstraint( constraint, fcnToCall )

            % If the function has already been evaluated with this function
            % handle, don't re-evaluate.
            if ~isempty( constraint.EvaluatedFunction ) && ...
                    isequal( constraint.EvaluatedFunction, fcnToCall )
                tf = constraint.TestPassed;
                return
            end % if

            % Default state is to assume that the constraint is false.
            tf = false;

            % Add a listener to the event source for the desired property
            % event.
            listener( constraint.EventSource, constraint.PropertyName, ...
                constraint.EventName, @onEventReceived );

            % Run the function.
            fcnToCall();

            % Store the result.
            constraint.TestPassed = tf;
            constraint.EvaluatedFunction = fcnToCall;

            function onEventReceived( ~, ~ )

                tf = true;

            end % onEventReceived

        end % evaluateConstraint

    end % methods ( Access = private )

end % classdef