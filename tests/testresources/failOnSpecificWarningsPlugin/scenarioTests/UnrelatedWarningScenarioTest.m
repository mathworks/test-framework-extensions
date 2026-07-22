classdef UnrelatedWarningScenarioTest < matlab.unittest.TestCase
    methods (Test)
        function testUnrelatedWarning(testCase)
            warning("FailOnSpecificWarningsPluginTest:Other", "Other warning.");

            testCase.verifyTrue(true);
        end
    end
end
