function plan = buildfile()
%buildfile Test Framework Extensions buildfile

% Copyright 2026 The MathWorks, Inc.

import matlab.buildtool.*
import matlab.buildtool.tasks.*

plan = buildplan;

% Folders of interest
prj = plan.RootFolder;
tbx = fullfile( prj, "tbx" );
api = fullfile( tbx, tbxname() );
doc = fullfile( tbx, tbxname() + "doc" );
test = fullfile( prj, "tests" );

% Clean task
plan("clean") = CleanTask;

% Check task group
plan("check:code") = CodeIssuesTask( prj, ...
    Configuration="factory", ...
    IncludeSubfolders=true, ...
    WarningThreshold=0 );

plan("check:project") = Task( ...
    Description="Run MATLAB project checks", ...
    Actions=@checkProject, ...
    Inputs=api );

% Test task
plan("test") = TestTask( test, ...
    SourceFiles=tbx, ...
    Strict=true, ...
    Dependencies="check" );

% Documentation task
plan("doc") = Task( ...
    Description="Generate documentation", ...
    Actions=@buildDoc, ...
    Inputs=doc, ...
    Outputs=[ ...
        fullfile( doc, "**", "*.html" ), fullfile( doc, "*.xml" ), ...
        fullfile( doc, "resources" ), fullfile( doc, "helpsearch-v*" )] );

% Package task
plan("package") = Task( ...
    Description="Package toolbox", ...
    Actions=@packageToolbox, ...
    Inputs=tbx, ...
    Outputs="releases/*.mltbx", ...
    Dependencies=["test" "doc"] );

% Default task
plan.DefaultTasks = "package";

end % buildfile

function n = tbxname()
%tbxname  Toolbox name

n = "testframeworkextensions";

end % tbxname

function checkProject(~)
% Run MATLAB project checks

p = currentProject();
p.updateDependencies();
t = table( p.runChecks() );
ok = t.Passed;
if any( ~ok )
    disp( t(~ok,:) )
    error( "build:check", "Project check(s) failed." )
else
    fprintf( 1, "** Project checks passed\n" )
end

end % checkProject

function buildDoc(context)
% Generate documentation

% Documentation folder
doc = context.Task.Inputs.paths;

% Convert Markdown to HTML
md = fullfile( doc, "**", "*.md" );
html = docconvert( md, Theme="light" );
fprintf( 1, "** Converted Markdown doc to HTML\n" )

% Run code and insert output
docrun( html, Theme="light", FigureSize=[600 400] )
fprintf( 1, "** Inserted MATLAB output into doc\n" )

% Index documentation
docindex( doc )
fprintf( 1, "** Indexed doc\n" )

end % buildDoc

function packageToolbox(context)
% Package toolbox

n = tbxname();

% Load and tweak metadata
s = jsondecode( fileread( n + ".json" ) );
v = ver( n ); % from Contents.m
assert( isscalar( v ), "build:package", ...
    "Found %d instances of %s on the MATLAB path.", numel( v ), n )
s.ToolboxName = v.Name;
s.ToolboxVersion = v.Version;

if getenv( "GITHUB_ACTIONS" ) == "true"
    % Check version and tag compatibility for release
    ref = string( getenv( "GITHUB_REF" ) );
    gitTagNumber = extractAfter( ref, "refs/tags/v" );
    assert( v.Version == gitTagNumber, ...
        "build:package:VersionTagMismatch", ...
        "%s Toolbox version %s (from Contents.m) does not " + ...
        "match the current Git tag number (%s).", ...
        v.Name, v.Version, gitTagNumber )
    % Define stable name for GitHub
    stableName = erase( v.Name, " " ) + ".mltbx";
    s.OutputFile = fullfile( "releases", stableName );
else
    % Include version in toolbox file name
    s.OutputFile = fullfile( ...
        "releases", v.Name + " " + v.Version + ".mltbx" );
end % if

% Create options object
f = s.ToolboxFolder; % mandatory
id = s.Identifier; % mandatory
s = rmfield( s, ["Identifier", "ToolboxFolder"] ); % mandatory
pv = [fieldnames( s ), struct2cell( s )]'; % optional
o = matlab.addons.toolbox.ToolboxOptions( f, id, pv{:} );
o.ToolboxVersion = string( o.ToolboxVersion ); % g3079185

% Remove markdown
md = endsWith( o.ToolboxFiles, ".md" );
o.ToolboxFiles(md) = [];

% Package
matlab.addons.toolbox.packageToolbox( o )
fprintf( 1, "[+] %s\n", o.OutputFile );

% Add license
lic = fileread( fullfile( context.Plan.RootFolder, "LICENSE.txt" ) );
mlAddonSetLicense( char( o.OutputFile ), struct( "type", 'BSD', "text", lic ) );

end % packageToolbox
