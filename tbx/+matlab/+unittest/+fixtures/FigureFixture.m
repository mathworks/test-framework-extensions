classdef FigureFixture < matlab.unittest.fixtures.Fixture
    % FigureFixture creates a figure in the property FigureHandle. The
    % figure is deleted when the fixture is torn down.
    
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
    
end