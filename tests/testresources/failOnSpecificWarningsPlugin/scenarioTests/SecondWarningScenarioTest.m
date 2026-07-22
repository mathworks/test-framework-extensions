classdef SecondWarningScenarioTest < matlab.unittest.TestCase
    methods (Test)
        function testSecondWarning(testCase)
            warning("FailOnSpecificWarningsPluginTest:Second", "Second warning.");

            testCase.verifyTrue(true);
        end
    end
end
