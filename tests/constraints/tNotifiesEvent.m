classdef tNotifiesEvent < matlab.unittest.TestCase

    methods (Test)

        function tEventNotified(this)

            % Define function to call
            d = DummyEventClass();
            fcn = @() d.notifyTestEvent();

            % Check that the event was fired
            eventName = "TestEvent";
            notifEvt = NotifiesEvent(d,eventName);
            this.verifyThat(fcn,notifEvt)

            % Check running it a second time doesn't cause issues
            this.verifyThat(fcn,notifEvt)

            % Check the diagnostic
            diag = notifEvt.getDiagnosticFor(fcn).DiagnosticText;
            expt = 'Event TestEvent was notified by @()d.notifyTestEvent()';
            this.verifyEqual(diag,expt)

            % Test the same event with a different function
            fcn2 = @() d.notifyTestEventAgain();
            this.verifyThat(fcn2,notifEvt)

        end

        function tEventNotNotified(this)

            % Define function to call
            d = DummyEventClass();
            fcn = @() d.notifyTestEvent();

            % Check that the event was not notified
            eventName = "TestEvent2";
            notNotifEvt = ~NotifiesEvent(d,eventName);
            this.verifyThat(fcn,notNotifEvt)

            % Check the diagnostic
            diag = notNotifEvt.getDiagnosticFor(fcn).DiagnosticText;
            expt = 'Event TestEvent2 was not notified by @()d.notifyTestEvent()';
            this.verifyEqual(diag,expt)

        end

    end

end