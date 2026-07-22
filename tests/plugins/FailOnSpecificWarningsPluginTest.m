classdef FailOnSpecificWarningsPluginTest < matlab.unittest.TestCase
    %FailOnSpecificWarningsPluginTest Tests FailOnSpecificWarningsPlugin.

    properties ( Constant )
        TargetID = "FailOnSpecificWarningsPluginTest:Target"
        OtherID = "FailOnSpecificWarningsPluginTest:Other"
        SecondID = "FailOnSpecificWarningsPluginTest:Second"
    end % properties ( Constant )

    methods ( TestClassSetup )

        function addProjectFoldersToPath(testCase)

            testFolder = fullfile( ...
                testroot(), "testresources", "failOnSpecificWarningsPlugin" );
            scenarioTestFolder = fullfile( testFolder, "scenarioTests" );
            fixtureFolder = fullfile( testFolder, "fixtures" );
            testCase.applyFixture( ...
                matlab.unittest.fixtures.PathFixture( scenarioTestFolder ) );
            testCase.applyFixture( ...
                matlab.unittest.fixtures.PathFixture( fixtureFolder ) );

        end % addProjectFoldersToPath

    end % methods ( TestClassSetup )

    methods ( Test )

        function warningFreeTestPasses(testCase)

            results = testCase.runScenarioTest( ...
                "WarningFreeScenarioTest", testCase.TargetID );

            testCase.verifyFalse( any( [results.Failed] ) );

        end % warningFreeTestPasses

        function unrelatedWarningPasses(testCase)

            results = testCase.runScenarioTest( ...
                "UnrelatedWarningScenarioTest", testCase.TargetID );

            testCase.verifyFalse( any( [results.Failed] ) );

        end % unrelatedWarningPasses

        function targetWarningFails(testCase)

            results = testCase.runScenarioTest( ...
                "TargetWarningScenarioTest", testCase.TargetID );

            testCase.verifyTrue( any( [results.Failed] ) );

        end % targetWarningFails

        function multipleTargetWarningsFail(testCase)

            results = testCase.runScenarioTest( ...
                "SecondWarningScenarioTest", ...
                [testCase.TargetID, testCase.SecondID] );

            testCase.verifyTrue( any( [results.Failed] ) );

        end % multipleTargetWarningsFail

        function expectedTargetWarningPasses(testCase)

            results = testCase.runScenarioTest( ...
                "ExpectedTargetWarningScenarioTest", testCase.TargetID );

            testCase.verifyFalse( any( [results.Failed] ) );

        end % expectedTargetWarningPasses

        function testClassSetupWarningFails(testCase)

            results = testCase.runScenarioTest( ...
                "TestClassSetupWarningScenarioTest", testCase.TargetID );

            testCase.verifyTrue( any( [results.Failed] ) );

        end % testClassSetupWarningFails

        function testClassTeardownWarningFails(testCase)

            results = testCase.runScenarioTest( ...
                "TestClassTeardownWarningScenarioTest", testCase.TargetID );

            testCase.verifyTrue( any( [results.Failed] ) );

        end % testClassTeardownWarningFails

        function sharedFixtureWarningFails(testCase)

            results = testCase.runScenarioTest( ...
                "SharedFixtureWarningScenarioTest", testCase.TargetID );

            testCase.verifyTrue( any( [results.Failed] ) );

        end % sharedFixtureWarningFails

        function invalidIdentifierErrors(testCase)

            testCase.verifyError( @() FailOnSpecificWarningsPlugin("not valid"), ...
                "FailOnSpecificWarningsPlugin:InvalidIdentifier");

        end % invalidIdentifierErrors

        function emptyIdentifierErrors(testCase)

            testCase.verifyError( @() FailOnSpecificWarningsPlugin(string.empty), ...
                "FailOnSpecificWarningsPlugin:EmptyIdentifiers");

        end % emptyIdentifierErrors

    end % methods ( Test )

    methods ( Access = private )

        function results = runScenarioTest(~, scenarioClassName, warningIdentifiers)

            import matlab.unittest.TestRunner

            suite = testsuite(scenarioClassName);
            runner = TestRunner.withNoPlugins;
            runner.addPlugin(FailOnSpecificWarningsPlugin(warningIdentifiers));

            results = runner.run(suite);

        end % runScenarioTest

    end % methods ( Access = private )

end % classdef
