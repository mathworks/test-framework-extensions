classdef GridLayoutFixture < matlab.unittest.fixtures.Fixture
    %GRIDLAYOUTFIXTURE Custom test fixture for creating a grid layout.

    % Copyright 2026 The MathWorks, Inc.

    properties ( SetAccess = private )
        % Test grid layout.
        GridLayout(:, 1) matlab.ui.container.GridLayout ...
            {mustBeScalarOrEmpty}
        % Grid layout creation arguments.
        GridLayoutArguments(1, 1) struct
    end % properties ( SetAccess = private )

    methods

        function fixture = GridLayoutFixture( namedArgs )
            %GRIDLAYOUTFIXTURE Construct the GridLayoutFixture, given 
            %optional figure name-value pair arguments.

            arguments ( Input )
                namedArgs.?matlab.ui.container.GridLayout
            end % arguments ( Input )

            % Record the grid layout creation arguments.
            fixture.GridLayoutArguments = namedArgs;

            % Add descriptions.
            fixture.SetupDescription = "Create a new uigridlayout.";
            fixture.TeardownDescription = "Delete the uigridlayout.";

        end % constructor

        function setup( fixture )

            % Create a new figure.
            fixture.GridLayout = ...
                uigridlayout( fixture.GridLayoutArguments );

            % Define the teardown action.
            fixture.addTeardown( @() delete( fixture.GridLayout ) )

        end % setup

    end % methods

    methods ( Access = protected )

        function tf = isCompatible( fixture1, fixture2 )

            tf = fixture1.GridLayout == fixture2.GridLayout;

        end % isCompatible

    end % methods ( Access = protected )

end % classdef