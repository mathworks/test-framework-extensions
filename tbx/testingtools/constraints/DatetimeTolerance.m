classdef DatetimeTolerance < matlab.unittest.constraints.Tolerance

    % Copyright 2026 The MathWorks, Inc.
    
    properties ( SetAccess = private )
        Tolerance (1,1) duration = seconds(eps)
        IgnoreNaT (1,1) logical = false
    end
    
    methods
        
        function this = DatetimeTolerance(value,nvpairs)
            
            arguments
                value (1,1) duration = seconds(eps)
                nvpairs.IgnoringNaT (1,1) logical = false
            end
            
            this.Tolerance = value;
            this.IgnoreNaT = nvpairs.IgnoringNaT;
            
        end

        function tf = supports(~,value)
            
            tf = isa(value,"datetime") || isa(value,"duration");
            
        end

        function tf = satisfiedBy(this,actual,expected)
            
            withinTol = abs(actual - expected) <= this.Tolerance;
            
            if this.IgnoreNaT
                ignore = isnat(actual) & isnat(expected);
                withinTol(ignore) = true;
            end
            
            tf = all(withinTol);
        
        end

        function diag = getDiagnosticFor(this,actual,expected)
            
            actualDifference = string(actual-expected);
            actualDifference(ismissing(actualDifference)) = "NaT";
            actualDifference = strjoin(actualDifference,",");
            
            str = "The datetimes have a difference of " + ...
                actualDifference + ". The allowable tolerance is " + ...
                string(this.Tolerance);
                
            diag = matlab.unittest.diagnostics.StringDiagnostic(str);
            
        end
        
    end
    
end