program Cadastro;

uses
  Vcl.Forms,
  Infra.Injection in 'Infrastructure\Core\Injection\Infra.Injection.pas',
  Domain.Model.Pessoa in 'Domain\Model\Domain.Model.Pessoa.pas',
  Domain.Entity.Pessoa in 'Domain\Entity\Domain.Entity.Pessoa.pas' {dmPessoa: TDataModule},
  Infra.Common.Data in 'Infrastructure\Common\Infra.Common.Data.pas',
  Domain.Model.Pessoa.Impl in 'Domain\Model\Impl\Domain.Model.Pessoa.Impl.pas',
  ViewForm.Main in 'Views\ViewForms\ViewForm.Main.pas',
  Form.View.Main in 'Views\View\Form.View.Main.pas' {FrmMain},
  ViewForm.Main.Impl in 'Views\ViewForms\Impl\ViewForm.Main.Impl.pas',
  ViewModel.Pessoa in 'Views\ViewModel\ViewModel.Pessoa.pas',
  Controller.Pessoa in 'Domain\Controller\Controller.Pessoa.pas',
  ViewModel.Pessoa.Impl in 'Views\ViewModel\Impl\ViewModel.Pessoa.Impl.pas',
  Controller.Pessoa.Impl in 'Domain\Controller\Impl\Controller.Pessoa.Impl.pas',
  Controller.Cep in 'Domain\Controller\Controller.Cep.pas',
  Controller.Cep.Impl in 'Domain\Controller\Impl\Controller.Cep.Impl.pas',
  ViewModel.Cep in 'Views\ViewModel\ViewModel.Cep.pas',
  ViewModel.Cep.Impl in 'Views\ViewModel\Impl\ViewModel.Cep.Impl.pas',
  Api.Cep in 'Api\Api.Cep.pas',
  Api.Cep.Impl in 'Api\Cep\Impl\Api.Cep.Impl.pas',
  Domain.Entity.Cep in 'Domain\Entity\Domain.Entity.Cep.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
