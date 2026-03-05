classdef tIsMemberOfSet < matlab.unittest.TestCase
    
    properties (TestParameter)
        ShouldPass = constraints.tIsMemberOfSet.testParamsThatShouldPass
        ShouldFail = constraints.tIsMemberOfSet.testParamsThatShouldFail
    end
    
    methods (Test)
        
        function setsThatshouldPass(this,ShouldPass)
            
            isInSet = IsMemberOfSet(ShouldPass.Set);
            this.verifyThat(ShouldPass.Element,isInSet)
            
        end
        
        function setsThatshouldFail(this,ShouldFail)
            
            isInSet = IsMemberOfSet(ShouldFail.Set);
            this.verifyThat(ShouldFail.Element,~isInSet)
            
        end
        
    end
    
    methods (Static,Access = private)
        
        function p = testParamsThatShouldPass()
            
            p.Double.Set = 1:5;
            p.Double.Element = 3;
            
            p.String.Set = ["Hello" "World" "Foo" "Bah"];
            p.String.Element = "Foo";
            
            p.Cellstr.Set = {'Hello' 'World' 'Foo' 'Bah'};
            p.Cellstr.Element = {'Bah'};
            
        end
        
        function p = testParamsThatShouldFail()
            
            p.Double.Set = 1:5;
            p.Double.Element = 6;
            
            p.String.Set = ["Hello" "World" "Foo" "Bah"];
            p.String.Element = "Foobah";
            
            p.Cellstr.Set = {'Hello' 'World' 'Foo' 'Bah'};
            p.Cellstr.Element = {'Foobah'};
            
        end
        
    end
    
end