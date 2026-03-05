classdef tSuppressParpoolAutocreateFixture < matlab.unittest.TestCase

    methods( Test )

        function tDisablesAutoCreate(testCase)
            
            % Get the parallel settings
            ps = parallel.Settings();
                        
            % Ensure it's true for testing purposes
            ps.Pool.AutoCreate = true;
            
            % Apply the fixture
            fixture = SuppressParpoolAutocreateFixture();
            testCase.applyFixture(fixture);
            
            % Check that AutoCreate is now false
            testCase.verifyFalse(ps.Pool.AutoCreate, ...
                'AutoCreate should be false after applying the fixture.')

        end
        
        function tRestoresAutoCreate(testCase)

            % Get the parallel settings
            ps = parallel.Settings();
            originalAutoCreate = ps.Pool.AutoCreate;
            
            % Set to true for this test
            ps.Pool.AutoCreate = true;
            
            % Apply the fixture
            fixture = SuppressParpoolAutocreateFixture();
            testCase.applyFixture(fixture);
            
            % Simulate test end (teardown)
            fixture.teardown()
            
            % Check that AutoCreate is restored
            testCase.verifyEqual(ps.Pool.AutoCreate, originalAutoCreate, ...
                'AutoCreate should be restored after fixture teardown.')

        end

    end

end