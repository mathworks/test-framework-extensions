classdef tHasStringLessThan < matlab.unittest.TestCase
    
    methods (Test)
        
        function shortScalarPasses(this)
            
            isShort = HasStringLengthLessThan(50);
            
            this.verifyThat("Hello World",isShort)
            
        end
        
        function longScalarFails(this)
            
            isShort = HasStringLengthLessThan(4);
            
            this.verifyThat("Hello World",~isShort)
            
        end
        
        function arrayOfShortStringsPass(this)
            
            isShort = HasStringLengthLessThan(50);
            
            this.verifyThat(["Hello" "World" "Foo" "Bah"],isShort)
            
        end
        
        function anyElementOfArrayThatFailsCausesOverallFailure(this)
            
            isShort = HasStringLengthLessThan(4);
            
            this.verifyThat(["Hello" "World" "Foo" "Bah"],~isShort)
            
        end
        
        function defaultStringLengthSet(this)
            
            c = HasStringLengthLessThan();
            
            this.verifyEqual(c.MaximumStringLength,namelengthmax())
            
        end
        
    end
    
end