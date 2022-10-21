classdef TriggersEvent < matlab.unittest.internal.constraints.NegatableConstraint & handle

    properties (SetAccess = immutable)
        EventSource
        EventName (1,1) string = ""
        
    end
    
    properties (Access = private)
        TestPassed (1,:) logical = logical.empty(1,0)
        EvaluatedFunction
    end

    methods
        
        function this = TriggersEvent(src,eventName)
            
            this.EventSource = src;
            this.EventName = eventName;
            
        end
        
        function tf = satisfiedBy(this,fcnToCall)
            
            tf = this.evaluateConstraint(fcnToCall);

        end
        
        function diag = getDiagnosticFor(this,fcn)

            this.evaluateConstraint(fcn);
            fcnName = string(char(this.EvaluatedFunction));
            
            if this.TestPassed
                str = "Event " + this.EventName + " was triggered by " + fcnName;
            elseif ~this.TestPassed
                str = "Event " + this.EventName + " was not triggered by " + fcnName;
            else
                str = "The test has not been run yet";
            end
            
            diag = matlab.unittest.diagnostics.StringDiagnostic(str);
            
        end
        
    end
    
    methods (Access = protected)
        
        function diag = getNegativeDiagnosticFor(this,fcn)
            
            this.evaluateConstraint(fcn);
            fcnName = string(char(this.EvaluatedFunction));
            
            if ~this.TestPassed % Success
                str = "Event " + this.EventName + " was not triggered by " + fcnName;
            elseif this.TestPassed % Fail
                str = "Event " + this.EventName + " was triggered by " + fcnName;
            else
                str = "The test has not been run yet";
            end
            
            diag = matlab.unittest.diagnostics.StringDiagnostic(str);
            
        end

        function tf = evaluateConstraint(this,fcnToCall)
            
            % If function has already been evaluated with this function
            % handle, don't re-evaluate.
            if(~isempty(this.EvaluatedFunction) && ...
                    isequal(this.EvaluatedFunction,fcnToCall))
                tf = this.TestPassed;
                return
            end

            % Default state is to assume fail
            tf = false;
            
            % Add a listener to the event source for the desired event
            listener(this.EventSource,this.EventName,@onEventFired);
           
            % Run the function
            fcnToCall();
            
            % Store the result
            this.TestPassed = tf;
            this.EvaluatedFunction = fcnToCall;
            
            function onEventFired(~,~)
                tf = true;
            end
            
        end
        
    end
    
end