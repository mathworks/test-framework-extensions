classdef tDatetimeTolerance < matlab.unittest.TestCase
    
    methods (Test)
        
        function withinToleranceReportsEqual(this)
            
            dt1 = datetime("2020-12-04 09:00:00");
            dt2 = datetime("2020-12-04 09:00:10");
            
            tol = matlab.unittest.constraints.DatetimeTolerance(seconds(11));
            isEqWithTol = matlab.unittest.constraints.IsEqualTo(dt2,"Within",tol);
            
            this.verifyThat(dt1,isEqWithTol)
                        
        end
        
        function outsideToleranceReportsNotEqual(this)
            
            dt1 = datetime("2020-12-04 09:00:00");
            dt2 = datetime("2020-12-04 09:00:10");
            
            tol = matlab.unittest.constraints.DatetimeTolerance(seconds(9));
            isEqWithTol = matlab.unittest.constraints.IsEqualTo(dt2,"Within",tol);
            
            this.verifyThat(dt1,~isEqWithTol)
            
        end
        
    end
    
end