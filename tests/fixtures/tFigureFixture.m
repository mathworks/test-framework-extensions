classdef tFigureFixture < matlab.unittest.TestCase
    
    methods (Test)
        
        function createsAndCleansUpFigure(this)
            
            fx = FigureFixture();
            this.applyFixture(fx);
            this.verifyTrue(isscalar(fx.Figure) && isa(fx.Figure, "matlab.ui.Figure") && isvalid(fx.Figure))
            
            fx.teardown()
            this.verifyFalse(isscalar(fx.Figure) && isa(fx.Figure, "matlab.ui.Figure") && ~isvalid(fx.Figure))
            
        end
        
        function passesInputArgsToFigure(this)
            
            fx = FigureFixture("Color","blue");
            this.applyFixture(fx);
            
            this.verifyEqual(fx.Figure.Color,[0 0 1])
            
        end
        
    end
    
end