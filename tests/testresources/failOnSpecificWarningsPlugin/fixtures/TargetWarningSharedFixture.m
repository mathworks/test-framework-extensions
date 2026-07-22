classdef TargetWarningSharedFixture < matlab.unittest.fixtures.Fixture

    methods

        function setup(~)

            warning("FailOnSpecificWarningsPluginTest:Target", ...
                "Shared fixture target warning.");

        end % setup

    end % methods

end % classdef
