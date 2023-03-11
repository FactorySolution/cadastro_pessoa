unit ViewForm.Main;

interface

type
  IViewFormMain = interface
  ['{5AA828CB-9313-4A52-AC39-A0B17896A0D2}']
    procedure Insert;
    procedure Open(const AID: string);
    procedure Edit;
    procedure Delete;
    procedure PesquisaCep;

    function InsertLote(const AFileName: string): Boolean;

    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  end;

implementation

end.
