classdef FailOnSpecificWarningsPlugin < matlab.unittest.plugins.QualifyingPlugin & ...
        matlab.unittest.plugins.Parallelizable
    %FailOnSpecificWarningsPlugin - Fail tests that issue selected warnings
    %   PLUGIN = FailOnSpecificWarningsPlugin(IDENTIFIERS) creates a
    %   plugin that fails tests when code issues a warning whose identifier
    %   is listed in IDENTIFIERS. Warnings verified with VERIFYWARNING are
    %   ignored.
    %
    %   FailOnSpecificWarningsPlugin functions:
    %       FailOnSpecificWarningsPlugin - Create plugin that fails on warnings
    %
    %   FailOnSpecificWarningsPlugin properties:
    %       WarningIdentifiers - Warning identifiers that fail tests
    %
    %   See also matlab.unittest.TestRunner, verifyWarning

    % Copyright 2026 The MathWorks, Inc.

    properties ( SetAccess = immutable )
        WarningIdentifiers string % Warning identifiers that fail tests.
    end % properties ( SetAccess = immutable )

    properties ( Access = private )
        Logger
        LocalWarnings
        TestClassSetupWarnings
        SharedTestFixtureWarningsStack
    end % properties ( Access = private )

    methods

        function plugin = FailOnSpecificWarningsPlugin(identifiers)

            arguments
                identifiers {mustBeText}
            end % arguments

            identifiers = string(identifiers);
            identifiers = identifiers(:).';
            validateWarningIdentifiers(identifiers);

            plugin.WarningIdentifiers = identifiers;
        end % constructor

    end % methods

    methods ( Hidden, Sealed )

        function tf = supportsParallelThreadPool_(~)

            tf = true;

        end % supportsParallelThreadPool_

    end % methods ( Hidden, Sealed )

    methods ( Hidden, Access = protected )

        function runTestSuite(plugin, pluginData)

            import matlab.unittest.internal.ExpectedWarningsNotifier
            import matlab.unittest.internal.constraints.WarningLogger

            plugin.Logger = WarningLogger;
            plugin.resetSharedTestFixtureWarningsStack;

            expectedWarningsListener = ExpectedWarningsNotifier.createExpectedWarningsListener( ...
                @plugin.recordExpectedWarning); %#ok<NASGU>

            runTestSuite@matlab.unittest.plugins.QualifyingPlugin(plugin, pluginData);

        end % runTestSuite

        function fixture = createSharedTestFixture(plugin, pluginData)

            fixture = createSharedTestFixture@matlab.unittest.plugins.QualifyingPlugin(plugin, pluginData);
            plugin.initializeSharedFixtureWarningStackForNewSharedTestFixture;

        end % createSharedTestFixture

        function setupSharedTestFixture(plugin, pluginData)

            plugin.startLoggingWarnings;
            cleanup = matlab.unittest.internal.Teardownable;
            cleanup.addTeardown(@()plugin.stopLoggingWarningsInSharedTestFixtureSetup);
            setupSharedTestFixture@matlab.unittest.plugins.QualifyingPlugin(plugin, pluginData);

        end % setupSharedTestFixture

        function teardownSharedTestFixture(plugin, pluginData)

            setupWarnings = plugin.peekSharedTestFixtureWarningsStack;
            plugin.popSharedTestFixtureWarningsStack;

            plugin.startLoggingWarnings;
            teardownSharedTestFixture@matlab.unittest.plugins.QualifyingPlugin(plugin, pluginData);
            teardownWarnings = plugin.stopLoggingWarnings;

            plugin.assertWarningFree(pluginData, [setupWarnings, teardownWarnings]);

        end % teardownSharedTestFixture

        function setupTestClass(plugin, pluginData)

            plugin.startLoggingWarnings;
            cleanup = matlab.unittest.internal.Teardownable;
            cleanup.addTeardown(@()plugin.stopLoggingWarningsInTestClassSetup);
            setupTestClass@matlab.unittest.plugins.QualifyingPlugin(plugin, pluginData);

        end % setupTestClass

        function teardownTestClass(plugin, pluginData)

            plugin.startLoggingWarnings;
            teardownTestClass@matlab.unittest.plugins.QualifyingPlugin(plugin, pluginData);
            teardownWarnings = plugin.stopLoggingWarnings;

            warnings = [plugin.TestClassSetupWarnings, teardownWarnings];
            plugin.verifyWarningFree(pluginData, warnings);

        end % teardownTestClass

        function setupTestMethod(plugin, pluginData)

            plugin.startLoggingWarnings;
            setupTestMethod@matlab.unittest.plugins.QualifyingPlugin(plugin, pluginData);

        end % setupTestMethod

        function teardownTestMethod(plugin, pluginData)

            teardownTestMethod@matlab.unittest.plugins.QualifyingPlugin(plugin, pluginData);
            plugin.verifyWarningFree(pluginData, plugin.stopLoggingWarnings);

        end % teardownTestMethod

    end % methods ( Hidden, Access = protected )

    methods ( Access = private )

        function startLoggingWarnings(plugin)

            import matlab.internal.diagnostic.Warning

            plugin.LocalWarnings = Warning.empty;
            plugin.Logger.clear;
            plugin.Logger.start;

        end % startLoggingWarnings

        function warnings = stopLoggingWarnings(plugin)

            plugin.Logger.stop;
            plugin.makeWarningsLocal;
            plugin.keepOnlySpecifiedWarnings;
            warnings = plugin.LocalWarnings;

        end % stopLoggingWarnings

        function stopLoggingWarningsInSharedTestFixtureSetup(plugin)

            warnings = plugin.stopLoggingWarnings;
            plugin.replaceArrayAtTopOfSharedFixtureStack(warnings);

        end % stopLoggingWarningsInSharedTestFixtureSetup

        function stopLoggingWarningsInTestClassSetup(plugin)

            plugin.TestClassSetupWarnings = plugin.stopLoggingWarnings;

        end % stopLoggingWarningsInTestClassSetup

        function recordExpectedWarning(plugin, expectedWarnings)

            plugin.makeWarningsLocal;
            plugin.removeExpectedWarningsFromLocalWarnings(expectedWarnings);

        end % recordExpectedWarning

        function makeWarningsLocal(plugin)

            plugin.LocalWarnings = [plugin.LocalWarnings, plugin.Logger.Warnings];
            plugin.Logger.clear;

        end % makeWarningsLocal

        function removeExpectedWarningsFromLocalWarnings(plugin, expectedWarnings)

            plugin.LocalWarnings(ismember(plugin.LocalWarnings, expectedWarnings)) = [];

        end % removeExpectedWarningsFromLocalWarnings

        function keepOnlySpecifiedWarnings(plugin)

            identifiers = string({plugin.LocalWarnings.identifier});
            plugin.LocalWarnings(~ismember(identifiers, plugin.WarningIdentifiers)) = [];

        end % keepOnlySpecifiedWarnings

        function assertWarningFree(plugin, pluginData, warnings)

            import matlab.unittest.internal.plugins.IsWarningFree
            import matlab.unittest.internal.plugins.WarningHistory

            history = WarningHistory(pluginData.Name, warnings);
            plugin.assertUsing(pluginData.QualificationContext, history, IsWarningFree);

        end % assertWarningFree

        function verifyWarningFree(plugin, pluginData, warnings)

            import matlab.unittest.internal.plugins.IsWarningFree
            import matlab.unittest.internal.plugins.WarningHistory

            history = WarningHistory(pluginData.Name, warnings);
            plugin.verifyUsing(pluginData.QualificationContext, history, IsWarningFree);

        end % verifyWarningFree

        function resetSharedTestFixtureWarningsStack(plugin)

            plugin.SharedTestFixtureWarningsStack = {};

        end % resetSharedTestFixtureWarningsStack

        function initializeSharedFixtureWarningStackForNewSharedTestFixture(plugin)

            import matlab.internal.diagnostic.Warning

            plugin.SharedTestFixtureWarningsStack = [{Warning.empty(1, 0)}, ...
                plugin.SharedTestFixtureWarningsStack];

        end % initializeSharedFixtureWarningStackForNewSharedTestFixture

        function replaceArrayAtTopOfSharedFixtureStack(plugin, warnings)

            plugin.SharedTestFixtureWarningsStack{1} = warnings;

        end % replaceArrayAtTopOfSharedFixtureStack

        function warnings = peekSharedTestFixtureWarningsStack(plugin)

            warnings = plugin.SharedTestFixtureWarningsStack{1};

        end % peekSharedTestFixtureWarningsStack

        function popSharedTestFixtureWarningsStack(plugin)

            plugin.SharedTestFixtureWarningsStack(1) = [];

        end % popSharedTestFixtureWarningsStack

    end % methods ( Access = private )

end % classdef

function validateWarningIdentifiers(identifiers)

if isempty(identifiers)
    error("FailOnSpecificWarningsPlugin:EmptyIdentifiers", ...
        "Specify at least one warning identifier.");
end % if

invalidIdentifiers = identifiers(strlength(identifiers) == 0 | ...
    arrayfun(@(id)isempty(regexp(id, ...
    "^[A-Za-z]\w*(?::[A-Za-z]\w*)+$", "once")), identifiers));

if ~isempty(invalidIdentifiers)
    error("FailOnSpecificWarningsPlugin:InvalidIdentifier", ...
        "Invalid warning identifier: %s", invalidIdentifiers(1));
end % if

end % validateWarningIdentifiers
