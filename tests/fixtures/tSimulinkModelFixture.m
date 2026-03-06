classdef tSimulinkModelFixture < matlab.unittest.TestCase

    properties (Access = private)
        ModelName (1,1) string = "testModel"
    end

    methods (Test)

        function fixtureWorks(this)

            p = fullfile(testroot(),"testresources","slmodelfixture");
            pfx = matlab.unittest.fixtures.PathFixture(p);
            this.applyFixture(pfx);

            this.assertFalse(bdIsLoaded(this.ModelName))

            fx = SimulinkModelFixture(this.ModelName);
            this.applyFixture(fx);

            this.verifyTrue(bdIsLoaded(this.ModelName))

        end

    end

    methods (TestClassTeardown)

        function verifyModelNotLoaded(this)

            % Do verification here as fixture teardown doesn't get
            % triggered until test method exit.
            this.verifyFalse(bdIsLoaded(this.ModelName))

        end

    end

end