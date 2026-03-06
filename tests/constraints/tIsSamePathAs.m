classdef tIsSamePathAs < matlab.unittest.TestCase
    
    methods (Test)
        
        function equalStringsPass(this)
            
            p = "C:\Users";
            c = IsSamePathAs(p);
            
            this.verifyThat(p,c)
            
        end
        
        function charAndStringComparisonPasses(this)
            
            p = "C:\Users";
            c = IsSamePathAs(p);
            
            this.verifyThat(char(p),c)
            
        end
        
        function trailingSlashIgnored(this)
            
            p = "C:\Users";
            c = IsSamePathAs(p);
            
            this.verifyThat("C:\Users\",c)
            
        end
        
        function invariantToFolderSeparators(this)
            
            p = "C:\Users";
            c = IsSamePathAs(p);
            
            this.verifyThat("C:/Users",c)
            
        end
        
        function differentPathsFail(this)
            
            p = "C:\Users";
            c = IsSamePathAs(p);
            
            this.verifyThat("C:\Foo",~c)
            
        end
        
        function windowsIsCaseInsensitive(this)
            
            this.assumeTrue(ispc)
            
            p = "C:\Users";
            c = IsSamePathAs(p);
            
            this.verifyThat("C:\USERS",c)
            
        end
        
        function nonWindowsIsCaseSensitive(this)
            
            this.assumeFalse(ispc)
            
            p = "C:\Users";
            c = IsSamePathAs(p);
            
            this.verifyThat("C:\USERS",~c)
            
        end
        
    end
    
    methods (Test)
        
        function equalFilePathsPass(this)
            
            p = "C:\Users\file.txt";
            c = IsSamePathAs(p);
            
            this.verifyThat(p,c)
            
        end
        
        function invariantToSeparatorsInFilePath(this)
            
            p = "C:\Users\file.txt";
            c = IsSamePathAs(p);
            
            this.verifyThat("C:/Users/file.txt",c)
            
        end
        
    end
    
end