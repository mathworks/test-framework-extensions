classdef ExpectedTargetWarningScenarioTest < matlab.unittest.TestCase

    methods ( Test )

        function testExpectedTargetWarning(testCase)

            testCase.verifyWarning(@() issueTargetWarning, ...
                "FailOnSpecificWarningsPluginTest:Target");

        end % testExpectedTargetWarning

    end % methods ( Test )

end % classdef

function issueTargetWarning

warning("FailOnSpecificWarningsPluginTest:Target", "Expected target warning.");

end % issueTargetWarning
