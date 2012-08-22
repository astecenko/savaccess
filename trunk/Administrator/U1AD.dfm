object FrmAD: TFrmAD
  Left = 566
  Top = 75
  Width = 597
  Height = 480
  Caption = #1055#1088#1086#1089#1084#1086#1090#1088' Microsoft Active Directory'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object spl1: TSplitter
    Left = 0
    Top = 269
    Width = 589
    Height = 3
    Cursor = crVSplit
    Align = alBottom
  end
  object pnl1: TPanel
    Left = 0
    Top = 370
    Width = 589
    Height = 83
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      589
      83)
    object lbl1: TLabel
      Left = 205
      Top = 7
      Width = 4
      Height = 20
      Caption = '\'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
    object edtSID: TEdit
      Left = 2
      Top = 56
      Width = 483
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ReadOnly = True
      TabOrder = 0
    end
    object edtUserDomain: TEdit
      Left = 2
      Top = 8
      Width = 201
      Height = 21
      ReadOnly = True
      TabOrder = 1
    end
    object edtDescription: TEdit
      Left = 2
      Top = 32
      Width = 483
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ReadOnly = True
      TabOrder = 2
    end
    object edtCaption: TEdit
      Left = 210
      Top = 8
      Width = 275
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      ReadOnly = True
      TabOrder = 3
    end
    object btnOk: TBitBtn
      Left = 503
      Top = 8
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = '&Yes'
      Default = True
      ModalResult = 1
      TabOrder = 4
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object btnCancel: TBitBtn
      Left = 503
      Top = 44
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      TabOrder = 5
      Kind = bkCancel
    end
  end
  object pnl2: TPanel
    Left = 0
    Top = 272
    Width = 589
    Height = 98
    Align = alBottom
    TabOrder = 1
    object spl2: TSplitter
      Left = 357
      Top = 1
      Height = 96
      Align = alRight
    end
    object mmo1: TMemo
      Left = 1
      Top = 1
      Width = 356
      Height = 96
      Align = alClient
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object mmo2: TMemo
      Left = 360
      Top = 1
      Width = 228
      Height = 96
      Align = alRight
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
  object pnl3: TPanel
    Left = 0
    Top = 0
    Width = 589
    Height = 269
    Align = alClient
    TabOrder = 2
    DesignSize = (
      589
      269)
    object btn2: TButton
      Left = 505
      Top = 8
      Width = 75
      Height = 22
      Anchors = [akTop, akRight]
      Caption = #1055#1086#1080#1089#1082
      TabOrder = 0
      OnClick = btn2Click
    end
    object cbb1: TComboBox
      Left = 216
      Top = 8
      Width = 81
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
      Text = #1060#1048#1054'=CN'
      Items.Strings = (
        #1060#1048#1054'=CN'
        #1051#1086#1075#1080#1085'=sAMAccountName'
        #1069#1083'.'#1087#1086#1095#1090#1072'=mail')
    end
    object dbgrd1: TDBGrid
      Left = 0
      Top = 35
      Width = 587
      Height = 230
      Anchors = [akLeft, akTop, akRight, akBottom]
      DataSource = ds1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = dbgrd1DblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'CN'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sAMAccountName'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'userPrincipalName'
          Width = 140
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'mail'
          Width = 140
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'distinguishedName'
          Visible = True
        end>
    end
    object edt1: TEdit
      Left = 304
      Top = 8
      Width = 192
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 3
    end
    object edtDomain: TEdit
      Left = 8
      Top = 8
      Width = 105
      Height = 21
      Hint = #1050#1086#1088#1085#1077#1074#1086#1081' '#1091#1079#1077#1083
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      Text = 'DC=nevz,DC=com'
    end
    object edtDomainNBS: TEdit
      Left = 116
      Top = 8
      Width = 97
      Height = 21
      Hint = 'NetBIOS '#1080#1084#1103' '#1076#1086#1084#1077#1085#1072
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
    end
  end
  object con1: TADOConnection
    Connected = True
    ConnectionString = 'Provider=ADsDSOObject;Mode=Read;'
    LoginPrompt = False
    Mode = cmRead
    Provider = 'ADsDSOObject'
    Left = 248
    Top = 128
  end
  object ds1: TDataSource
    DataSet = qry1
    OnDataChange = ds1DataChange
    Left = 216
    Top = 128
  end
  object qry1: TADOQuery
    Connection = con1
    CursorType = ctStatic
    ParamCheck = False
    Parameters = <>
    SQL.Strings = (
      
        'select CN, mail, sAMAccountName, distinguishedName, userPrincipa' +
        'lName, objectSid from '
      #39'LDAP://DC=nevz,DC=com'#39
      
        'WHERE objectcategory = '#39'Person'#39' AND objectclass = '#39'User'#39' AND CN ' +
        '= '#39'*'#1055#1083#1072#1090#1086#1085'*'#39' order by CN')
    Left = 280
    Top = 128
  end
end
