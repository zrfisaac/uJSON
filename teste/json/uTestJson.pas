(******************************************************************************
  Autor : José Fábio Nascimento de Almeida
  e-mail : fabio@interativasoft.com.br ; fabiorecife@yahoo.com.br
  data criação: 21/12/2005
  Responsabilidade : Testar as classes de uJSON
  Arquivo : uJSON.pas
*******************************************************************************)

unit uTestJSON;

interface
uses TestFramework;
Type
  TTestJSONObject = class (TTestCase)
   published
    procedure testCreateString;
    procedure testCreate;
    procedure testCreateTStringList;
    procedure testCreateJSONObject_ArrayOfString;
    procedure testAccumulate;
    procedure testAssignTo;
    procedure testClean;
    procedure testNames ;
    procedure testOptInt ;
    procedure testUnicodCaracters;
  end;

implementation

uses uJSON, SysUtils, Classes;

{ TTestJSONObject }

procedure TTestJSONObject.testAccumulate;
var
  json : TJSONObject;
  jarray : TJSONArray;
  i : integer;
begin
  try
  json := TJSONObject.create ();
  try
   // primeiro valor
    json.accumulate('array',_Integer.create(0));
    Check(json.opt('array')<> nil,'accumulate não funcionou');
    CheckEquals(0,json.optInt('array'),'valor errado');
   //segundo valor
    json.accumulate('array',_Integer.create(1));
    CheckEquals(2,json.optJSONArray ('array').length,'quantidade errado');
    jarray := json.optJSONArray ('array');
    i := jarray.getInt(0);
    CheckEquals(0,i,'quantidade errado');
    CheckEquals(1,json.optJSONArray ('array').getInt(1),'valor errado');
  finally
   json.free;
  end;
  except
    on e: exception do begin
      Fail('Create '#10#13+e.Message);
    end;
  end;
end;

procedure TTestJSONObject.testAssignTo;
var
  json, jo : TJSONObject;
begin
  try
    try
      jo := TJSONObject.create ('{exemplo:"valor", inteiro:1}');
      json := TJSONObject.create;
      jo.assignTo(json);
      CheckEquals(1,json.getInt('inteiro'));
    except
      on e: exception do begin
        Fail('assignTo '#10#13+e.Message);
      end;
    end;
  finally
   if (Assigned (json)) then json.free;
   if (Assigned(jo)) then jo.free
  end;
end;

procedure TTestJSONObject.testClean;
var
  json : TJSONObject;
begin
  try
    try
       json := TJSONObject.create ('{exemplo:[1,2,3]}');
       checkTrue (json.opt('exemplo') <> nil);
       checkEquals (3,json.getJSONArray('exemplo').length);
       json.clean;
       checkTrue (json.opt('exemplo') = nil);
    except
      on e: exception do begin
        Fail('testClean '#10#13+e.Message);
      end;
    end;
  finally
   if Assigned(json) then json.free;
  end;
end;

procedure TTestJSONObject.testCreate;
var
  json : TJSONObject;
begin
  try
    try
       json := TJSONObject.create ();
       CheckTrue(json<>nil);
    except
      on e: exception do begin
        Fail('Create '#10#13+e.Message);
      end;
    end;
  finally
   if Assigned(json) then json.free;
  end;
end;

procedure TTestJSONObject.testCreateJSONObject_ArrayOfString;
var
  json, jo : TJSONObject;
begin
  try
    jo := TJSONObject.create ('{exemplo:"valor", inteiro:1}');
    json := TJSONObject.create (jo,['exemplo']);
  try
    CheckTrue(json.opt('exemplo')<>nil);
    CheckTrue(json.opt('inteiro')=nil);
  finally
   json.free;
   jo.free;
  end;
  except
    on e: exception do begin
     fail ('Create ( TJSONObject, Array of String ...'+#10#13+e.Message);
    end;
  end;
end;

procedure TTestJSONObject.testCreateString;
var
  json : TJSONObject;
begin
  try
  json := TJSONObject.create ('{exemplo:"valor", inteiro:1}');
  try
     CheckTrue(json.opt('exemplo')<>nil);
  finally
   json.free;
  end;
  except
    on e: exception do begin
     fail ('Create ( String ...'+#10#13+e.Message);
    end;
  end;
end;



procedure TTestJSONObject.testCreateTStringList;
var
  json : TJSONObject;
  s : TStringList;
begin
  try
  s := TStringlist.create;
  s.AddObject('exemplo',_String.create('valor'));
  s.AddObject('inteiro',_Integer.create(1));
  json := TJSONObject.create (s);
  try
     CheckEquals('valor',json.getString('exemplo'));
     CheckEquals(1,json.getInt('inteiro'));
  finally
   json.free;
   s.free;
  end;
  except
    on e: exception do begin
      fail ('Create (map...'+#10#13+e.Message);
    end;
  end;
end;



procedure TTestJSONObject.testNames;
var
  json : TJSONObject;
  a : TJSONArray;
begin
  try
    try
       json := TJSONObject.create ('{exemplo:"valor", inteiro:1}');
       a := json.names;
       checkEquals (2, a.length);
    except
      on e: exception do begin
        Fail('Create '#10#13+e.Message);
      end;
    end;
  finally
   if Assigned(json) then json.free;
   if Assigned (a) then a.free;
  end;
end;



procedure TTestJSONObject.testOptInt;
var
  json : TJSONObject;
begin
  try
    try
       json := TJSONObject.create ('{exemplo:"valor", inteiro:"1"}');
       CheckEquals(1,json.optInt ('inteiro'));
    except
      on e: exception do begin
        Fail('Create '#10#13+e.Message);
      end;
    end;
  finally
   if Assigned(json) then json.free;
  end;
end;

procedure TTestJSONObject.testUnicodCaracters;
var
  json : TJSONObject;
begin
  json := TJSONObject.create ('{exemplo:"\u0046\u0041\u0042\u0049\u004F"}');
  checkEquals('FABIO',json.getString('exemplo'));
end;

initialization
  RegisterTest('JSON', TTestJSONObject.Suite);


end.
