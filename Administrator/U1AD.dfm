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
  DesignSize = (
    589
    453)
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 203
    Top = 384
    Width = 4
    Height = 20
    Anchors = [akLeft, akBottom]
    Caption = '\'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object dbgrd1: TDBGrid
    Left = 0
    Top = 32
    Width = 589
    Height = 345
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = ds1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
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
  object btn2: TButton
    Left = 511
    Top = 8
    Width = 75
    Height = 22
    Anchors = [akTop, akRight]
    Caption = #1055#1086#1080#1089#1082
    TabOrder = 1
    OnClick = btn2Click
  end
  object edt1: TEdit
    Left = 200
    Top = 8
    Width = 304
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 2
  end
  object cbb1: TComboBox
    Left = 112
    Top = 8
    Width = 81
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 0
    TabOrder = 3
    Text = #1060#1048#1054'=CN'
    Items.Strings = (
      #1060#1048#1054'=CN'
      #1051#1086#1075#1080#1085'=sAMAccountName'
      #1069#1083'.'#1087#1086#1095#1090#1072'=mail')
  end
  object edtDomain: TEdit
    Left = 0
    Top = 8
    Width = 105
    Height = 21
    Hint = #1050#1086#1088#1085#1077#1074#1086#1081' '#1091#1079#1077#1083
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
    Text = 'DC=nevz,DC=com'
  end
  object btnOk: TBitBtn
    Left = 511
    Top = 392
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Yes'
    Default = True
    ModalResult = 1
    TabOrder = 5
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
    Left = 511
    Top = 424
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    TabOrder = 6
    Kind = bkCancel
  end
  object edtCaption: TEdit
    Left = 208
    Top = 384
    Width = 291
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    ReadOnly = True
    TabOrder = 7
  end
  object edtSID: TEdit
    Left = 0
    Top = 408
    Width = 499
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    ReadOnly = True
    TabOrder = 8
  end
  object edtDescription: TEdit
    Left = 0
    Top = 432
    Width = 499
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    ReadOnly = True
    TabOrder = 9
  end
  object edtUserDomain: TEdit
    Left = 0
    Top = 384
    Width = 201
    Height = 21
    Anchors = [akLeft, akBottom]
    ReadOnly = True
    TabOrder = 10
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
