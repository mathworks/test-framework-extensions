classdef IsSamePathAs < matlab.unittest.constraints.BooleanConstraint

    % Copyright 2026 The MathWorks, Inc.
    
    properties (SetAccess=immutable)
        ExpectedPath (1,1) string
    end
    
    methods
        
        function this = IsSamePathAs(expected)
            
            this.ExpectedPath = expected;
            
        end
        
        function tf = satisfiedBy(this,actual)

            actual = normalizePath(actual);
            expected = normalizePath(this.ExpectedPath);

            % Windows is case insensitive, other platforms are not
            if ispc
                tf = strcmpi(actual,expected);
            else
                tf = strcmp(actual,expected);
            end

        end
        
        function s = getDiagnosticFor(this,actual)
            
            import matlab.automation.diagnostics.StringDiagnostic
            
            if this.satisfiedBy(actual)
                s = StringDiagnostic("IsSamePathAs passed.");
            else
                s = StringDiagnostic("IsSamePathAs failed."+newline+"Actual value: "+actual+newline+"Expected value: "+this.ExpectedPath);
            end
            
        end
        
    end
    
    methods (Access=protected)
        
        function s = getNegativeDiagnosticFor(this,actual)
            
            import matlab.automation.diagnostics.StringDiagnostic
            
            if this.satisfiedBy(actual)
                s = StringDiagnostic("IsSamePathAs failed. Both values were equivalent to " + actual);
            else
                s = StringDiagnostic("IsSamePathAs passed.");
            end
            
        end
        
    end

end

function p = normalizePath(p)
% Normalize path separators and strip trailing separators

p = string(p);
p = replace(p, "\", "/");
p = strip(p, "right", "/");

end