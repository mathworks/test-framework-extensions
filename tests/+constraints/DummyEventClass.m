classdef DummyEventClass < handle
    
    events (NotifyAccess = private)
        TestEvent
        TestEvent2
    end
    
    methods
        
        function triggerTestEvent(this)
            
            this.notify("TestEvent")
            
        end
        
        function triggerTestEventAgain(this)
            
            this.notify("TestEvent")
            
        end
        
    end
    
end