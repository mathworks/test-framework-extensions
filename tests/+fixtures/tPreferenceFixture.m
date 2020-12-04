classdef tPreferenceFixture < matlab.unittest.TestCase
    
    properties (Access = private)
        Group = "MyPrefGroup"
        Name = "MyPref"
        Value = 123
    end
    
    methods (Test)
        
        function tGroupRemoved(this)
            
            this.assertFalse(ispref(this.Group))
            
            fx = matlab.unittest.fixtures.PreferenceFixture(this.Group);
            fx.setup()
            
            setpref(this.Group,this.Name,this.Value)
            
            fx.delete() % Trigger teardown
            
            this.verifyFalse(ispref(this.Group))
            
        end
        
        function tGroupRestored(this)
            
            this.assertFalse(ispref(this.Group))
            
            original = 456;
            setpref(this.Group,this.Name,original)
            this.addTeardown(@rmpref,this.Group)
            
            fx = matlab.unittest.fixtures.PreferenceFixture(this.Group);
            fx.setup()
            
            setpref(this.Group,this.Name,this.Value)
            
            fx.delete() % Trigger teardown
            
            this.verifyEqual(getpref(this.Group,this.Name),original)
            
        end
        
        function tGroupWithDifferentPrefRestored(this)
            
            this.assertFalse(ispref(this.Group))
            
            original = 456;
            otherPrefName = "Foo";
            setpref(this.Group,otherPrefName,original)
            this.addTeardown(@rmpref,this.Group)
            
            fx = matlab.unittest.fixtures.PreferenceFixture(this.Group,this.Name);
            fx.setup()
            
            this.assertTrue(ispref(this.Group,this.Name))
            this.verifyEqual(getpref(this.Group,this.Name),[])
            
            fx.delete() % Trigger teardown
            
            this.verifyEqual(getpref(this.Group,otherPrefName),original)
            
        end
        
        function tGroupCreatedWithEmptyPref(this)
            
            this.assertFalse(ispref(this.Group))
            
            fx = matlab.unittest.fixtures.PreferenceFixture(this.Group,this.Name);
            fx.setup()
            
            this.assertTrue(ispref(this.Group,this.Name))
            this.verifyEqual(getpref(this.Group,this.Name),[])
            
            fx.delete() % Trigger teardown
            
            this.verifyFalse(ispref(this.Group))
            
        end
        
        function tGroupCreatedWithPrefValue(this)
            
            this.assertFalse(ispref(this.Group))
            
            fx = matlab.unittest.fixtures.PreferenceFixture(this.Group,this.Name,this.Value);
            fx.setup()
            
            this.assertTrue(ispref(this.Group,this.Name))
            this.verifyEqual(getpref(this.Group,this.Name),this.Value)
            
            fx.delete() % Trigger teardown
            
            this.verifyFalse(ispref(this.Group))
            
        end
        
        function tGroupPrefOverridden(this)
            
            this.assertFalse(ispref(this.Group))
            
            original = 456;
            setpref(this.Group,this.Name,original)
            this.addTeardown(@rmpref,this.Group)
            
            fx = matlab.unittest.fixtures.PreferenceFixture(this.Group,this.Name,this.Value);
            fx.setup()
            
            this.assertTrue(ispref(this.Group,this.Name))
            this.verifyEqual(getpref(this.Group,this.Name),this.Value)
            
            fx.delete() % Trigger teardown
            
            this.verifyEqual(getpref(this.Group,this.Name),original)
            
        end
        
    end
    
end