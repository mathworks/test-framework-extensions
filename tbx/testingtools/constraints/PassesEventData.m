classdef PassesEventData < matlab.unittest.internal.constraints...
        .NegatableConstraint & handle
    %PASSESEVENTDATA Verify that an event passes custom event data.

    properties ( SetAccess = immutable )
        % Handle to the source of the event.
        EventSource(:, 1) handle {isvalid, mustBeScalarOrEmpty} = ...
            gobjects( 0 )
        % Name of the event.
        EventName(1, 1) string = ""
        % Custom event data.
        EventData(:, 1) event.EventData ...
            {isvalid, mustBeScalarOrEmpty} = event.EventData.empty( 0, 1 )
    end % properties ( SetAccess = immutable )

    properties ( Access = private )
        % Flag indicating whether the test has passed.
        TestPassed(1, :) logical = logical.empty( 1, 0 )
        % Function that has been evaluated.
        EvaluatedFunction(1, :) function_handle {mustBeScalarOrEmpty} = ...
            function_handle.empty( 1, 0 )
    end % properties ( Access = private )

    methods

        function obj = PassesEventData( source, eventName, eventData )
            %PASSESEVENTDATA Constructor, accepting the event source, event
            %name, and event data.

            arguments ( Input )
                source(1, 1) handle {isvalid}
                eventName(1, 1) string
                eventData(1, 1) event.EventData
            end % arguments ( Input )

            obj.EventSource = source;
            obj.EventName = eventName;
            obj.EventData = eventData;

        end % constructor

        function tf = satisfiedBy( obj, fcnToCall )

            tf = obj.evaluateConstraint( fcnToCall );

        end % satisfiedBy

        function diag = getDiagnosticFor( obj, fcn )

            diag = obj.getGenericDiagnosticFor( fcn, false );

        end % getDiagnosticFor

    end % methods

    methods ( Access = protected )

        function diag = getNegativeDiagnosticFor( obj, fcn )

            diag = obj.getGenericDiagnosticFor( fcn, true );

        end % getNegativeDiagnosticFor

        function diag = getGenericDiagnosticFor( obj, fcn, isNegated )

            obj.evaluateConstraint( fcn );

            if isNegated
                posStr = " not ";
                negStr = " ";
            else
                posStr = " ";
                negStr = " not ";
            end % if

            fcnName = func2str( fcn );

            if obj.TestPassed
                str = "The event data of type " + ...
                    class( obj.EventData ) + ...
                    " for the event " + obj.EventName + " was" + ...
                    posStr + "passed when the function " + fcnName + ...
                    " was called.";
            elseif ~obj.TestPassed
                str = "The event data of type " + ...
                    class( obj.EventData ) + ...
                    " for the event " + obj.EventName + " was" + ...
                    negStr + "passed when the function " + fcnName + ...
                    " was called.";
            else
                str = "The test has not been run yet.";
            end % if

            diag = matlab.unittest.diagnostics.StringDiagnostic( str );

        end % getGenericDiagnosticFor

        function tf = evaluateConstraint( obj, fcnToCall )

            % If the function has already been evaluated with this function
            % handle, don't re-evaluate.
            if ~isempty( obj.EvaluatedFunction ) && ...
                    isequal( obj.EvaluatedFunction, fcnToCall )
                tf = obj.TestPassed;
                return
            end % if

            % Default state is to assume that the constraint is false.
            tf = false;

            % Add a listener to the event source for the desired event.
            listener( obj.EventSource, obj.EventName, @onEventReceived );

            % Run the function.
            fcnToCall();

            % Store the result.
            obj.TestPassed = tf;
            obj.EvaluatedFunction = fcnToCall;

            function onEventReceived( ~, e )

                tf = isa( e, class( obj.EventData ) );
                props = setdiff( properties( e ), ...
                    ["Source", "EventName"] );
                for propIdx = 1 : numel( props )
                    prop = props{propIdx};
                    hasProp = ~isempty( findprop( e, prop ) );
                    tf = tf & hasProp & ...
                        isequal( e.(prop), obj.EventData.(prop) );
                end % for

            end % onEventReceived

        end % evaluateConstraint

    end % methods ( Access = protected )

end % classdef