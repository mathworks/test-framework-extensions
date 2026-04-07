classdef SuppressParpoolAutocreateFixture < matlab.unittest.fixtures.Fixture

    % Copyright 2026 The MathWorks, Inc.

    properties ( SetAccess = private )
        AutoCreate(1, 1) logical = true
    end
    
    methods
        
        function setup(fixture)
            
            delete(gcp("nocreate"))
            
            ps = parallel.Settings();
            fixture.AutoCreate = ps.Pool.AutoCreate;
            if ps.Pool.AutoCreate                
                ps.Pool.AutoCreate = false;                
            end
            
        end

        function teardown(fixture)

            ps = parallel.Settings();
            ps.Pool.AutoCreate = fixture.AutoCreate;

        end
        
    end
    
end