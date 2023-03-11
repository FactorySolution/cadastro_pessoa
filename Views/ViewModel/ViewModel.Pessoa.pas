unit ViewModel.Pessoa;

interface

uses
  Controller.Pessoa,
  Controller.Cep;

type
  IPessoaViewModel = interface
  ['{415C128D-7D06-4139-9582-9841E7B85EE7}']
    function PessoaController: IPessoaController;
    function CepController: ICepController;
  end;

implementation

end.
