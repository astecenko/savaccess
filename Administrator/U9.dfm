object Frm9: TFrm9
  Left = 197
  Top = 130
  Width = 781
  Height = 348
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
  OnResize = FormResize
  DesignSize = (
    773
    321)
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 128
    Top = 201
    Width = 42
    Height = 13
    Caption = #1055#1072#1090#1090#1077#1088#1085
  end
  object lbl2: TLabel
    Left = 128
    Top = 225
    Width = 52
    Height = 13
    Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090
  end
  object lbl3: TLabel
    Left = 131
    Top = 40
    Width = 42
    Height = 13
    Caption = #1055#1072#1090#1090#1077#1088#1085
  end
  object lbl4: TLabel
    Left = 128
    Top = 64
    Width = 50
    Height = 13
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077
  end
  object lbl5: TLabel
    Left = 128
    Top = 88
    Width = 169
    Height = 13
    Caption = 'FOLDERID '#1076#1083#1103' WinVista '#1080' '#1089#1090#1072#1088#1096#1077
  end
  object lbl6: TLabel
    Left = 128
    Top = 112
    Width = 140
    Height = 13
    Caption = 'CSIDL '#1076#1083#1103' WinXP '#1080' '#1084#1083#1072#1076#1096#1077
  end
  object lbl7: TLabel
    Left = 128
    Top = 136
    Width = 89
    Height = 13
    Caption = #1040#1073#1089#1086#1083#1102#1090#1085#1099#1081' '#1087#1091#1090#1100
  end
  object lbl8: TLabel
    Left = 128
    Top = 8
    Width = 84
    Height = 13
    Caption = #1053#1072#1095#1072#1083#1086' '#1096#1072#1073#1083#1086#1085#1072
  end
  object lbl9: TLabel
    Left = 320
    Top = 10
    Width = 78
    Height = 13
    Caption = #1050#1086#1085#1077#1094' '#1096#1072#1073#1083#1086#1085#1072
  end
  object bvl1: TBevel
    Left = 128
    Top = 184
    Width = 644
    Height = 10
    Anchors = [akLeft, akTop, akRight]
    Shape = bsBottomLine
  end
  object bvl2: TBevel
    Left = 128
    Top = 22
    Width = 644
    Height = 10
    Anchors = [akLeft, akTop, akRight]
    Shape = bsBottomLine
  end
  object edtTestInput: TEdit
    Left = 192
    Top = 198
    Width = 513
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object btnTest: TButton
    Left = 710
    Top = 198
    Width = 62
    Height = 48
    Anchors = [akTop, akRight]
    Caption = #1055#1088#1086#1074#1077#1088#1080#1090#1100
    TabOrder = 1
    OnClick = btnTestClick
  end
  object lst1: TListBox
    Left = 0
    Top = 0
    Width = 121
    Height = 289
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    Sorted = True
    TabOrder = 2
    OnClick = lst1Click
    OnDblClick = lst1DblClick
  end
  object edtCaption: TEdit
    Left = 304
    Top = 61
    Width = 467
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
  end
  object edtNewWind: TEdit
    Left = 304
    Top = 85
    Width = 467
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 4
  end
  object seOldWind: TSpinEdit
    Left = 304
    Top = 109
    Width = 121
    Height = 22
    MaxValue = 99999999
    MinValue = -1
    TabOrder = 5
    Value = -1
  end
  object edtPath: TEdit
    Left = 304
    Top = 133
    Width = 467
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 6
  end
  object edtPattern: TEdit
    Left = 304
    Top = 35
    Width = 467
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 7
  end
  object btnAdd: TButton
    Left = 661
    Top = 160
    Width = 110
    Height = 25
    Anchors = [akTop, akRight]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1096#1072#1073#1083#1086#1085
    TabOrder = 8
    OnClick = btnAddClick
  end
  object btnDel: TButton
    Left = 128
    Top = 160
    Width = 89
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 9
    OnClick = btnDelClick
  end
  object btnSaveFile: TBitBtn
    Left = 0
    Top = 296
    Width = 161
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1102
    TabOrder = 10
    WordWrap = True
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
  object btnOk: TBitBtn
    Left = 549
    Top = 295
    Width = 105
    Height = 25
    Anchors = [akRight, akBottom]
    TabOrder = 11
    Kind = bkOK
  end
  object btnCancel: TBitBtn
    Left = 666
    Top = 295
    Width = 105
    Height = 25
    Anchors = [akRight, akBottom]
    TabOrder = 12
    Kind = bkCancel
  end
  object edtPatternBegin: TEdit
    Left = 216
    Top = 5
    Width = 81
    Height = 21
    TabOrder = 13
    OnChange = edtPatternBeginChange
  end
  object edtPatternEnd: TEdit
    Left = 400
    Top = 5
    Width = 81
    Height = 21
    TabOrder = 14
    OnChange = edtPatternEndChange
  end
  object edtTestResult: TMemo
    Left = 192
    Top = 224
    Width = 513
    Height = 57
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    TabOrder = 15
  end
end
