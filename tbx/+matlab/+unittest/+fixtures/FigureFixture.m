classdef FigureFixture < matlab.unittest.fixtures.Fixture
    
    properties (SetAccess = private)
        FigureHandle
    end
    
    properties (Access = private)
        FigureCreationArgs
    end
    
    methods
        
        function fixture = FigureFixture(varargin)
            
            fixture.FigureCreationArgs = varargin;
            
        end
        
        function setup(fixture)
            
            fixture.FigureHandle = figure(fixture.FigureCreationArgs{:});
            
        end
        
        function teardown(fixture)
            
            if isvalid(fixture.FigureHandle)
                delete(fixture.FigureHandle)
            end
                
        end
        
    end
    
    methods (Access = protected)
        
        function tf = isCompatible(this,otherfx)
            
            tf = isequal(this.FigureCreationArgs,otherfx.FigureCreationArgs);
            
        end
        
    end
    
end