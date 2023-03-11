object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'Cadastro'
  ClientHeight = 567
  ClientWidth = 968
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object btnCadastrar: TButton
    Left = 8
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Cadastrar'
    TabOrder = 0
    OnClick = btnCadastrarClick
  end
  object btnAtualizar: TButton
    Left = 8
    Top = 62
    Width = 75
    Height = 25
    Caption = 'Atualizar'
    TabOrder = 1
    OnClick = btnAtualizarClick
  end
  object btnDeletar: TButton
    Left = 8
    Top = 102
    Width = 75
    Height = 25
    Caption = 'Deletar'
    TabOrder = 2
    OnClick = btnDeletarClick
  end
  object btnCarregar: TButton
    Left = 8
    Top = 141
    Width = 75
    Height = 25
    Caption = 'Carregar'
    TabOrder = 3
    OnClick = btnCarregarClick
  end
  object GroupBox1: TGroupBox
    Left = 89
    Top = 24
    Width = 696
    Height = 257
    Caption = 'Dados    '
    TabOrder = 4
    object Label1: TLabel
      Left = 16
      Top = 21
      Width = 11
      Height = 13
      Caption = 'ID'
    end
    object Label2: TLabel
      Left = 16
      Top = 64
      Width = 44
      Height = 13
      Caption = 'Natureza'
    end
    object Label3: TLabel
      Left = 16
      Top = 109
      Width = 54
      Height = 13
      Caption = 'Documento'
    end
    object Label4: TLabel
      Left = 16
      Top = 151
      Width = 68
      Height = 13
      Caption = 'Primeiro Nome'
    end
    object Label5: TLabel
      Left = 16
      Top = 197
      Width = 72
      Height = 13
      Caption = 'Segundo Nome'
    end
    object DBEdit1: TDBEdit
      Left = 16
      Top = 36
      Width = 81
      Height = 21
      TabStop = False
      DataField = 'idpessoa'
      DataSource = dsPessoa
      ReadOnly = True
      TabOrder = 0
    end
    object DBEdit2: TDBEdit
      Left = 16
      Top = 216
      Width = 377
      Height = 21
      DataField = 'nmsegundo'
      DataSource = dsPessoa
      TabOrder = 4
    end
    object DBEdit3: TDBEdit
      Left = 16
      Top = 80
      Width = 81
      Height = 21
      DataField = 'flnatureza'
      DataSource = dsPessoa
      TabOrder = 1
    end
    object DBEdit4: TDBEdit
      Left = 16
      Top = 125
      Width = 121
      Height = 21
      DataField = 'dsdocumento'
      DataSource = dsPessoa
      TabOrder = 2
    end
    object DBEdit5: TDBEdit
      Left = 16
      Top = 168
      Width = 377
      Height = 21
      DataField = 'nmprimeiro'
      DataSource = dsPessoa
      TabOrder = 3
    end
  end
  object GroupBox2: TGroupBox
    Left = 89
    Top = 287
    Width = 696
    Height = 234
    Caption = 'Endereco    '
    TabOrder = 5
    object Label6: TLabel
      Left = 16
      Top = 21
      Width = 19
      Height = 13
      Caption = 'CEP'
    end
    object spConsultaCep: TSpeedButton
      Left = 142
      Top = 39
      Width = 23
      Height = 22
      Hint = 'Consultar CEP'
      Caption = '...'
      OnClick = spConsultaCepClick
    end
    object DBEdtCep: TDBEdit
      Left = 15
      Top = 40
      Width = 121
      Height = 21
      DataField = 'dscep'
      DataSource = dsEndereco
      TabOrder = 0
    end
    object Panel1: TPanel
      Left = 552
      Top = 184
      Width = 185
      Height = 41
      Caption = 'Panel1'
      TabOrder = 1
    end
    object Panel2: TPanel
      Left = 2
      Top = 67
      Width = 692
      Height = 165
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      object Label7: TLabel
        Left = 14
        Top = 14
        Width = 13
        Height = 13
        Caption = 'UF'
      end
      object Label8: TLabel
        Left = 157
        Top = 16
        Width = 33
        Height = 13
        Caption = 'Cidade'
      end
      object Label9: TLabel
        Left = 14
        Top = 56
        Width = 28
        Height = 13
        Caption = 'Bairro'
      end
      object Label10: TLabel
        Left = 311
        Top = 57
        Width = 55
        Height = 13
        Caption = 'Logradouro'
      end
      object Label11: TLabel
        Left = 14
        Top = 96
        Width = 65
        Height = 13
        Caption = 'Complemento'
      end
      object DBEdit7: TDBEdit
        Left = 14
        Top = 32
        Width = 121
        Height = 21
        DataField = 'dsuf'
        DataSource = dsEnderecoIntegracao
        TabOrder = 0
      end
      object DBEdit8: TDBEdit
        Left = 14
        Top = 72
        Width = 275
        Height = 21
        DataField = 'nmbairro'
        DataSource = dsEnderecoIntegracao
        TabOrder = 1
      end
      object DBEdit9: TDBEdit
        Left = 157
        Top = 32
        Width = 315
        Height = 21
        DataField = 'nmcidade'
        DataSource = dsEnderecoIntegracao
        TabOrder = 2
      end
      object DBEdit10: TDBEdit
        Left = 310
        Top = 71
        Width = 315
        Height = 21
        DataField = 'nslogradouro'
        DataSource = dsEnderecoIntegracao
        TabOrder = 3
      end
      object DBEdit11: TDBEdit
        Left = 14
        Top = 111
        Width = 275
        Height = 21
        DataField = 'dscomplemento'
        DataSource = dsEnderecoIntegracao
        TabOrder = 4
      end
    end
  end
  object btnLote: TButton
    Left = 8
    Top = 190
    Width = 75
    Height = 25
    Caption = 'Lote'
    TabOrder = 6
    OnClick = btnLoteClick
  end
  object dsPessoa: TDataSource
    Left = 816
    Top = 32
  end
  object dsEndereco: TDataSource
    Left = 816
    Top = 80
  end
  object dsEnderecoIntegracao: TDataSource
    Left = 816
    Top = 136
  end
  object OpenTextFileDialog: TOpenTextFileDialog
    Filter = 'csv|*.csv'
    Left = 856
    Top = 216
  end
end
