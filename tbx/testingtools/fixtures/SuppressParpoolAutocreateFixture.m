classdef SuppressParpoolAutocreateFixture < matlab.unittest.fixtures.Fixture
    
    methods
        
        function setup(fixture)
            
            delete(gcp("nocreate"))
            
            ps = parallel.Settings();
            if ps.Pool.AutoCreate
                ps.Pool.AutoCreate = false;
                fixture.addTeardown(@(tf) set(ps.Pool,'AutoCreate',tf),true)
            end
            
        end
        
    end
    
end