classdef tIsEqualVector < matlab.unittest.TestCase

    methods ( Test )

        function tExactEquality(testCase)

            import matlab.unittest.constraints.IsEqualTo

            % Row vs column, should be equal
            expected = [1 2 3];
            actual = [1; 2; 3];
            testCase.verifyThat(actual, IsEqualVector(expected))

        end

        function tFailOnDifferentValues(testCase)

            expected = [1 2 3];
            actual = [1; 2; 4];
            testCase.verifyThat( actual, ~IsEqualVector(expected) )

        end

        function tAbsoluteTolerance(testCase)

            import matlab.unittest.constraints.AbsoluteTolerance
            expected = [1 2 3];
            actual = [1.01 2.01 3.01];
            tol = AbsoluteTolerance(0.02);
            testCase.verifyThat( actual, IsEqualVector( expected, AbsTol=tol) )

            % Should fail if tolerance is too small
            tol = AbsoluteTolerance(0.001);
            testCase.verifyThat(actual, ~IsEqualVector(expected, AbsTol=tol))

        end

        function tRelativeTolerance(testCase)

            import matlab.unittest.constraints.RelativeTolerance
            expected = [100 200 300];
            actual = [101 198 299];
            tol = RelativeTolerance(0.02); % 2%
            testCase.verifyThat(actual, IsEqualVector(expected, RelTol=tol));

            % Should fail if tolerance is too small
            tol = RelativeTolerance(0.001);
            testCase.verifyThat(actual, ~IsEqualVector(expected, RelTol=tol))

        end       

        function tNotAVectorErrors(testCase)
            
            actual = [1 2; 3 4];
            testCase.verifyError(@() IsEqualVector(actual), ...
                "MATLAB:validation:IncompatibleSize")

        end

    end

end