unit ViewForm.Main.Impl;

interface

uses
  ViewModel.Cep,
  ViewForm.Main,
  ViewModel.Pessoa,
  Form.View.Main;

type
  TViewFormMain = class(TInterfacedObject, IViewFormMain)
  private
    FOwner: TFrmMain;
    FPessoaViewModel: IPessoaViewModel;
    FCepViewModel: ICepViewModel;
    procedure BindComponents;
    function DadosValidos: Boolean;
  public
    constructor Create(const AOwner: TFrmMain);
    destructor Destroy; override;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    procedure Insert;
    procedure Open(const AID: string);
    procedure Edit;
    procedure Delete;
    procedure PesquisaCep;

    function InsertLote(const AFileName: string): Boolean;
  end;

implementation

uses
  Infra.Injection,
  Controller.Pessoa,
  Domain.Entity.Cep,
  System.SysUtils,
  Data.DB,
  Vcl.Dialogs;

{ TViewFormMain }

procedure TViewFormMain.BindComponents;
begin
  FOwner.dsPessoa.DataSet := FPessoaViewModel.PessoaController.Pessoa;
  FOwner.dsEndereco.DataSet := FPessoaViewModel.PessoaController.Endereco;
  FOwner.dsEnderecoIntegracao.DataSet := FPessoaViewModel.PessoaController.EnderecoIntegracao;
end;

constructor TViewFormMain.Create(const AOwner: TFrmMain);
begin
  FOwner := AOwner;
end;

function TViewFormMain.DadosValidos: Boolean;
begin
  Result := (FOwner.dsPessoa.DataSet.FieldByName('flnatureza').AsString <> '') and
            (FOwner.dsPessoa.DataSet.FieldByName('dsdocumento').AsString <> '') and
            (FOwner.dsPessoa.DataSet.FieldByName('nmprimeiro').AsString <> '') and
            (FOwner.dsPessoa.DataSet.FieldByName('nmsegundo').AsString <> '');
end;

procedure TViewFormMain.Delete;
begin
  if not (FOwner.dsPessoa.State in [dsInactive] ) and ( FOwner.dsPessoa.DataSet.RecordCount > 0 ) then
  begin
    FPessoaViewModel.PessoaController.Delete;
  end
  else
  begin
    ShowMessage('Não há registros para deletar.');
  end;
end;

destructor TViewFormMain.Destroy;
begin

  inherited;
end;

procedure TViewFormMain.Edit;
begin
  if FOwner.dsPessoa.DataSet.FieldByName('idpessoa').AsInteger <= 0 then
  begin
    ShowMessage('Você esta no modo de edição de registro. Pesquise uma pessoa para editar');
    Exit;
  end;

  if DadosValidos then
    FPessoaViewModel.PessoaController.Edit
  else
    ShowMessage('Preencha todos os campos');
end;

procedure TViewFormMain.FormCreate(Sender: TObject);
begin
  FPessoaViewModel := Injection.ResolveInterface<IPessoaViewModel>;
  FCepViewModel    := Injection.ResolveInterface<ICepViewModel>;
  BindComponents;
  FPessoaViewModel.PessoaController.Open(0);
  FPessoaViewModel.PessoaController.Append;
end;

procedure TViewFormMain.FormDestroy(Sender: TObject);
begin

end;

procedure TViewFormMain.Insert;
begin
  if DadosValidos then
    FPessoaViewModel.PessoaController.Insert
  else
    ShowMessage('Preencha todos os campos');
end;

function TViewFormMain.InsertLote(const AFileName: string): Boolean;
begin
  Result := FPessoaViewModel.PessoaController.InsertLote(AFileName);
end;

procedure TViewFormMain.Open(const AID: string);
var
  LID: integer;
begin
  if TryStrToInt(AID, LID) then
  begin
    FPessoaViewModel.PessoaController.Open(LID);
    if FOwner.dsPessoa.DataSet.RecordCount = 0 then
      ShowMessage(format('Não encontrei dados para o ID: %s', [AID]));
  end
  else
    ShowMessage('O Id deve ser um número!')
end;

procedure TViewFormMain.PesquisaCep;
var
  LCep: TCep;
begin
  LCep := FCepViewModel.Consultar(FOwner.DBEdtCep.EditText);
  try
    if LCep.Cep <> '' then
    begin
      If FOwner.dsEnderecoIntegracao.DataSet.FieldByName('idendereco').AsInteger <= 0 then
        FOwner.dsEnderecoIntegracao.DataSet.Append
      else
        FOwner.dsEnderecoIntegracao.DataSet.Edit;

      FOwner.dsEnderecoIntegracao.DataSet.FieldByName('dsuf').AsString := LCep.Uf;
      FOwner.dsEnderecoIntegracao.DataSet.FieldByName('nmcidade').AsString := LCep.Localidade;
      FOwner.dsEnderecoIntegracao.DataSet.FieldByName('nmbairro').AsString := LCep.Bairro;
      FOwner.dsEnderecoIntegracao.DataSet.FieldByName('nslogradouro').AsString  := lCep.Logradouro;
      FOwner.dsEnderecoIntegracao.DataSet.FieldByName('dscomplemento').AsString := lCep.Complemento;
      FOwner.dsEnderecoIntegracao.DataSet.Post;
    end
    else
    begin
      ShowMessage('Não achei o cep informado na base de dados.');
      FOwner.DBEdtCep.SetFocus;
    end;
  finally
    lCep.Free;
  end;
end;

end.
