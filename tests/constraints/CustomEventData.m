classdef CustomEventData < event.EventData

    properties
        Value
    end

    methods

        function obj = CustomEventData(val)

            obj.Value = val;

        end

    end

end