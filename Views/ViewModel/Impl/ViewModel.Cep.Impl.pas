unit ViewModel.Cep.Impl;

interface

uses
  Domain.Entity.Cep,
  Api.Cep,
  ViewModel.Cep;

type
  TCepViewModel = class(TInterfacedObject, ICepViewModel)
  private
    FApiCep: ICepApi<TCep>;
  public
    class function New: ICepViewModel;
    constructor Create;
    destructor Destroy; override;
    function Consultar(const ACep: string): TCep;
  end;

implementation

uses
  Infra.Injection,
  Api.Cep.Impl;

{ TCepViewModel }

function TCepViewModel.Consultar(const ACep: string): TCep;
begin
  Result := FApiCep.Consultar(ACep);
end;

constructor TCepViewModel.Create;
begin
  FApiCep := TCepApi<TCep>.New;
end;

destructor TCepViewModel.Destroy;
begin

  inherited;
end;

class function TCepViewModel.New: ICepViewModel;
begin
  Result := Self.Create;
end;

initialization
  Injection.RegisterInterface<TCepViewModel>(ICepViewModel);

finalization
  Injection.UnRegisterInterface(ICepViewModel);

end.
