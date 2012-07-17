object Frm8: TFrm8
  Left = 273
  Top = 207
  BorderStyle = bsDialog
  Caption = #1061#1088#1072#1085#1080#1083#1080#1097#1077
  ClientHeight = 187
  ClientWidth = 508
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    508
    187)
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 0
    Top = 8
    Width = 96
    Height = 13
    Caption = #1050#1086#1088#1077#1085#1100' '#1093#1088#1072#1085#1080#1083#1080#1097#1072
  end
  object lbl2: TLabel
    Left = 0
    Top = 32
    Width = 83
    Height = 13
    Caption = #1050#1072#1090#1072#1083#1086#1075' '#1090#1072#1073#1083#1080#1094'*'
  end
  object lbl3: TLabel
    Left = 0
    Top = 56
    Width = 92
    Height = 13
    Caption = #1050#1072#1090#1072#1083#1086#1075' '#1076#1086#1084#1077#1085#1086#1074'*'
  end
  object lbl4: TLabel
    Left = 0
    Top = 80
    Width = 125
    Height = 13
    Caption = #1050#1072#1090#1072#1083#1086#1075' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081'*'
  end
  object lbl5: TLabel
    Left = 0
    Top = 104
    Width = 76
    Height = 13
    Caption = #1050#1072#1090#1072#1083#1086#1075' '#1075#1088#1091#1087#1087'*'
  end
  object lbl6: TLabel
    Left = 8
    Top = 128
    Width = 411
    Height = 26
    Caption = 
      '* - '#1077#1089#1083#1080' '#1087#1091#1089#1090#1086' '#1089#1086#1079#1076#1072#1102#1090#1089#1103' '#1082#1072#1090#1072#1083#1086#1075#1080' '#1089' '#1080#1084#1077#1085#1072#1084#1080' '#1087#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102' '#1074' '#1082#1086#1088#1085#1077 +
      ' '#1093#1088#1072#1085#1080#1083#1080#1097#1072' '#13#10'          ('#1088#1077#1082#1086#1084#1077#1085#1076#1091#1077#1090#1089#1103' '#1076#1083#1103' '#1084#1072#1083#1099#1093' '#1080' '#1089#1088#1077#1076#1085#1080#1093' '#1080' '#1085#1077#1073#1086 +
      #1083#1100#1096#1080#1093' '#1087#1088#1077#1076#1087#1088#1080#1103#1090#1080#1081')'
    WordWrap = True
  end
  object edtBase: TEdit
    Left = 128
    Top = 8
    Width = 350
    Height = 21
    TabOrder = 0
  end
  object edtJournals: TEdit
    Left = 128
    Top = 32
    Width = 350
    Height = 21
    TabOrder = 1
  end
  object edtDomains: TEdit
    Left = 128
    Top = 56
    Width = 350
    Height = 21
    TabOrder = 2
  end
  object edtUsers: TEdit
    Left = 128
    Top = 80
    Width = 350
    Height = 21
    TabOrder = 3
  end
  object edtGroups: TEdit
    Left = 128
    Top = 104
    Width = 350
    Height = 21
    TabOrder = 4
  end
  object btn1: TButton
    Left = 479
    Top = 8
    Width = 25
    Height = 20
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 5
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 479
    Top = 32
    Width = 25
    Height = 20
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 6
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 479
    Top = 56
    Width = 25
    Height = 20
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 7
    OnClick = btn3Click
  end
  object btn4: TButton
    Left = 479
    Top = 80
    Width = 25
    Height = 20
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 8
    OnClick = btn4Click
  end
  object btn5: TButton
    Left = 479
    Top = 104
    Width = 25
    Height = 20
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 9
    OnClick = btn5Click
  end
  object btnOk: TBitBtn
    Left = 256
    Top = 160
    Width = 113
    Height = 25
    TabOrder = 10
    Kind = bkOK
  end
  object btnCancel: TBitBtn
    Left = 392
    Top = 160
    Width = 113
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 11
    Kind = bkCancel
  end
end
