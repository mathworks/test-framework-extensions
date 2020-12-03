classdef HasStringLengthLessThan < matlab.unittest.constraints.Constraint
    
    properties (SetAccess = immutable)
        MaximumStringLength (1,1) double = namelengthmax()
    end
    
    methods
        
        function this = HasStringLengthLessThan(maxVal)
            
            this = this@matlab.unittest.constraints.Constraint;
            this.MaximumStringLength = maxVal;
            
        end
        
        function TF = satisfiedBy(this,actVal)
            
            arguments
                this (1,1)
                actVal string
            end
            
            TF = all(this.compareEachElement(actVal),"all");
            
        end
        
        function diag = getDiagnosticFor(this,actVal)
            
            import matlab.unittest.diagnostics.StringDiagnostic

            if this.satisfiedBy(actVal)
                diag = StringDiagnostic("Constraint satisfied");
            else
                failedSubset = actVal(~this.compareEachElement(actVal));
                failedSubsetStrList = strjoin(failedSubset(:),newline());
                diag = StringDiagnostic("The following names do not have a length less than " + this.MaximumStringLength + ":" + newline() + failedSubsetStrList);
            end
            
        end
        
    end
    
    methods (Access = private)
        
        function tfArray = compareEachElement(this,actVal)
            
            tfArray = strlength(actVal) < this.MaximumStringLength;
            
        end
        
    end
    
end