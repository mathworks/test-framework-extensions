classdef NotifiesEvent < matlab.unittest.constraints.Constraint & handle
    %NOTIFIESEVENT Constraint to verify that an event has been notified.

    properties ( SetAccess = immutable )
        % Handle to the source of the event.
        EventSource(:, 1) handle {isvalid, mustBeScalarOrEmpty} = ...
            gobjects( 0 )
        % Name of the event.
        EventName(1, 1) string = ""
    end % properties ( SetAccess = immutable )

    properties ( Access = private )
        % Logical flag for the constraint being negated.
        Negated(1, 1) logical = false()
        % Flag indicating whether the test has passed.
        TestPassed(1, :) logical = logical.empty( 1, 0 )
        % Function that has been evaluated.
        EvaluatedFunction(1, :) function_handle {mustBeScalarOrEmpty} = ...
            function_handle.empty( 1, 0 )
    end % properties ( Access = private )

    methods

        function obj = NotifiesEvent( source, eventName )
            %NOTIFIESEVENT Constructor, accepting the event source and
            %event name.

            arguments ( Input )
                source(1, 1) handle {isvalid}
                eventName(1, 1) string
            end % arguments ( Input )

            obj.EventSource = source;
            obj.EventName = eventName;

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
                fcnName = func2str( constraint.EvaluatedFunction );

                if ~constraint.TestPassed
                    str = "Event " + constraint.EventName + ...
                        " was not notified by " + fcnName + ".";
                elseif constraint.TestPassed
                    str = "Event " + constraint.EventName + ...
                        " was notified by " + fcnName + ".";
                else
                    str = "The test has not been run yet.";
                end % if

                diag = matlab.unittest.diagnostics.StringDiagnostic( str );

            else

                diag = getDiagnosticFor( constraint, fcn );

            end % if

        end % getNegativeDiagnosticFor

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

            % Add a listener to the event source for the desired event.
            listener( constraint.EventSource, constraint.EventName, ...
                @onEventReceived );

            % Run the function.
            fcnToCall();

            % Store the function.
            constraint.EvaluatedFunction = fcnToCall;
            constraint.TestPassed = tf;

            function onEventReceived( ~, ~ )

                tf = true;

            end % onEventReceived

        end % evaluateConstraint

    end % methods ( Access = protected )

end % classdef