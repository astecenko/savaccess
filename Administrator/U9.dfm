object Frm9: TFrm9
  Left = 197
  Top = 130
  Width = 800
  Height = 338
  Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1096#1072#1073#1083#1086#1085#1086#1074
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  DesignSize = (
    792
    311)
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 8
    Top = 258
    Width = 86
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1058#1077#1089#1090#1086#1074#1072#1103' '#1089#1090#1088#1086#1082#1072
  end
  object lbl2: TLabel
    Left = 16
    Top = 282
    Width = 52
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
  end
  object lbl3: TLabel
    Left = 464
    Top = 176
    Width = 42
    Height = 13
    Anchors = [akTop, akRight]
    Caption = #1055#1072#1090#1090#1077#1088#1085
  end
  object lbl4: TLabel
    Left = 336
    Top = 24
    Width = 50
    Height = 13
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077
  end
  object lbl5: TLabel
    Left = 336
    Top = 48
    Width = 169
    Height = 13
    Caption = 'FOLDERID '#1076#1083#1103' WinVista '#1080' '#1089#1090#1072#1088#1096#1077
  end
  object lbl6: TLabel
    Left = 336
    Top = 72
    Width = 140
    Height = 13
    Caption = 'CSIDL '#1076#1083#1103' WinXP '#1080' '#1084#1083#1072#1076#1096#1077
  end
  object lbl7: TLabel
    Left = 336
    Top = 96
    Width = 89
    Height = 13
    Caption = #1040#1073#1089#1086#1083#1102#1090#1085#1099#1081' '#1087#1091#1090#1100
  end
  object bvl2: TBevel
    Left = 448
    Top = 4
    Width = 329
    Height = 237
    Anchors = [akLeft, akTop, akRight]
  end
  object bvl1: TBevel
    Left = 328
    Top = 12
    Width = 438
    Height = 141
    Anchors = [akLeft, akTop, akRight]
  end
  object edtTestInput: TEdit
    Left = 104
    Top = 255
    Width = 601
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 0
  end
  object edtTestResult: TEdit
    Left = 104
    Top = 282
    Width = 601
    Height = 21
    Anchors = [akLeft, akRight, akBottom]
    ReadOnly = True
    TabOrder = 1
  end
  object btnTest: TButton
    Left = 712
    Top = 250
    Width = 75
    Height = 57
    Anchors = [akRight, akBottom]
    Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100
    TabOrder = 2
    OnClick = btnTestClick
  end
  object lst1: TListBox
    Left = 0
    Top = 0
    Width = 329
    Height = 249
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    Sorted = True
    TabOrder = 3
    OnClick = lst1Click
    OnDblClick = lst1DblClick
  end
  object edtCaption: TEdit
    Left = 512
    Top = 21
    Width = 241
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
  end
  object edtNewWind: TEdit
    Left = 512
    Top = 45
    Width = 241
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 5
  end
  object seOldWind: TSpinEdit
    Left = 512
    Top = 69
    Width = 121
    Height = 22
    MaxValue = 99999999
    MinValue = -1
    TabOrder = 6
    Value = -1
  end
  object edtPath: TEdit
    Left = 512
    Top = 93
    Width = 241
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 7
  end
  object btnSave: TButton
    Left = 336
    Top = 120
    Width = 89
    Height = 25
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100
    TabOrder = 8
    OnClick = btnSaveClick
  end
  object edtPattern: TEdit
    Left = 512
    Top = 171
    Width = 241
    Height = 21
    Anchors = [akTop, akRight]
    TabOrder = 9
  end
  object btnAdd: TButton
    Left = 688
    Top = 200
    Width = 75
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 10
    OnClick = btnAddClick
  end
  object btnDel: TButton
    Left = 336
    Top = 160
    Width = 89
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 11
    OnClick = btnDelClick
  end
  object btnSaveFile: TBitBtn
    Left = 336
    Top = 216
    Width = 89
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 12
    OnClick = btnSaveFileClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333FFFFFFFFFFFFF33000077777770033377777777777773F000007888888
      00037F3337F3FF37F37F00000780088800037F3337F77F37F37F000007800888
      00037F3337F77FF7F37F00000788888800037F3337777777337F000000000000
      00037F3FFFFFFFFFFF7F00000000000000037F77777777777F7F000FFFFFFFFF
      00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
      00037F7F333333337F7F000FFFFFFFFF00037F7F333333337F7F000FFFFFFFFF
      00037F7F333333337F7F000FFFFFFFFF07037F7F33333333777F000FFFFFFFFF
      0003737FFFFFFFFF7F7330099999999900333777777777777733}
    NumGlyphs = 2
  end
end
