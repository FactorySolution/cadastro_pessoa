unit Controller.Cep.Impl;

interface

uses
  ViewModel.Cep,
  Controller.Cep,
  Domain.Entity.Cep;

type
  TCepController = class(TInterfacedObject, ICepController)
  private
    FCepModel: ICepViewModel;
  public
    class function New: ICepController;
    constructor Create;
    destructor Destroy; override;
    function Consultar(const ACep: string): TCep;
  end;

implementation

uses
  Infra.Injection;

{ TCepController }

function TCepController.Consultar(const ACep: string): TCep;
begin
  Result := FCepModel.Consultar(ACep);
end;

constructor TCepController.Create;
begin
  FCepModel := injection.ResolveInterface<ICepViewModel>;
end;

destructor TCepController.Destroy;
begin

  inherited;
end;

class function TCepController.New: ICepController;
begin
  Result := Self.Create;
end;

initialization
  Injection.RegisterInterface<TCepController>(ICepController);

finalization
  Injection.UnRegisterInterface(ICepController);

end.
