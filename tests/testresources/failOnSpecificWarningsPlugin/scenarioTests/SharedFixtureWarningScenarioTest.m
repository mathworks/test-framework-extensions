classdef (SharedTestFixtures={TargetWarningSharedFixture}) ...
        SharedFixtureWarningScenarioTest < matlab.unittest.TestCase

    methods ( Test )

        function testBody(testCase)

            testCase.verifyTrue(true);

        end % testBody

    end % methods ( Test )

end % classdef
