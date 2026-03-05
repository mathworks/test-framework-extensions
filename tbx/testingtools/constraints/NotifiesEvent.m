classdef NotifiesEvent < matlab.unittest.internal.constraints...
        .NegatableConstraint & handle
    %NOTIFIESEVENT Constraint to verify that an event has been notified.

    properties ( SetAccess = immutable )
        % Handle to the source of the event.
        EventSource(:, 1) handle {isvalid, mustBeScalarOrEmpty} = ...
            gobjects( 0 )
        % Name of the event.
        EventName(1, 1) string = ""
    end % properties ( SetAccess = immutable )

    properties ( Access = private )
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

        function tf = satisfiedBy( obj, fcnToCall )

            tf = obj.evaluateConstraint( fcnToCall );

        end % satisfiedBy

        function diag = getDiagnosticFor( obj, fcn )

            obj.evaluateConstraint( fcn );
            fcnName = func2str( fcn );

            if obj.TestPassed
                str = "Event " + obj.EventName + " was notified by " + ...
                    fcnName;
            elseif ~obj.TestPassed
                str = "Event " + obj.EventName + " was not notified " + ...
                    "by " + fcnName;
            else
                str = "The test has not been run yet.";
            end % if

            diag = matlab.unittest.diagnostics.StringDiagnostic( str );

        end % getDiagnosticFor

    end % methods

    methods ( Access = protected )

        function diag = getNegativeDiagnosticFor( obj, fcn )

            obj.evaluateConstraint( fcn );
            fcnName = func2str( fcn );

            if ~obj.TestPassed
                str = "Event " + obj.EventName + " was not notified " + ...
                    "by " + fcnName;
            elseif obj.TestPassed
                str = "Event " + obj.EventName + " was notified " + ...
                    "by " + fcnName;
            else
                str = "The test has not been run yet.";
            end % if

            diag = matlab.unittest.diagnostics.StringDiagnostic( str );

        end % getNegativeDiagnosticFor

        function tf = evaluateConstraint( obj, fcnToCall )

            % If the function has already been evaluated with this function
            % handle, don't re-evaluate.
            if ~isempty( obj.EvaluatedFunction ) && ...
                    isequal( obj.EvaluatedFunction, fcnToCall )
                tf = obj.TestPassed;
                return
            end % if

            % Default state is to assume that the constraint is false.
            obj.TestPassed = false;

            % Add a listener to the event source for the desired event.
            listener( obj.EventSource, obj.EventName, @onEventReceived );

            % Run the function.
            fcnToCall();

            % Store the function.
            obj.EvaluatedFunction = fcnToCall;
            tf = obj.TestPassed;

            function onEventReceived( ~, ~ )

                obj.TestPassed = true;

            end % onEventReceived

        end % evaluateConstraint

    end % methods ( Access = protected )

end % classdef