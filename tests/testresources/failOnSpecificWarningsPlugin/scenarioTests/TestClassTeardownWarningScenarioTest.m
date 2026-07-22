classdef TestClassTeardownWarningScenarioTest < matlab.unittest.TestCase

    methods ( TestClassTeardown )

        function issueTeardownWarning(~)

            warning("FailOnSpecificWarningsPluginTest:Target", ...
                "Test class teardown target warning.");

        end % issueTeardownWarning

    end % methods ( TestClassTeardown )

    methods ( Test )

        function testBody(testCase)

            testCase.verifyTrue(true);

        end % testBody

    end % methods ( Test )

end % classdef
