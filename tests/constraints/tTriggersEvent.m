classdef tTriggersEvent < matlab.unittest.TestCase
    
    methods (Test)
        
        function tEventTriggered(this)
            
            % Define function to call
            d = constraints.DummyEventClass();
            fcn = @() d.triggerTestEvent();
            
            % Check that the event was fired
            eventName = "TestEvent";
            trigEvt = TriggersEvent(d,eventName);
            this.verifyThat(fcn,trigEvt)
            
            % Check running it a second time doesn't cause issues
            this.verifyThat(fcn,trigEvt)

            % Check the diagnostic
            diag = trigEvt.getDiagnosticFor(fcn).DiagnosticText;
            expt = 'Event TestEvent was triggered by @()d.triggerTestEvent()';
            this.verifyEqual(diag,expt)
            
            % Test the same event with a different function
            fcn2 = @() d.triggerTestEventAgain();
            this.verifyThat(fcn2,trigEvt)
            
        end
        
        function tEventNotTriggered(this)
            
            % Define function to call
            d = constraints.DummyEventClass();
            fcn = @() d.triggerTestEvent();
            
            % Check that the event was fired
            eventName = "TestEvent2";
            notTrigEvt = ~TriggersEvent(d,eventName);
            this.verifyThat(fcn,notTrigEvt)
            
            % Check the diagnostic
            diag = notTrigEvt.getDiagnosticFor(fcn).DiagnosticText;
            expt = 'Event TestEvent2 was not triggered by @()d.triggerTestEvent()';
            this.verifyEqual(diag,expt)
            
        end

    end
    
end