unit Api.Cep.Impl;

interface

uses
  Api.Cep,
  REST.Client;

type
  TCepApi<T: class, constructor> = class(TInterfacedObject, ICepApi<T>)
  const
    cBaseUrl = 'https://viacep.com.br/ws/%s/json/';
  private
    FRESTClient: TRESTClient;
    FRESTRequest: TRESTRequest;
    FRESTResponse: TRESTResponse;
    function CreateInstance<T>: T;
  public
    class function New: ICepApi<T>;
    constructor Create;
    destructor Destroy; override;
    function Consultar(const ACep: string): T;
  end;

implementation

uses
 Infra.Injection,
 System.SysUtils,
 REST.Types,
 REST.HttpClient,
 REST.Json, System.Rtti;



{ TCepApi }

function TCepApi<T>.Consultar(const ACep: string): T;
begin
  try
    FRESTClient.BaseURL := Format(cBaseUrl, [ACep]);
    FRESTRequest.Method := rmGET;
    FRESTRequest.Execute;
    Result := TJson.JsonToObject<T>(FRESTRequest.Response.JSONText);
  except
    on E: EHTTPProtocolException do
    begin
      Result := CreateInstance<T>;
      raise Exception.Create('Não foi possivel se comunicar com o servidor!');
    end;
  end;
end;

constructor TCepApi<T>.Create;
begin
  FRESTClient    := TRESTClient.Create(nil);
  FRESTRequest   := TRESTRequest.Create(nil);
  FRESTResponse  := TRESTResponse.Create(nil);

  FRESTRequest.Client   := FRESTClient;
  FRESTRequest.Response := FRESTResponse;
end;

function TCepApi<T>.CreateInstance<T>: T;
var
  AValue: TValue;
  ctx: TRttiContext;
  rType: TRttiType;
  AMethCreate: TRttiMethod;
  instanceType: TRttiInstanceType;
begin
  ctx := TRttiContext.Create;
  rType := ctx.GetType(TypeInfo(T));
  for AMethCreate in rType.GetMethods do
  begin
    if (AMethCreate.IsConstructor) and (Length(AMethCreate.GetParameters) = 0) then
    begin
      instanceType := rType.AsInstance;

      AValue := AMethCreate.Invoke(instanceType.MetaclassType, []);

      Result := AValue.AsType<T>;

      Exit;
    end;
  end;
end;

destructor TCepApi<T>.Destroy;
begin
  FRESTClient.Free;
  FRESTRequest.Free;
  FRESTResponse.Free;
  inherited;
end;

class function TCepApi<T>.New: ICepApi<T>;
begin
  Result := Self.Create;
end;

end.
