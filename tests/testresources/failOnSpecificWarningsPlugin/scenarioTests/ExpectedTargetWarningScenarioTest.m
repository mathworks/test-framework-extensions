classdef ExpectedTargetWarningScenarioTest < matlab.unittest.TestCase
    methods (Test)
        function testExpectedTargetWarning(testCase)
            testCase.verifyWarning(@() issueTargetWarning, ...
                "FailOnSpecificWarningsPluginTest:Target");
        end
    end
end

function issueTargetWarning
warning("FailOnSpecificWarningsPluginTest:Target", "Expected target warning.");
end
