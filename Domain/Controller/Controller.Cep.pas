unit Controller.Cep;

interface

uses
  Domain.Entity.Cep;

type
  ICepController = interface
  ['{4D08342B-E4B1-45D8-A067-49446C3AF39A}']
    function Consultar(const ACep: string): TCep;
  end;

implementation

end.
