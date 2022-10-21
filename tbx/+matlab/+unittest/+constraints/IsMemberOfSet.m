classdef IsMemberOfSet < matlab.unittest.constraints.BooleanConstraint
    
    properties (SetAccess = immutable)
        Set
    end
    
    methods
        
        function this = IsMemberOfSet(set)
            
            this = this@matlab.unittest.constraints.BooleanConstraint;
            this.Set = set;
            
        end
        
        function TF = satisfiedBy(this,actVal)
            
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
    
    methods (Access = protected)
        
        function diag = getNegativeDiagnosticFor(this,actVal)
            
            import matlab.unittest.diagnostics.StringDiagnostic

            if ~this.satisfiedBy(actVal)
                diag = StringDiagnostic("Constraint satisfied");
            else
                diag = StringDiagnostic(actVal + " is a member of the set");
            end
            
        end
        
    end
    
end