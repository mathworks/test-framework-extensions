classdef tFigureFixture < matlab.unittest.TestCase
    
    methods (Test)
        
        function createsAndCleansUpFigure(this)
            
            fx = FigureFixture();
            this.applyFixture(fx);
            this.verifyTrue(isgraphics(fx.FigureHandle))
            
            fx.teardown()
            this.verifyFalse(isgraphics(fx.FigureHandle))
            
        end
        
        function passesInputArgsToFigure(this)
            
            fx = FigureFixture("Color","blue");
            this.applyFixture(fx);
            
            this.verifyEqual(fx.FigureHandle.Color,[0 0 1])
            
        end
        
    end
    
end