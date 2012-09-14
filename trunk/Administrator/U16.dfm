object Frm16: TFrm16
  Left = 192
  Top = 133
  BorderStyle = bsDialog
  Caption = #1052#1077#1085#1077#1076#1078#1077#1088#1099
  ClientHeight = 351
  ClientWidth = 434
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCloseQuery = FormCloseQuery
  OnShow = FormShow
  DesignSize = (
    434
    351)
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 0
    Top = 8
    Width = 31
    Height = 13
    Caption = #1051#1086#1075#1080#1085
  end
  object lbl2: TLabel
    Left = 176
    Top = 8
    Width = 38
    Height = 13
    Caption = #1055#1072#1088#1086#1083#1100
  end
  object bvl1: TBevel
    Left = 0
    Top = 32
    Width = 433
    Height = 10
    Shape = bsBottomLine
  end
  object lblChanged: TLabel
    Left = 352
    Top = 128
    Width = 70
    Height = 39
    Alignment = taCenter
    Caption = #1045#1089#1090#1100' '#1085#1077' '#1089#1086#1093#1088#1072#1085#1077#1085#1085#1099#1077' '#1080#1079#1084#1077#1085#1077#1085#1080#1103
    Enabled = False
    WordWrap = True
  end
  object lblFileName: TLabel
    Left = 0
    Top = 326
    Width = 434
    Height = 25
    Align = alBottom
    AutoSize = False
    WordWrap = True
  end
  object edt1: TEdit
    Left = 40
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object edt2: TEdit
    Left = 216
    Top = 8
    Width = 121
    Height = 21
    PasswordChar = '#'
    TabOrder = 1
  end
  object btnAdd: TButton
    Left = 344
    Top = 8
    Width = 89
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    TabOrder = 2
    OnClick = btnAddClick
  end
  object lstUser: TListBox
    Left = 0
    Top = 48
    Width = 337
    Height = 273
    Anchors = [akLeft, akTop, akBottom]
    ItemHeight = 13
    TabOrder = 3
  end
  object btnDel: TButton
    Left = 344
    Top = 48
    Width = 89
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    TabOrder = 4
    OnClick = btnDelClick
  end
  object btnSaveAs: TButton
    Left = 344
    Top = 296
    Width = 89
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082'...'
    TabOrder = 5
    OnClick = btnSaveAsClick
  end
  object btnOpen: TButton
    Left = 344
    Top = 232
    Width = 89
    Height = 25
    Caption = #1054#1090#1082#1088#1099#1090#1100'...'
    TabOrder = 6
    OnClick = btnOpenClick
  end
  object btnSave: TButton
    Left = 344
    Top = 264
    Width = 89
    Height = 25
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    Enabled = False
    TabOrder = 7
    OnClick = btnSaveClick
  end
  object btnNew: TButton
    Left = 344
    Top = 200
    Width = 89
    Height = 25
    Caption = #1053#1086#1074#1099#1081
    TabOrder = 8
    OnClick = btnNewClick
  end
  object dlgOpen1: TOpenDialog
    DefaultExt = '.pwd'
    Filter = #1055#1072#1088#1086#1083#1080' (*.pwd)|*.pwd|'#1058#1077#1082#1089#1090' (*.txt)|*.txt|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Title = #1054#1090#1082#1088#1099#1090#1100' '#1092#1072#1081#1083' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081'-'#1084#1077#1085#1077#1076#1078#1077#1088#1086#1074
    Left = 40
    Top = 80
  end
  object dlgSave1: TSaveDialog
    DefaultExt = '*.pwd'
    FileName = 'managers.pwd'
    Filter = #1055#1072#1088#1086#1083#1080' (*.pwd)|*.pwd|'#1058#1077#1082#1089#1090' (*.txt)|*.txt|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Title = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1092#1072#1081#1083' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081'-'#1084#1077#1085#1077#1076#1078#1077#1088#1086#1074
    Left = 72
    Top = 80
  end
end
