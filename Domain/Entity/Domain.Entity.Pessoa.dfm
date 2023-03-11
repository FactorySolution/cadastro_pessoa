object dmPessoa: TdmPessoa
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 274
  Width = 217
  object FQryPessoa: TFDQuery
    CachedUpdates = True
    SQL.Strings = (
      'select * from pessoa !where')
    Left = 72
    Top = 24
    MacroData = <
      item
        Value = Null
        Name = 'WHERE'
      end>
    object FQryPessoaidpessoa: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'idpessoa'
      Origin = 'idpessoa'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FQryPessoaflnatureza: TSmallintField
      FieldName = 'flnatureza'
      Origin = 'flnatureza'
    end
    object FQryPessoadsdocumento: TWideStringField
      FieldName = 'dsdocumento'
      Origin = 'dsdocumento'
    end
    object FQryPessoanmprimeiro: TWideStringField
      FieldName = 'nmprimeiro'
      Origin = 'nmprimeiro'
      Size = 100
    end
    object FQryPessoanmsegundo: TWideStringField
      FieldName = 'nmsegundo'
      Origin = 'nmsegundo'
      Size = 100
    end
    object FQryPessoadtregistro: TDateField
      FieldName = 'dtregistro'
      Origin = 'dtregistro'
    end
  end
  object FQryEnderecoIntegracao: TFDQuery
    CachedUpdates = True
    SQL.Strings = (
      'SELECT * FROM endereco_integracao !where')
    Left = 72
    Top = 128
    MacroData = <
      item
        Value = Null
        Name = 'WHERE'
      end>
    object FQryEnderecoIntegracaoidendereco: TLargeintField
      FieldName = 'idendereco'
      Origin = 'idendereco'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FQryEnderecoIntegracaodsuf: TWideStringField
      FieldName = 'dsuf'
      Origin = 'dsuf'
      Size = 50
    end
    object FQryEnderecoIntegracaonmcidade: TWideStringField
      FieldName = 'nmcidade'
      Origin = 'nmcidade'
      Size = 100
    end
    object FQryEnderecoIntegracaonmbairro: TWideStringField
      FieldName = 'nmbairro'
      Origin = 'nmbairro'
      Size = 50
    end
    object FQryEnderecoIntegracaonslogradouro: TWideStringField
      FieldName = 'nslogradouro'
      Origin = 'nslogradouro'
      Size = 100
    end
    object FQryEnderecoIntegracaodscomplemento: TWideStringField
      FieldName = 'dscomplemento'
      Origin = 'dscomplemento'
      Size = 100
    end
  end
  object FQryEndereco: TFDQuery
    CachedUpdates = True
    SQL.Strings = (
      'SELECT * FROM endereco !where')
    Left = 72
    Top = 72
    MacroData = <
      item
        Value = Null
        Name = 'WHERE'
      end>
    object FQryEnderecoidendereco: TLargeintField
      AutoGenerateValue = arAutoInc
      FieldName = 'idendereco'
      Origin = 'idendereco'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
    end
    object FQryEnderecoidpessoa: TLargeintField
      FieldName = 'idpessoa'
      Origin = 'idpessoa'
    end
    object FQryEnderecodscep: TWideStringField
      FieldName = 'dscep'
      Origin = 'dscep'
      EditMask = '00000\-999;0;_'
      Size = 15
    end
  end
  object FQryLote: TFDQuery
    CachedUpdates = True
    SQL.Strings = (
      
        'INSERT INTO pessoa (flnatureza, dsdocumento, nmprimeiro, nmsegun' +
        'do, dtregistro) VALUES (:flnatureza, :dsdocumento, :nmprimeiro, ' +
        ':nmsegundo, :dtregistro)')
    Left = 72
    Top = 184
    ParamData = <
      item
        Name = 'FLNATUREZA'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DSDOCUMENTO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'NMPRIMEIRO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'NMSEGUNDO'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'DTREGISTRO'
        DataType = ftDateTime
        ParamType = ptInput
        Value = Null
      end>
  end
end
