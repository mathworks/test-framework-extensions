classdef tGridLayoutFixture < matlab.unittest.TestCase
    %TGRIDLAYOUTFIXTURE Tests for GridLayoutFixture.

    properties ( Access = private )
        % Test figure.
        Figure(:, 1) matlab.ui.Figure {mustBeScalarOrEmpty}
    end % properties ( Access = private )

    methods ( TestClassSetup )

        function applyFigureFixture( testCase )

            fixture = testCase.applyFixture( FigureFixture() );
            testCase.Figure = fixture.Figure;

        end % applyFigureFixture

    end % methods ( TestClassSetup )

    methods ( Test )

        function tCreatesAndCleansUpGridLayout( testCase )

            fixture = GridLayoutFixture( "Parent", testCase.Figure );
            testCase.applyFixture( fixture );
            testCase.verifyTrue( isscalar( fixture.GridLayout ) && ...
                isa( fixture.GridLayout, ...
                "matlab.ui.container.GridLayout" ) && ...
                isvalid( fixture.GridLayout ) )

            fixture.teardown()
            testCase.verifyFalse( isscalar( fixture.GridLayout ) && ...
                isa( fixture.GridLayout, ...
                "matlab.ui.container.GridLayout" ) && ...
                ~isvalid( fixture.GridLayout ) )

        end % tCreatesAndCleansUpGridLayout

        function tPassesInputArgsToFigure(testCase)

            fixture = GridLayoutFixture( "Parent", testCase.Figure, ...
                "RowHeight", "1x", ...
                "ColumnWidth", ["fit", "1x"], ...
                "Padding", 5 );
            testCase.applyFixture( fixture );

            testCase.verifySameHandle( fixture.GridLayout.Parent, ...
                testCase.Figure )
            testCase.verifyThat( fixture.GridLayout.RowHeight, ...
                IsEquivalentText( "1x" ) )
            testCase.verifyThat( fixture.GridLayout.ColumnWidth, ...
                IsEquivalentText( ["fit", "1x"] ) )
            testCase.verifyEqual( fixture.GridLayout.Padding, ...
                5 * ones( 1, 4 ) )

        end % tPassesInputArgsToFigure

    end % methods ( Test )

end % classdef