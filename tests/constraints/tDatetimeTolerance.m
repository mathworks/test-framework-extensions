classdef tDatetimeTolerance < matlab.unittest.TestCase
    
    methods (Test)
        
        function withinToleranceReportsEqual(this)
            
            dt1 = datetime("2020-12-04 09:00:00");
            dt2 = datetime("2020-12-04 09:00:10");
            
            tol = DatetimeTolerance(seconds(11));
            isEqWithTol = matlab.unittest.constraints.IsEqualTo(dt2,"Within",tol);
            
            this.verifyThat(dt1,isEqWithTol)
                        
        end
        
        function outsideToleranceReportsNotEqual(this)
            
            dt1 = datetime("2020-12-04 09:00:00");
            dt2 = datetime("2020-12-04 09:00:10");
            
            tol = DatetimeTolerance(seconds(9));
            isEqWithTol = matlab.unittest.constraints.IsEqualTo(dt2,"Within",tol);
            
            this.verifyThat(dt1,~isEqWithTol)
            
        end
        
        function durationWithinToleranceReportsEqual(this)
            
            d = seconds([1 3]);
            
            tol = DatetimeTolerance(seconds(3));
            isEqWithTol = matlab.unittest.constraints.IsEqualTo(d(1),"Within",tol);
            
            this.verifyThat(d(2),isEqWithTol)
            
        end
        
        function durationOutsideToleranceReportsNotEqual(this)
            
            d = seconds([1 3]);
            
            tol = DatetimeTolerance(seconds(1));
            isEqWithTol = matlab.unittest.constraints.IsEqualTo(d(1),"Within",tol);
            
            this.verifyThat(d(2),~isEqWithTol)
            
        end
        
        function natCausesFailWithDefaultOptions(this)
            
            d = seconds(1);
            tol = DatetimeTolerance(seconds(1));
            isEqWithTol = matlab.unittest.constraints.IsEqualTo(d,"Within",tol);
            
            this.verifyThat(NaT,~isEqWithTol)
            
        end
        
        function diagnosticWorksWithMultipleFailures(this)
            
            dt1 = datetime("2020-12-04 09:00:00");
            dt2 = datetime("2020-12-04 09:00:10");
            dt3 = datetime("2020-12-04 09:00:11");
            
            tol = DatetimeTolerance(seconds(1));
            diag = tol.getDiagnosticFor([dt2 dt3],dt1);
            
            expectedTxt = 'The datetimes have a difference of 00:00:10,00:00:11. The allowable tolerance is 1 sec';
            this.verifyEqual(diag.DiagnosticText,expectedTxt)
            
        end
        
    end
    
end