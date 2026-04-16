classdef tMatchesStatistically < matlab.unittest.TestCase
    
    methods (Test)

        function tVerifyArraysMatch(testCase)
            % By default, the Percentage input is 100% and
            % MatchesStatistically is equivalent to IsEqualTo.
            A = 1:10;
            B = (1:10) + 0.5;            
            
            testCase.verifyThat(A, MatchesStatistically(B, "AbsTol", 1));
        end
        
        function tArraysMatchWithZeroTolerance(testCase)
            % 90% of the elements are required to be perfectly equal.
            A = [1 2 3 4 1000 6 7 8 9 10];
            B = 1:10;            
            
            testCase.verifyThat(A, MatchesStatistically(B, "Percentage", 90));
        end
        
        function tArraysDoNotMatch(testCase)
            A = 1:10;
            B = [100 100 100 4:10];

            constr = MatchesStatistically(B, "AbsTol", 1);
            diag = constr.getDiagnosticFor(A);
            
            expectedText = "MatchesStatistically failed." + newline + ...
                "Percentage of elements matching: 70% " + newline + "Required percentage: 100%";
            testCase.verifyEqual(diag.DiagnosticText, char(expectedText));
        end
        
    end
    
end