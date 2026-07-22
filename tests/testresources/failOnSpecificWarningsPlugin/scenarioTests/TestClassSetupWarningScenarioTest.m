classdef TestClassSetupWarningScenarioTest < matlab.unittest.TestCase
    methods (TestClassSetup)
        function issueSetupWarning(~)
            warning("FailOnSpecificWarningsPluginTest:Target", ...
                "Test class setup target warning.");
        end
    end

    methods (Test)
        function testBody(testCase)
            testCase.verifyTrue(true);
        end
    end
end
