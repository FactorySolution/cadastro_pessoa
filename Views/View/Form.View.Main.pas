unit Form.View.Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.Mask,
  Vcl.DBCtrls,
  Data.DB,
  Vcl.Buttons,
  Vcl.ExtCtrls,
  ViewForm.Main,
  Vcl.ExtDlgs;

type
  TFrmMain = class(TForm)
    btnCadastrar: TButton;
    btnAtualizar: TButton;
    btnDeletar: TButton;
    btnCarregar: TButton;
    dsPessoa: TDataSource;
    dsEndereco: TDataSource;
    GroupBox1: TGroupBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    GroupBox2: TGroupBox;
    DBEdtCep: TDBEdit;
    Label6: TLabel;
    dsEnderecoIntegracao: TDataSource;
    spConsultaCep: TSpeedButton;
    Panel1: TPanel;
    Panel2: TPanel;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    btnLote: TButton;
    OpenTextFileDialog: TOpenTextFileDialog;
    procedure FormCreate(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure spConsultaCepClick(Sender: TObject);
    procedure btnLoteClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    FViewForm: IViewFormMain;
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  ViewForm.Main.Impl;

{$R *.dfm}

procedure TFrmMain.btnAtualizarClick(Sender: TObject);
begin
  FViewForm.Edit;
end;

procedure TFrmMain.btnCarregarClick(Sender: TObject);
begin
  FViewForm.Open(InputBox('Informe o ID que deseja pesquisar', 'ID', '-1'));
end;

procedure TFrmMain.btnDeletarClick(Sender: TObject);
begin
  FViewForm.Delete;
end;

procedure TFrmMain.btnLoteClick(Sender: TObject);
begin
  if OpenTextFileDialog.Execute then
  begin
    FViewForm.InsertLote(OpenTextFileDialog.FileName)
  end;
end;

procedure TFrmMain.btnCadastrarClick(Sender: TObject);
begin
  FViewForm.Insert;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  FViewForm := TViewFormMain.Create(self);
  FViewForm.FormCreate(sender);
end;

procedure TFrmMain.FormDestroy(Sender: TObject);
begin
  FViewForm.FormDestroy(Sender);
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
  DBEdit3.SetFocus;
end;

procedure TFrmMain.spConsultaCepClick(Sender: TObject);
begin
  TThread.CreateAnonymousThread(
  procedure
  begin
    TThread.Synchronize(TThread.CurrentThread,
    procedure
    begin
      FViewForm.PesquisaCep;
    end);
  end
  ).Start;
end;

end.
