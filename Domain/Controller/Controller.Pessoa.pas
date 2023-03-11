unit Controller.Pessoa;

interface

uses
  Data.DB;

type
  IPessoaController = interface
  ['{F33340EF-00E8-4A50-A531-31FB482BF1F6}']
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
