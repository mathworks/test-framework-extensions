classdef FigureFixture < matlab.unittest.fixtures.Fixture
    %FIGUREFIXTURE Custom test fixture.

    % Copyright 2026 The MathWorks, Inc.

    properties ( SetAccess = private )
        % Test figure.
        Figure(:, 1) matlab.ui.Figure {mustBeScalarOrEmpty}
        % Figure creation arguments.
        FigureArguments(1, 1) struct
    end % properties ( SetAccess = private )

    methods

        function fixture = FigureFixture( namedArgs )
            %FIGUREFIXTURE Construct the FigureFixture, given optional
            %figure name-value pair arguments.

            arguments ( Input )
                namedArgs.?matlab.ui.Figure
            end % arguments ( Input )

            % Record the figure creation arguments.
            fixture.FigureArguments = namedArgs;

            % Add descriptions.
            fixture.SetupDescription = "Create a new uifigure.";
            fixture.TeardownDescription = "Delete the uifigure.";

        end % constructor

        function setup( fixture )

            % Create a new figure.
            fixture.Figure = uifigure( fixture.FigureArguments );

            % Define the teardown action.
            fixture.addTeardown( @() delete( fixture.Figure ) )

        end % setup

    end % methods

    methods ( Access = protected )

        function tf = isCompatible( fixture1, fixture2 )

            tf = fixture1.Figure == fixture2.Figure;

        end % isCompatible

    end % methods ( Access = protected )

end % classdef