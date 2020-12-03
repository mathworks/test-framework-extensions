classdef DatetimeTolerance < matlab.unittest.constraints.Tolerance
    
    properties
        Tolerance (1,1) duration = seconds(1)
    end
    
    methods
        
        function this = DatetimeTolerance(value)
            
            this.Tolerance = value;
            
        end

        function tf = supports(~,value)
            
            tf = isa(value, 'datetime');
            
        end

        function tf = satisfiedBy(this,actual,expected)
            
            tf = abs(actual - expected) <= this.Tolerance;
        
        end

        function diag = getDiagnosticFor(this,actual,expected)
            
            str = "The datetimes have a difference of " + ...
                string(actual-expected) + ". The allowable tolerance is " + ...
                string(this.Tolerance);
                
            diag = matlab.unittest.diagnostics.StringDiagnostic(str);
            
        end
    end
    
end