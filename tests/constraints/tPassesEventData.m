classdef tPassesEventData < matlab.unittest.TestCase

    properties ( Access = private )
        EventSource
        EventName = "TestEvent"
        EventData
    end

    methods ( TestMethodSetup )

        function createEventSource(testCase)

            testCase.EventSource = DummyEventSource();
            testCase.EventData = CustomEventData( 42 );

        end

    end

    methods ( Test )

        function tEventPassesCustomData( testCase )

            constraint = PassesEventData( testCase.EventSource, ...
                testCase.EventName, testCase.EventData );

            fcn = @() testCase.EventSource.triggerEvent( ...
                testCase.EventName, testCase.EventData );

            testCase.verifyThat(fcn, constraint)

        end

        function tEventFailsWithWrongData( testCase )

            constraint = PassesEventData( testCase.EventSource, ...
                testCase.EventName, testCase.EventData );

            wrongData = CustomEventData( 99 );
            fcn = @() testCase.EventSource.triggerEvent( ...
                testCase.EventName, wrongData );

            testCase.verifyThat( fcn, ~constraint )

        end

        function tEventFailsWithNoEvent( testCase )

            constraint = PassesEventData( testCase.EventSource, ...
                testCase.EventName, testCase.EventData );

            fcn = @() disp( "No event triggered" );

            testCase.verifyThat( fcn, ~constraint )

        end

    end

end