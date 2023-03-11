unit Domain.Entity.Cep;

interface

uses
  Rest.Json.Types;

type
  TCep = class
  private
    FBairro: string;
    FCep: string;
    FComplemento: string;
    FDdd: string;
    FGia: string;
    FIbge: string;
    FLocalidade: string;
    FLogradouro: string;
    FSiafi: string;
    FUf: string;
  published
    [JsonName('bairro')]
    property Bairro: string read FBairro write FBairro;
    [JsonName('cep')]
    property Cep: string read FCep write FCep;
    [JsonName('complemento')]
    property Complemento: string read FComplemento write FComplemento;
    [JsonName('ddd')]
    property Ddd: string read FDdd write FDdd;
    [JsonName('gia')]
    property Gia: string read FGia write FGia;
    [JsonName('ibge')]
    property Ibge: string read FIbge write FIbge;
    [JsonName('localidade')]
    property Localidade: string read FLocalidade write FLocalidade;
    [JsonName('logradouro')]
    property Logradouro: string read FLogradouro write FLogradouro;
    [JsonName('siafi')]
    property Siafi: string read FSiafi write FSiafi;
    [JsonName('uf')]
    property Uf: string read FUf write FUf;
  public
    function ToJsonString: string;
    class function FromJsonString(const AValue: string): TCep;
  end;

implementation

uses
 Rest.Json;

{ TCep }

class function TCep.FromJsonString(const AValue: string): TCep;
begin
  Result := TJson.JsonToObject<TCep>(AValue);
end;

function TCep.ToJsonString: string;
begin
  Result := TJson.ObjectToJsonString(self);
end;

end.
