classdef FailOnSpecificWarningsPlugin < matlab.unittest.plugins.QualifyingPlugin & ...
                                      matlab.unittest.plugins.Parallelizable
    %FailOnSpecificWarningsPlugin Fail tests that issue specified warnings.
    %   plugin = FailOnSpecificWarningsPlugin(identifiers) creates a plugin
    %   that fails tests only when a warning with one of the specified
    %   identifiers is issued.

    properties (SetAccess=immutable)
        WarningIdentifiers string
    end

    properties (Access=private)
        Logger
        LocalWarnings
        TestClassSetupWarnings
        SharedTestFixtureWarningsStack
    end

    methods
        function plugin = FailOnSpecificWarningsPlugin(identifiers)
            arguments
                identifiers {mustBeText}
            end

            identifiers = string(identifiers);
            identifiers = identifiers(:).';
            validateWarningIdentifiers(identifiers);

            plugin.WarningIdentifiers = identifiers;
        end
    end

    methods (Hidden, Sealed)
        function tf = supportsParallelThreadPool_(~)
            tf = true;
        end
    end

    methods (Hidden, Access=protected)
        function runTestSuite(plugin, pluginData)
            import matlab.unittest.internal.ExpectedWarningsNotifier
            import matlab.unittest.internal.constraints.WarningLogger

            plugin.Logger = WarningLogger;
            plugin.resetSharedTestFixtureWarningsStack;

            expectedWarningsListener = ExpectedWarningsNotifier.createExpectedWarningsListener( ...
                @plugin.recordExpectedWarning); %#ok<NASGU>

            runTestSuite@matlab.unittest.plugins.QualifyingPlugin(plugin, pluginData);
        end

        function fixture = createSharedTestFixture(plugin, pluginData)
            fixture = createSharedTestFixture@matlab.unittest.plugins.QualifyingPlugin(plugin, pluginData);
            plugin.initializeSharedFixtureWarningStackForNewSharedTestFixture;
        end

        function setupSharedTestFixture(plugin, pluginData)
            plugin.startLoggingWarnings;
            cleanup = matlab.unittest.internal.Teardownable;
            cleanup.addTeardown(@()plugin.stopLoggingWarningsInSharedTestFixtureSetup);
            setupSharedTestFixture@matlab.unittest.plugins.QualifyingPlugin(plugin, pluginData);
        end

        function teardownSharedTestFixture(plugin, pluginData)
            setupWarnings = plugin.peekSharedTestFixtureWarningsStack;
            plugin.popSharedTestFixtureWarningsStack;

            plugin.startLoggingWarnings;
            teardownSharedTestFixture@matlab.unittest.plugins.QualifyingPlugin(plugin, pluginData);
            teardownWarnings = plugin.stopLoggingWarnings;

            plugin.assertWarningFree(pluginData, [setupWarnings, teardownWarnings]);
        end

        function setupTestClass(plugin, pluginData)
            plugin.startLoggingWarnings;
            cleanup = matlab.unittest.internal.Teardownable;
            cleanup.addTeardown(@()plugin.stopLoggingWarningsInTestClassSetup);
            setupTestClass@matlab.unittest.plugins.QualifyingPlugin(plugin, pluginData);
        end

        function teardownTestClass(plugin, pluginData)
            plugin.startLoggingWarnings;
            teardownTestClass@matlab.unittest.plugins.QualifyingPlugin(plugin, pluginData);
            teardownWarnings = plugin.stopLoggingWarnings;

            warnings = [plugin.TestClassSetupWarnings, teardownWarnings];
            plugin.verifyWarningFree(pluginData, warnings);
        end

        function setupTestMethod(plugin, pluginData)
            plugin.startLoggingWarnings;
            setupTestMethod@matlab.unittest.plugins.QualifyingPlugin(plugin, pluginData);
        end

        function teardownTestMethod(plugin, pluginData)
            teardownTestMethod@matlab.unittest.plugins.QualifyingPlugin(plugin, pluginData);
            plugin.verifyWarningFree(pluginData, plugin.stopLoggingWarnings);
        end
    end

    methods (Access=private)
        function startLoggingWarnings(plugin)
            import matlab.internal.diagnostic.Warning

            plugin.LocalWarnings = Warning.empty;
            plugin.Logger.clear;
            plugin.Logger.start;
        end

        function warnings = stopLoggingWarnings(plugin)
            plugin.Logger.stop;
            plugin.makeWarningsLocal;
            plugin.keepOnlySpecifiedWarnings;
            warnings = plugin.LocalWarnings;
        end

        function stopLoggingWarningsInSharedTestFixtureSetup(plugin)
            warnings = plugin.stopLoggingWarnings;
            plugin.replaceArrayAtTopOfSharedFixtureStack(warnings);
        end

        function stopLoggingWarningsInTestClassSetup(plugin)
            plugin.TestClassSetupWarnings = plugin.stopLoggingWarnings;
        end

        function recordExpectedWarning(plugin, expectedWarnings)
            plugin.makeWarningsLocal;
            plugin.removeExpectedWarningsFromLocalWarnings(expectedWarnings);
        end

        function makeWarningsLocal(plugin)
            plugin.LocalWarnings = [plugin.LocalWarnings, plugin.Logger.Warnings];
            plugin.Logger.clear;
        end

        function removeExpectedWarningsFromLocalWarnings(plugin, expectedWarnings)
            plugin.LocalWarnings(ismember(plugin.LocalWarnings, expectedWarnings)) = [];
        end

        function keepOnlySpecifiedWarnings(plugin)
            identifiers = string({plugin.LocalWarnings.identifier});
            plugin.LocalWarnings(~ismember(identifiers, plugin.WarningIdentifiers)) = [];
        end

        function assertWarningFree(plugin, pluginData, warnings)
            import matlab.unittest.internal.plugins.IsWarningFree
            import matlab.unittest.internal.plugins.WarningHistory

            history = WarningHistory(pluginData.Name, warnings);
            plugin.assertUsing(pluginData.QualificationContext, history, IsWarningFree);
        end

        function verifyWarningFree(plugin, pluginData, warnings)
            import matlab.unittest.internal.plugins.IsWarningFree
            import matlab.unittest.internal.plugins.WarningHistory

            history = WarningHistory(pluginData.Name, warnings);
            plugin.verifyUsing(pluginData.QualificationContext, history, IsWarningFree);
        end

        function resetSharedTestFixtureWarningsStack(plugin)
            plugin.SharedTestFixtureWarningsStack = {};
        end

        function initializeSharedFixtureWarningStackForNewSharedTestFixture(plugin)
            import matlab.internal.diagnostic.Warning

            plugin.SharedTestFixtureWarningsStack = [{Warning.empty(1, 0)}, ...
                plugin.SharedTestFixtureWarningsStack];
        end

        function replaceArrayAtTopOfSharedFixtureStack(plugin, warnings)
            plugin.SharedTestFixtureWarningsStack{1} = warnings;
        end

        function warnings = peekSharedTestFixtureWarningsStack(plugin)
            warnings = plugin.SharedTestFixtureWarningsStack{1};
        end

        function popSharedTestFixtureWarningsStack(plugin)
            plugin.SharedTestFixtureWarningsStack(1) = [];
        end
    end
end

function validateWarningIdentifiers(identifiers)
if isempty(identifiers)
    error("FailOnSpecificWarningsPlugin:EmptyIdentifiers", ...
        "Specify at least one warning identifier.");
end

invalidIdentifiers = identifiers(strlength(identifiers) == 0 | ...
    arrayfun(@(id)isempty(regexp(id, ...
    "^[A-Za-z]\w*(?::[A-Za-z]\w*)+$", "once")), identifiers));

if ~isempty(invalidIdentifiers)
    error("FailOnSpecificWarningsPlugin:InvalidIdentifier", ...
        "Invalid warning identifier: %s", invalidIdentifiers(1));
end
end
