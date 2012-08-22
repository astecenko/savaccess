object Form2: TForm2
  Left = 421
  Top = 190
  BorderStyle = bsDialog
  Caption = #1055#1086#1076#1076#1077#1088#1078#1082#1072' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
  ClientHeight = 187
  ClientWidth = 386
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  DesignSize = (
    386
    187)
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 8
    Top = 8
    Width = 251
    Height = 24
    Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1087#1086#1076#1076#1077#1088#1078#1082#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object medt1: TMaskEdit
    Left = 264
    Top = 5
    Width = 120
    Height = 32
    EditMask = '9999999999;1;_'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    MaxLength = 10
    ParentFont = False
    TabOrder = 0
    Text = '          '
  end
  object mmo1: TMemo
    Left = 0
    Top = 40
    Width = 385
    Height = 105
    Anchors = [akLeft, akTop, akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object btnRing: TBitBtn
    Left = 0
    Top = 152
    Width = 113
    Height = 33
    Anchors = [akLeft, akBottom]
    Caption = #1042#1099#1079#1074#1072#1090#1100
    ModalResult = 1
    TabOrder = 2
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333000000000
      003333377777777777F3333091111111103333F7F3F3F3F3F7F3311098080808
      10333777F737373737F313309999999910337F373F3F3F3F3733133309808089
      03337FFF7F7373737FFF1000109999901000777777FFFFF77777701110000000
      111037F337777777F3373099901111109990373F373333373337330999999999
      99033373FFFFFFFFFF7333310000000001333337777777777733333333333333
      3333333333333333333333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333333333333}
    NumGlyphs = 2
  end
  object btnCancel: TBitBtn
    Left = 272
    Top = 152
    Width = 113
    Height = 33
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    Kind = bkCancel
  end
end
