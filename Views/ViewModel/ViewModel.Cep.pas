unit ViewModel.Cep;

interface

uses
  Domain.Entity.Cep;

type
  ICepViewModel = interface
  ['{DF3A0A18-94BE-4098-A41D-2B86EDD6FAB4}']
    function Consultar(const ACep:string): TCep;
  end;

implementation

end.
