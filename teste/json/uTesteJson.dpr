program uTesteJson;

uses
  TestFramework,
  GUITestRunner,
  uTestJson in 'uTestJson.pas',
  uJSON in '..\..\uJSON.pas';

{$R *.res}

begin
 TGUITestRunner.runRegisteredTests;
end.
