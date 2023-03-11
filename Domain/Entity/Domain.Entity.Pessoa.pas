unit Domain.Entity.Pessoa;

interface

uses
  System.SysUtils,
  System.Classes,
  Data.DB,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,

  Infra.Common.Data;

type
  TdmPessoa = class(TDataModule)
    FQryPessoa: TFDQuery;
    FQryPessoaidpessoa: TLargeintField;
    FQryPessoaflnatureza: TSmallintField;
    FQryPessoadsdocumento: TWideStringField;
    FQryPessoanmprimeiro: TWideStringField;
    FQryPessoanmsegundo: TWideStringField;
    FQryPessoadtregistro: TDateField;
    FQryEnderecoIntegracao: TFDQuery;
    FQryEnderecoIntegracaoidendereco: TLargeintField;
    FQryEnderecoIntegracaodsuf: TWideStringField;
    FQryEnderecoIntegracaonmcidade: TWideStringField;
    FQryEnderecoIntegracaonmbairro: TWideStringField;
    FQryEnderecoIntegracaonslogradouro: TWideStringField;
    FQryEnderecoIntegracaodscomplemento: TWideStringField;
    FQryEndereco: TFDQuery;
    FQryEnderecoidendereco: TLargeintField;
    FQryEnderecoidpessoa: TLargeintField;
    FQryEnderecodscep: TWideStringField;
    FQryLote: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FData: IData;
  public
    { Public declarations }
  end;

var
  dmPessoa: TdmPessoa;

implementation

uses
  Infra.Injection;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmPessoa.DataModuleCreate(Sender: TObject);
var
  LFor: Integer;
begin
  FData := Injection.ResolveInterface<IData>;

  for LFor := 0 to Self.ComponentCount -1 do
  begin
    if Self.Components[LFor] is TFDQuery then
    begin
      (Self.Components[LFor] as TFDQuery).Connection := FData.Connection;
    end;
  end;

end;

end.
