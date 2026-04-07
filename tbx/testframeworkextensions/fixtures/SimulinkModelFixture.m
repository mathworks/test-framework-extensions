classdef SimulinkModelFixture < matlab.unittest.fixtures.Fixture

    % Copyright 2026 The MathWorks, Inc.

    properties (SetAccess = private)
        ModelName (1,1) string
    end

    methods

        function this = SimulinkModelFixture(modelName)

            this.ModelName = modelName;

        end

        function setup(this)

            if ~bdIsLoaded(this.ModelName)
                load_system(this.ModelName)
                this.addTeardown(@close_system,this.ModelName)
            end

        end

    end

    methods (Access = protected)

        function tf = isCompatible(this,that)

            tf = this.ModelName == that.ModelName;

        end
        
    end

end