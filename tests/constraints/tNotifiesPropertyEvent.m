classdef tNotifiesPropertyEvent < matlab.unittest.TestCase

    methods (Test)

        function tEventNotified(this)

            % Define function to call
            d = DummyEventClass();
            fcn = @setP;

            function setP
                d.P = 1;
            end

            % Check that the event was notified            
            notifEvt = NotifiesPropertyEvent(d, "P", "PostSet");
            this.verifyThat(fcn,notifEvt)

            % Check running it a second time doesn't cause issues
            this.verifyThat(fcn,notifEvt)

            % Check the diagnostic
            diag = notifEvt.getDiagnosticFor(fcn).DiagnosticText;
            expt = 'Event PostSet for property P was notified by tNotifiesPropertyEvent.tEventNotified/setP.';
            this.verifyEqual(diag,expt)

            % Test the same event with a different function
            fcn2 = @setP2;
            
            function setP2
                d.P = 2;
            end

            this.verifyThat(fcn2,notifEvt)

        end

        function tEventNotNotified(this)

            % Define function to call
            d = DummyEventClass();
            fcn = @setQ;

            function setQ
                d.Q = 1;
            end

            % Check that the event was not notified            
            notNotifEvt = ~NotifiesPropertyEvent(d, "P", "PostSet");
            this.verifyThat(fcn,notNotifEvt)

            % Check the diagnostic
            diag = notNotifEvt.getDiagnosticFor(fcn).DiagnosticText;
            expt = 'Event PostSet for property P was not notified by tNotifiesPropertyEvent.tEventNotNotified/setQ.';
            this.verifyEqual(diag,expt)

        end

    end

end