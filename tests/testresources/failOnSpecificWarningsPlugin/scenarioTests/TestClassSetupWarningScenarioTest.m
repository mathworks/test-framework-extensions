classdef TestClassSetupWarningScenarioTest < matlab.unittest.TestCase

    methods ( TestClassSetup )

        function issueSetupWarning(~)

            warning("FailOnSpecificWarningsPluginTest:Target", ...
                "Test class setup target warning.");

        end % issueSetupWarning

    end % methods ( TestClassSetup )

    methods ( Test )

        function testBody(testCase)

            testCase.verifyTrue(true);

        end % testBody

    end % methods ( Test )

end % classdef
