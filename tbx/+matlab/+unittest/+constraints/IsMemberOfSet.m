classdef IsMemberOfSet < matlab.unittest.constraints.Constraint
    
    properties (SetAccess = immutable)
        Set
    end
    
    methods
        
        function this = IsMemberOfSet(set)
            
            this = this@matlab.unittest.constraints.Constraint;
            this.Set = set;
            
        end
        
        function TF = satisfiedBy(this,actVal)
            
            arguments
                this (1,1)
                actVal (1,1) string
            end
            
            TF = ismember(actVal,this.Set);
            
        end
        
        function diag = getDiagnosticFor(this,actVal)
            
            arguments
                this (1,1)
                actVal (1,1) string
            end
            
            import matlab.unittest.diagnostics.StringDiagnostic

            if this.satisfiedBy(actVal)
                diag = StringDiagnostic("Constraint satisfied");
            else
                diag = StringDiagnostic(actVal + " is not a member of the set");
            end
            
        end
        
    end
    
end