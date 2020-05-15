function res = runTestWithCoverage(metClass,targetClass)
    
    suite = matlab.unittest.TestSuite.fromClass(metClass);
    
    runner = matlab.unittest.TestRunner.withTextOutput();
    
    plugin = matlab.unittest.plugins.CodeCoveragePlugin.forFile(targetClass);
    runner.addPlugin(plugin);
    
    res = runner.run(suite);
    
end