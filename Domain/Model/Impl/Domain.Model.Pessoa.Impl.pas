unit Domain.Model.Pessoa.Impl;

interface

uses
  Data.DB,
  Infra.Common.Data,
  Domain.Entity.Pessoa,
  Domain.Model.Pessoa;

type
  TPessoaModel = class(TInterfacedObject, IPessoaModel)
  private
    FDmPessoa: TdmPessoa;
    FData: IData;
  public
    class function New: IPessoaModel;
    constructor Create;
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
  Infra.Injection,
  System.SysUtils, System.Classes;


{ TPessoaModel }

procedure TPessoaModel.Insert;
begin
  FData.Connection.StartTransaction;
  try
    FDmPessoa.FQryPessoa.FieldByName('dtregistro').AsDateTime := Date;

    FDmPessoa.FQryPessoa.Post;
    FDmPessoa.FQryPessoa.ApplyUpdates;

    FDmPessoa.FQryEndereco.FieldByName('idpessoa').AsInteger :=
      FDmPessoa.FQryPessoa.FieldByName('idpessoa').AsInteger;

    FDmPessoa.FQryEndereco.Post;
    FDmPessoa.FQryEndereco.ApplyUpdates;

    if not (FDmPessoa.FQryEnderecoIntegracao.State in [dsEdit, dsInsert]) then
      FDmPessoa.FQryEnderecoIntegracao.Edit;

    FDmPessoa.FQryEnderecoIntegracao.FieldByName('idendereco').AsInteger :=
      FDmPessoa.FQryEndereco.FieldByName('idendereco').AsInteger;

    FDmPessoa.FQryEnderecoIntegracao.Post;
    FDmPessoa.FQryEnderecoIntegracao.ApplyUpdates;

    FData.Connection.Commit;
  except
    FData.Connection.Rollback;
  end;
end;

function TPessoaModel.InsertLote(const AFileName: string): boolean;
var
  LArquivo: TStringList;
  LLinha: TStringList;
  LFor: Integer;
begin
  LArquivo := TStringList.Create;
  LLinha   := TStringList.Create;
  Result   := True;
  try
    LArquivo.LoadFromFile(AFileName);

    FDmPessoa.FQryLote.Params.ArraySize := LArquivo.Count;

    for LFor := 0 to Pred(LArquivo.Count) do
    begin
      LLinha.Delimiter := ';';
      LLinha.DelimitedText := LArquivo[LFor];

      FDmPessoa.FQryLote.ParamByName('flnatureza').asIntegers[LFor]  := LLinha[0].ToInteger;
      FDmPessoa.FQryLote.ParamByName('dsdocumento').asStrings[LFor]  := LLinha[1];
      FDmPessoa.FQryLote.ParamByName('nmprimeiro').asStrings[LFor]   := LLinha[2];
      FDmPessoa.FQryLote.ParamByName('nmsegundo').asStrings[LFor]    := LLinha[3];
      FDmPessoa.FQryLote.ParamByName('dtregistro').asDateTimes[LFor] := Date;
    end;

    FData.Connection.StartTransaction;
    try
      FDmPessoa.FQryLote.Execute(LArquivo.Count,0);
      FData.Connection.Commit;
    except
      Result := False;
      FData.Connection.Rollback;
    end;
  finally
    LArquivo.Free;
    LLinha.Free;
  end;

end;

class function TPessoaModel.New: IPessoaModel;
begin
  Result := Self.Create;
end;

procedure TPessoaModel.Append;
begin
  FDmPessoa.FQryPessoa.Insert;
end;

constructor TPessoaModel.Create;
begin
  FDmPessoa := TdmPessoa.Create(nil);
  FData := Injection.ResolveInterface<IData>;
end;

procedure TPessoaModel.Delete;
begin
  FData.Connection.StartTransaction;
  try
    if FDmPessoa.FQryEndereco.RecordCount > 0 then
    begin
      FDmPessoa.FQryEndereco.Delete;
      FDmPessoa.FQryEndereco.ApplyUpdates;
    end;
    if FDmPessoa.FQryEnderecoIntegracao.RecordCount > 0 then
    begin
      FDmPessoa.FQryEnderecoIntegracao.Delete;
      FDmPessoa.FQryEnderecoIntegracao.ApplyUpdates;
    end;

    FDmPessoa.FQryPessoa.Delete;
    FDmPessoa.FQryPessoa.ApplyUpdates;
    FData.Connection.Commit;

  except
    FData.Connection.Rollback;
  end;
end;

destructor TPessoaModel.Destroy;
begin
  FDmPessoa.Free;
  inherited;
end;

procedure TPessoaModel.Edit;
begin
  FData.Connection.StartTransaction;
  try
    if FDmPessoa.FQryPessoa.State in [dsEdit, dsInsert] then
      FDmPessoa.FQryPessoa.Post;

    if FDmPessoa.FQryEndereco.State in [dsEdit, dsInsert] then
    begin
      if FDmPessoa.FQryEndereco.FieldByName('idpessoa').AsInteger <= 0 then
        FDmPessoa.FQryEndereco.FieldByName('idpessoa').AsInteger :=
          FDmPessoa.FQryPessoa.FieldByName('idpessoa').AsInteger;

      FDmPessoa.FQryEndereco.Post;
    end;

    if FDmPessoa.FQryEnderecoIntegracao.State in [dsEdit, dsInsert] then
      FDmPessoa.FQryEnderecoIntegracao.Post;

    if FDmPessoa.FQryPessoa.ChangeCount > 0 then
      FDmPessoa.FQryPessoa.ApplyUpdates;

    if FDmPessoa.FQryEndereco.ChangeCount > 0 then
      FDmPessoa.FQryEndereco.ApplyUpdates;

    if FDmPessoa.FQryEnderecoIntegracao.ChangeCount > 0 then
    begin
      if FDmPessoa.FQryEnderecoIntegracao.FieldByName('idendereco').AsInteger <= 0 then
      begin
        FDmPessoa.FQryEnderecoIntegracao.Edit;

        FDmPessoa.FQryEnderecoIntegracao.FieldByName('idendereco').AsInteger :=
          FDmPessoa.FQryEndereco.FieldByName('idendereco').AsInteger;
        FDmPessoa.FQryEnderecoIntegracao.Post;
      end;

      FDmPessoa.FQryEnderecoIntegracao.ApplyUpdates;
    end;


    FData.Connection.Commit;
  except
    FData.Connection.Rollback;
  end;
end;

function TPessoaModel.Endereco: TDataSet;
begin
  Result := FDmPessoa.FQryEndereco;
end;

function TPessoaModel.EnderecoIntegracao: TDataSet;
begin
  Result := FDmPessoa.FQryEnderecoIntegracao;
end;

function TPessoaModel.Pessoa: TDataSet;
begin
  Result := FDmPessoa.FQryPessoa;
end;

procedure TPessoaModel.Open(const AID: Integer);
begin
  if AID > 0 then
  begin
    FDmPessoa.FQryPessoa.MacroByName('where').AsRaw := Format('where idpessoa = %d', [AID]);
    FDmPessoa.FQryPessoa.Open;
    FDmPessoa.FQryEndereco.MacroByName('where').AsRaw := Format('where idpessoa = %d', [AID]);
    FDmPessoa.FQryEndereco.Open;
    if FDmPessoa.FQryEndereco.RecordCount > 0 then
    begin
      FDmPessoa.FQryEnderecoIntegracao.MacroByName('where').AsRaw :=
        Format('where idendereco = %d', [FDmPessoa.FQryEndereco.FieldByName('idendereco').AsInteger]);
      FDmPessoa.FQryEnderecoIntegracao.Open;
    end;
  end
  else
  begin
    FDmPessoa.FQryPessoa.MacroByName('where').AsRaw := 'where 1=-1';
    FDmPessoa.FQryEndereco.MacroByName('where').AsRaw := 'where 1=-1';
    FDmPessoa.FQryEnderecoIntegracao.MacroByName('where').AsRaw := 'where 1=-1';

    FDmPessoa.FQryPessoa.Open;
    FDmPessoa.FQryEndereco.Open;
    FDmPessoa.FQryEnderecoIntegracao.Open;
  end;
end;

initialization
  Injection.RegisterInterface<TPessoaModel>(IPessoaModel);

finalization
  Injection.UnRegisterInterface(IPessoaModel);

end.
