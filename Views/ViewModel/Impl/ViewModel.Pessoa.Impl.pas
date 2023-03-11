unit ViewModel.Pessoa.Impl;

interface

uses
  ViewModel.Pessoa,
  Controller.Pessoa,
  Controller.Cep;

type
  TPessoaViewModel = class(TInterfacedObject, IPessoaViewModel)
  private
    FPessoaController: IPessoaController;
    FCepController: ICepController;
  public
    class function New: IPessoaViewModel;
    constructor Create;
    Destructor Destroy; override;
    function PessoaController: IPessoaController;
    function CepController: ICepController;
  end;

implementation

uses
  Infra.Injection;

{ TPessoaViewModel }

function TPessoaViewModel.PessoaController: IPessoaController;
begin
  Result := FPessoaController;
end;

function TPessoaViewModel.CepController: ICepController;
begin
  Result := FCepController;
end;

constructor TPessoaViewModel.Create;
begin
  FPessoaController := Injection.ResolveInterface<IPessoaController>;
end;

destructor TPessoaViewModel.Destroy;
begin

  inherited;
end;

class function TPessoaViewModel.New: IPessoaViewModel;
begin
  Result := Self.Create;
end;

initialization
  Injection.RegisterInterface<TPessoaViewModel>(IPessoaViewModel);

finalization
  Injection.UnRegisterInterface(IPessoaViewModel);

end.
