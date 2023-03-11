// Classe baseada no Treinamento ministrado pelo Isaque Pinheiro
unit Infra.Injection;

interface

uses
  Rtti,
  TypInfo,
  Classes,
  SysUtils,
  RTLConsts,
  Generics.Collections;

type
  TInjectionAbstract = class abstract(TInterfacedObject);

type
  TInjection = class sealed
  protected
    class var FRegisterInterfaces: TDictionary<string, TClass>;
    class var FRepository: TDictionary<string, TInjectionAbstract>;
    class var FRepositoryInterface: TDictionary<string, IInterface>;
    function MethodInvokerInternal(const AClassName, AMethodName: string): TObject;
  public
    class constructor Create;
    class destructor Destroy;
    /// <summary>
    ///   Registrar e Desregistrar Interfaces na lista
    /// </summary>
    procedure RegisterInterface<T: class>(AInterface: TGUID); overload;
    procedure RegisterInterface(AInterface: TGUID; AClass: TClass); overload;
    procedure UnRegisterInterface(AInterface: TGUID);
    /// <summary>
    ///   Instanciar classe pelo nome da unit + nome da classe e remover pelo nome da classe;
    /// </summary>
    function Resolve(const AUnitName, AClassName: string): TObject; overload;
    procedure ResolveRemove(const AKey: string); overload;
    /// <summary>
    ///   Instanciar classe pelo tipo genérico.
    /// </summary>
    function Resolve<T: TInjectionAbstract, constructor>: T; overload;
    procedure ResolveRemove<T: TInjectionAbstract>; overload;
    /// <summary>
    ///   Instanciar classe pela interface
    /// </summary>
    function ResolveInterface<T: IInterface>(const AKey: string = ''): T;
    procedure ResolveRemoveInterface<T: IInterface>(const AKey: string = '');
    /// <summary>
    ///   Executar métodos pelo nome como string
    /// </summary>
    function MethodInvoker(AObject: TObject; const AMethodName: string): Boolean; overload;
    function MethodInvoker(AObject: TObject; const AMethodName: string;
      const AParams: array of TValue): Boolean; overload;
  end;

var
  Injection: TInjection;


implementation

{ TInjection }

class constructor TInjection.Create;
begin
  inherited;
  FRegisterInterfaces := TDictionary<string, TClass>.Create;
  FRepository := TObjectDictionary<string, TInjectionAbstract>.Create([doOwnsValues]);
  FRepositoryInterface := TDictionary<string, IInterface>.Create;
end;

class destructor TInjection.Destroy;
begin
  FRegisterInterfaces.Free;
  FRepositoryInterface.Free;
  FRepository.Free;
  inherited;
end;

function TInjection.MethodInvoker(AObject: TObject; const AMethodName: string): Boolean;
begin
  Result := MethodInvoker(AObject, AMethodName, []);
end;

function TInjection.MethodInvoker(AObject: TObject; const AMethodName: string;
  const AParams: array of TValue): Boolean;
var
 LContext: TRttiContext;
 LType: TRttiType;
begin
  Result := True;
  LContext := TRttiContext.Create;
  try
    LType := LContext.GetType(AObject.ClassType);
    LType.GetMethod(AMethodName).Invoke(AObject, AParams);
  finally
    LContext.Free;
  end;
end;

procedure TInjection.RegisterInterface(AInterface: TGUID; AClass: TClass);
var
  LGuid: string;
begin
  LGuid := GUIDToString(AInterface);
  if not FRegisterInterfaces.ContainsKey(LGuid) then
    FRegisterInterfaces.Add(LGuid, AClass);
end;

procedure TInjection.RegisterInterface<T>(AInterface: TGUID);
begin
  RegisterInterface(AInterface, T);
end;

procedure TInjection.UnRegisterInterface(AInterface: TGUID);
var
  LGuid: string;
begin
  LGuid := GUIDToString(AInterface);
  if FRegisterInterfaces.ContainsKey(LGuid) then
    FRegisterInterfaces.Remove(LGuid);
  FRegisterInterfaces.TrimExcess;
end;

procedure TInjection.ResolveRemove(const AKey: string);
begin
  if FRepository.ContainsKey(AKey) then
    FRepository.Remove(AKey);
  FRepository.TrimExcess;
end;

procedure TInjection.ResolveRemove<T>;
begin
  ResolveRemove(T.ClassName);
end;

procedure TInjection.ResolveRemoveInterface<T>(const AKey: string);
var
  LGuid: string;
begin
  LGuid := GUIDToString(GetTypeData(TypeInfo(T)).Guid);
  if Length(AKey) > 0 then
    LGuid := AKey;
  if FRepositoryInterface.ContainsKey(LGuid) then
    FRepositoryInterface.Remove(LGuid);
  FRepositoryInterface.TrimExcess;
end;

function TInjection.MethodInvokerInternal(const AClassName,
  AMethodName: string): TObject;
var
  LContext: TRttiContext;
  LInstanceType: TRttiInstanceType;
  LValue: TValue;
begin
  LContext := TRttiContext.Create;
  try
    LInstanceType := (LContext.FindType(AClassName) as TRttiInstanceType);
    LValue := LInstanceType.GetMethod(AMethodName).Invoke(LInstanceType.MetaclassType,[]);
    Result := LValue.AsObject;
  finally
    LContext.Free;
  end;
end;

function TInjection.Resolve(const AUnitName, AClassName: string): TObject;
var
  LObject: TObject;
begin
  /// <summary> Application Resolve List </summary>
  if not FRepository.ContainsKey(AClassName) then
  begin
    LObject := MethodInvokerInternal(AUnitName + '.' + AClassName, 'Create');
    FRepository.Add(AClassName, LObject as TInjectionAbstract);
  end;
  Result := FRepository.Items[AClassName];
end;

function TInjection.Resolve<T>: T;
begin
  /// <summary> Application Resolve List </summary>
  if not FRepository.ContainsKey(T.ClassName) then
    FRepository.Add(T.ClassName, T.Create);
  Result := T(FRepository.Items[T.ClassName])
end;

function TInjection.ResolveInterface<T>(const AKey: string): T;
var
  LContext: TRttiContext;
  LType: TRttiType;
  LValue: TValue;
  LGuid: string;
  LKey: string;
begin
  Result := nil;
  LGuid := GUIDToString(GetTypeData(TypeInfo(T)).Guid);
  LKey := AKey;
  if Length(LKey) = 0 then
    LKey := LGuid;
  /// <summary>
  ///   Se existir na lista repositório devolve a interface que já existe
  /// </summary>
  if FRepositoryInterface.ContainsKey(LKey) then
    Exit(T(FRepositoryInterface.Items[LKey]));

  if FRegisterInterfaces.ContainsKey(LGuid) then
  begin
    LContext := TRttiContext.Create;
    try
      LType := LContext.GetType(FRegisterInterfaces.Items[LGuid]);
      if LType.GetMethod('New') <> nil then
        LValue := LType.GetMethod('New').Invoke(FRegisterInterfaces.Items[LGuid],[])
      else
      if LType.GetMethod('Create') <> nil then
        LValue := LType.GetMethod('Create').Invoke(FRegisterInterfaces.Items[LGuid],[])
      else
        Exit;

      Result := T(LValue.AsInterface);
      /// <summary>
      ///   Guarda a Interface na lista repositório para ser usada até que seja
      ///   chamado RemoveRelsolveControllerInterface()
      /// </summary>
      FRepositoryInterface.Add(LKey, T(LValue.AsInterface));
    finally
      LContext.Free;
    end;
  end;
end;

end.
