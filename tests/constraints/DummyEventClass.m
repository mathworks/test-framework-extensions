classdef DummyEventClass < handle

    properties (SetObservable)
        P
        Q
    end
    
    events (NotifyAccess = private)
        TestEvent
        TestEvent2
    end
    
    methods
        
        function notifyTestEvent(this)
            
            this.notify("TestEvent")
            
        end
        
        function notifyTestEventAgain(this)
            
            this.notify("TestEvent")
            
        end
        
    end
    
end