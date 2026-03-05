classdef DummyEventClass < handle
    
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