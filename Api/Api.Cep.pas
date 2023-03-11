unit Api.Cep;

interface

type
  ICepApi<T> = interface
  ['{43627F68-8132-4C0C-B94C-B9CB128100A9}']
    function Consultar(const ACep: string): T;
  end;

implementation

end.
