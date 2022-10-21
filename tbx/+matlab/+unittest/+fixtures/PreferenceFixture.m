classdef PreferenceFixture < matlab.unittest.fixtures.Fixture
    % PreferenceFixture - override a preference or preference group, and
    % restore the original value on teardown. If the preference didn't
    % exist initially, the preference will be removed.
    
    properties (SetAccess = private)
        Group (1,1) string
        Name (1,1) string
        ValueOriginal
        ValueFixture
    end
    
    methods
        
        function this = PreferenceFixture(group,pref,value)
            
            this.Group = group;
            
            % Preference name is optional - we can work with the entire
            % pref group.
            if nargin > 1
                this.Name = pref;
            end
            
            % Optional new value to set
            if nargin > 2
                this.ValueFixture = value;
            end
            
        end
        
        function setup(this)

            % No preference name - work at the preference group level
            if this.Name == ""
                
                if ispref(this.Group)
                    
                    % Preference group exists - store its contents and
                    % restore the entire group on teardown.
                    this.ValueOriginal = getpref(this.Group);
                    this.addTeardown(@() this.restorePrefGroup)
                    
                else
                    
                    % Preference group does not exist - remove the entire
                    % group on teardown.
                    this.addTeardown(@() this.removePrefGroup)
                    
                end
               
            % Work with a preference within a group
            else
                
                if ~ispref(this.Group)
                    
                    % Preference group does not exist - remove the entire
                    % group on teardown.
                    this.addTeardown(@() this.removePrefGroup)
                    
                elseif ~ispref(this.Group,this.Name)
                    
                    % Group exists but specific preference does not. Remove
                    % the specific preference on teardown.
                    this.addTeardown(@() this.removePref)
                    
                else
                    
                    % The preference exists. Store its original value and
                    % restore on teardown.
                    this.ValueOriginal = getpref(this.Group,this.Name);
                    this.addTeardown(@setpref,this.Group,this.Name,this.ValueOriginal)
                    
                end
                
                % Set the pref value
                setpref(this.Group,this.Name,this.ValueFixture)
                
            end

        end

    end
    
    methods (Access = protected)
        
        function tf = isCompatible(fx1,fx2)
            
            c(1) = fx1.Group == fx2.Group;
            c(2) = fx1.Name == fx2.Name;
            c(3) = isequal(fx1.ValueOriginal,fx2.ValueOriginal);
            
            tf = all(c);
            
        end
        
    end
    
    methods (Access = private)
        
        function restorePrefGroup(this)
            
            fn = fieldnames(this.ValueOriginal);
            for k = 1:numel(fn)
                pn = fn{k};
                setpref(this.Group,pn,this.ValueOriginal.(pn))
            end
            
        end
        
        function removePrefGroup(this)
            
            if ispref(this.Group)
                rmpref(this.Group)
            end
            
        end
        
        function removePref(this)
            
            if ispref(this.Group,this.Name)
                rmpref(this.Group,this.Name)
            end
            
        end
        
    end
    
end