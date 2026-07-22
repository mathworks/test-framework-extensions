classdef TargetWarningScenarioTest < matlab.unittest.TestCase
    methods (Test)
        function testTargetWarning(testCase)
            warning("FailOnSpecificWarningsPluginTest:Target", "Target warning.");

            testCase.verifyTrue(true);
        end
    end
end
