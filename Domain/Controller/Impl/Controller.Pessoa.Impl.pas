unit Controller.Pessoa.Impl;

interface

uses
  Data.DB,
  Controller.Pessoa,
  Domain.Model.Pessoa;

type
  TPessoaController = class(TInterfacedObject, IPessoaController)
  private
    FPessoaModel: IPessoaModel;
  public
    constructor Create;
    class function New: IPessoaController;
    destructor Destroy; override;

    function Pessoa: TDataSet;
    function Endereco: TDataSet;
    function EnderecoIntegracao: TDataSet;

    procedure Insert;
    procedure Open(const AID: Integer);
    procedure Edit;
    procedure Delete;
    procedure Append;
    function InsertLote(const AFileName: string): Boolean;
  end;

implementation

uses
  Infra.Injection;

{ TPessoaController }

procedure TPessoaController.Append;
begin
  FPessoaModel.Append;
end;

constructor TPessoaController.Create;
begin
  FPessoaModel := Injection.ResolveInterface<IPessoaModel>;
end;

procedure TPessoaController.Delete;
begin
  FPessoaModel.Delete;
end;

destructor TPessoaController.Destroy;
begin

  inherited;
end;


procedure TPessoaController.Edit;
begin
  FPessoaModel.Edit;
end;

function TPessoaController.Endereco: TDataSet;
begin
  Result := FPessoaModel.Endereco;
end;

function TPessoaController.EnderecoIntegracao: TDataSet;
begin
  Result := FPessoaModel.EnderecoIntegracao;
end;

procedure TPessoaController.Insert;
begin
  FPessoaModel.Insert;
end;

function TPessoaController.InsertLote(const AFileName: string): Boolean;
begin
  Result := FPessoaModel.InsertLote(AFileName);
end;

class function TPessoaController.New: IPessoaController;
begin
  Result := Self.Create;
end;

procedure TPessoaController.Open(const AID: Integer);
begin
  FPessoaModel.Open(AID);
end;

function TPessoaController.Pessoa: TDataSet;
begin
  Result := FPessoaModel.Pessoa;
end;

initialization
  Injection.RegisterInterface<TPessoaController>(IPessoaController);

finalization
  Injection.UnRegisterInterface(IPessoaController);

end.
