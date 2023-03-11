unit Infra.Common.Data;

interface


uses
  DB,
  Forms,
  Classes,
  IniFiles,
  SysUtils,
  Generics.Collections,

   //
  FireDAC.UI.Intf,
  FireDAC.VCLUI.Wait,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.Intf,
  FireDAC.Phys.PG,
  FireDAC.Phys.PGDef,
  FireDAC.Comp.UI,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet,
  FireDAC.DatS,
  FireDAC.DApt.Intf;

type
  IData = interface
  ['{1109BADF-7461-4B87-951A-834FCA7CA4FB}']
    function Connection: TFDConnection;
  end;

  TData = class(TInterfacedObject, IData)
  private
    FDConnection: TFDConnection;
    FDPhysPgDriverLink: TFDPhysPgDriverLink;
  public
    { Public declarations }
    constructor Create;
    destructor Destroy; override;
    class function New: IData;
    function Connection: TFDConnection;
  end;

implementation

uses
  Infra.Injection;

{ TData }

function TData.Connection: TFDConnection;
begin
  if not Assigned(FDConnection) then
    raise Exception.Create('Sistema não conectado na base de dados.');
  Result := FDConnection;
end;

constructor TData.Create;
begin

  FDConnection := TFDConnection.Create(nil);
  FDConnection.DriverName := 'PG';
  FDConnection.Params.DriverID := 'PG';
  FDConnection.Params.Database := 'cadastro';
  FDConnection.Params.UserName := 'postgres';
  FDConnection.Params.Password := 'Postgres2022!';
  FDConnection.Params.Values['Server'] := '127.0.0.1';

  FDPhysPgDriverLink := TFDPhysPgDriverLink.Create(nil);
  FDPhysPgDriverLink.VendorLib := 'C:\Program Files (x86)\PostgreSQL\psqlODBC\bin\libpq.dll';

end;

destructor TData.Destroy;
begin
  if Assigned(FDConnection) then
  begin
    FDConnection.Connected := False;
    FDConnection.Free;
  end;

  if Assigned(FDPhysPgDriverLink) then
  begin
    FDPhysPgDriverLink.Free;
  end;

  inherited;
end;

class function TData.New: IData;
begin
  Result := Self.Create;
end;

initialization
  Injection.RegisterInterface<TData>(IData);

finalization
  Injection.UnRegisterInterface(IData);

end.
