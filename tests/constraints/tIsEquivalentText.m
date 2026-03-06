classdef tIsEquivalentText < matlab.unittest.TestCase

    methods (Test)

        function tIdenticalStrings(testCase)

            expVal = ["foo", "bar"];
            actVal = ["foo", "bar"];
            testCase.verifyThat(actVal, IsEquivalentText(expVal))

        end

        function tDifferentStrings(testCase)

            expVal = ["foo", "bar"];
            actVal = ["foo", "baz"];
            testCase.verifyThat(actVal, ~IsEquivalentText(expVal))

        end

        function tOrientationIgnored(testCase)

            expVal = ["foo", "bar"];
            actVal = ["foo"; "bar"]; % column vector
            testCase.verifyThat(actVal, IsEquivalentText(expVal))

        end

        function tCellstrInput(testCase)

            expVal = ["foo", "bar"];
            actVal = {'foo', 'bar'}; % cellstr
            testCase.verifyThat(actVal, IsEquivalentText(expVal))

        end

        function tCharArrayInput(testCase)

            expVal = ["foo", "bar"];
            actVal = char('foo', 'bar'); % 2x3 char array
            testCase.verifyThat(actVal, IsEquivalentText(expVal))

        end

        function tSizeMismatch(testCase)

            expVal = ["foo", "bar"];
            actVal = ["foo", "bar", "baz"];
            testCase.verifyThat(actVal, ~IsEquivalentText(expVal))

        end

        function tOrderMatters(testCase)

            expVal = ["foo", "bar"];
            actVal = ["bar", "foo"];
            testCase.verifyThat(actVal, ~IsEquivalentText(expVal))

        end

        function tNegatedConstraintPasses(testCase)

            expVal = ["foo", "bar"];
            actVal = ["baz", "qux"];
            testCase.verifyThat(actVal, ~IsEquivalentText(expVal))

        end       

    end

end