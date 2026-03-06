classdef DummyEventSource < handle

    events ( NotifyAccess = private )
        TestEvent
    end

    methods

        function triggerEvent(obj, eventName, eventData)

            notify(obj, eventName, eventData)

        end

    end

end