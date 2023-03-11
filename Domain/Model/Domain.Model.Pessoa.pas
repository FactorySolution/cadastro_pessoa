unit Domain.Model.Pessoa;

interface

uses
  Data.DB;

type
  IPessoaModel = interface
  ['{61DBE47C-F6FF-4296-8134-0D2C023E4861}']
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

end.
