classdef UnrelatedWarningScenarioTest < matlab.unittest.TestCase

    methods ( Test )

        function testUnrelatedWarning(testCase)

            warning("FailOnSpecificWarningsPluginTest:Other", "Other warning.");

            testCase.verifyTrue(true);

        end % testUnrelatedWarning

    end % methods ( Test )

end % classdef
