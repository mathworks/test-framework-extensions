classdef TestClassTeardownWarningScenarioTest < matlab.unittest.TestCase
    methods (TestClassTeardown)
        function issueTeardownWarning(~)
            warning("FailOnSpecificWarningsPluginTest:Target", ...
                "Test class teardown target warning.");
        end
    end

    methods (Test)
        function testBody(testCase)
            testCase.verifyTrue(true);
        end
    end
end
