classdef MatchesStatistically < matlab.unittest.constraints.Constraint
    % MATCHESSTATISTICALLY is a constraint that determines whether a given
    % percentage of elements in a given vector match an expected vector, up
    % to an absolute or relative tolerance.
    
    properties (SetAccess = private)
        Expected (1,:) double
        AbsTol (1,1) matlab.unittest.constraints.AbsoluteTolerance = 0
        RelTol (1,1) matlab.unittest.constraints.RelativeTolerance = 0
        Percentage (1,1) double {mustBeLessThanOrEqual(Percentage, 100)} = 100
    end
    
    methods
        function obj = MatchesStatistically(value, nvp)
            arguments
                value (1,:) double
                nvp.AbsTol (1,1) matlab.unittest.constraints.AbsoluteTolerance = 0
                nvp.RelTol (1,1) matlab.unittest.constraints.RelativeTolerance = 0
                nvp.Percentage (1,1) double {mustBeLessThanOrEqual(nvp.Percentage, 100)} = 100
            end
            
            obj.Expected = value;
            obj.AbsTol = nvp.AbsTol;
            obj.RelTol = nvp.RelTol;
            obj.Percentage = nvp.Percentage;
        end
        
        function tf = satisfiedBy(obj, actual)
            [tf, ~] = obj.arrayMatchesExpected(actual);
        end
        
        function diag = getDiagnosticFor(obj, actual)
            [~, diag] = obj.arrayMatchesExpected(actual);
        end
        
    end
    
    
    methods (Access = private)
        
        function [tf, diag] = arrayMatchesExpected(obj, actual)
            import matlab.unittest.constraints.*
            
            % Check arrays have the same length using the built-in
            % HasLength constraint. Reuse its diagnostics if it fails.
            hasLength = HasLength(length(obj.Expected));
            if ~hasLength.satisfiedBy(actual)
                tf = false;
                diag = hasLength.getDiagnosticFor(actual);
                diag.diagnose();
                return
            end
            
            % Check how many array elements are within absolute or relative
            % tolerances.
            error = abs(actual - obj.Expected);
            isWithinAbsTol = error <= obj.AbsTol.Values{:};
            isWithinRelTol = error <= obj.RelTol.Values{:}*abs(obj.Expected);
            
            actualPercentage = nnz(isWithinAbsTol | isWithinRelTol)/numel(actual);
            
            % Use the built-in IsGreaterThanOrEqualTo constraint to check
            % the minimum percentage is met. Use custom diagnostics if this
            % fails.
            isgreateroreqto = IsGreaterThanOrEqualTo(obj.Percentage/100);
            tf = isgreateroreqto.satisfiedBy(actualPercentage);
            
            import matlab.unittest.diagnostics.StringDiagnostic
            if tf
                diag = StringDiagnostic("MatchesStatistically passed.");
                
            else
                diag = StringDiagnostic(sprintf( ...
                    "MatchesStatistically failed.\nPercentage of elements matching: " + ...
                    "%s%% \nRequired percentage: %s%%", ...
                    num2str(actualPercentage*100), ...
                    num2str(obj.Percentage)));
            end
        end
        
    end
    
end