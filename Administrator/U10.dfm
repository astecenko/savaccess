object Frm10: TFrm10
  Left = 530
  Top = 105
  Width = 400
  Height = 350
  Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1087#1088#1072#1074#1080#1083' '#1092#1072#1081#1083#1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnResize = FormResize
  DesignSize = (
    392
    323)
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 0
    Top = 8
    Width = 189
    Height = 13
    Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072'/'#1076#1080#1088#1077#1082#1090#1086#1088#1080#1080' '#1074' '#1093#1088#1072#1085#1080#1083#1080#1097#1077
  end
  object lbl2: TLabel
    Left = 0
    Top = 48
    Width = 173
    Height = 13
    Caption = #1048#1084#1103' '#1092#1072#1081#1083#1072'/'#1076#1080#1088#1077#1082#1090#1086#1088#1080#1080' '#1091' '#1082#1083#1080#1077#1085#1090#1072
  end
  object lbl4: TLabel
    Left = 80
    Top = 144
    Width = 63
    Height = 13
    Caption = #1056#1072#1089#1096#1080#1088#1077#1085#1080#1077
  end
  object lbl5: TLabel
    Left = 16
    Top = 144
    Width = 19
    Height = 13
    Caption = #1058#1080#1087
  end
  object lbl6: TLabel
    Left = 200
    Top = 144
    Width = 50
    Height = 13
    Caption = #1044#1077#1081#1089#1090#1074#1080#1077
  end
  object bvl1: TBevel
    Left = 0
    Top = 136
    Width = 392
    Height = 57
    Anchors = [akLeft, akTop, akRight]
  end
  object lbl7: TLabel
    Left = 0
    Top = 88
    Width = 23
    Height = 13
    Caption = 'MD5'
  end
  object lbl8: TLabel
    Left = 0
    Top = 200
    Width = 70
    Height = 13
    Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
  end
  object lbl3: TLabel
    Left = 0
    Top = 240
    Width = 37
    Height = 13
    Caption = #1042#1077#1088#1089#1080#1103
  end
  object edtSrvrFile: TEdit
    Left = 0
    Top = 24
    Width = 343
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object edtClntFile: TEdit
    Left = 0
    Top = 64
    Width = 345
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
  end
  object btnTest: TBitBtn
    Left = 346
    Top = 64
    Width = 22
    Height = 22
    Anchors = [akTop, akRight]
    TabOrder = 2
    OnClick = btnTestClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333300000000
      0000333377777777777733330FFFFFFFFFF033337F3FFF3F3FF733330F000F0F
      00F033337F777373773733330FFFFFFFFFF033337F3FF3FF3FF733330F00F00F
      00F033337F773773773733330FFFFFFFFFF033337FF3333FF3F7333300FFFF00
      F0F03333773FF377F7373330FB00F0F0FFF0333733773737F3F7330FB0BF0FB0
      F0F0337337337337373730FBFBF0FB0FFFF037F333373373333730BFBF0FB0FF
      FFF037F3337337333FF700FBFBFB0FFF000077F333337FF37777E0BFBFB000FF
      0FF077FF3337773F7F37EE0BFB0BFB0F0F03777FF3733F737F73EEE0BFBF00FF
      00337777FFFF77FF7733EEEE0000000003337777777777777333}
    NumGlyphs = 2
  end
  object edtExt: TEdit
    Left = 80
    Top = 160
    Width = 89
    Height = 21
    MaxLength = 10
    TabOrder = 3
  end
  object cbbType: TComboBox
    Left = 16
    Top = 160
    Width = 41
    Height = 21
    ItemHeight = 13
    MaxLength = 1
    TabOrder = 4
    Items.Strings = (
      'F'
      'D')
  end
  object seAction: TSpinEdit
    Left = 200
    Top = 160
    Width = 57
    Height = 22
    MaxValue = 999
    MinValue = 0
    TabOrder = 5
    Value = 0
  end
  object btnOk: TBitBtn
    Left = 224
    Top = 296
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    TabOrder = 6
    Kind = bkOK
  end
  object btnCancel: TBitBtn
    Left = 312
    Top = 296
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    TabOrder = 7
    Kind = bkCancel
  end
  object btnShow: TBitBtn
    Left = 370
    Top = 24
    Width = 22
    Height = 22
    Anchors = [akTop, akRight]
    TabOrder = 8
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      5555555555555555555555555555555555555555555555555555555555555555
      555555555555555555555555555555555555555FFFFFFFFFF555550000000000
      55555577777777775F55500B8B8B8B8B05555775F555555575F550F0B8B8B8B8
      B05557F75F555555575F50BF0B8B8B8B8B0557F575FFFFFFFF7F50FBF0000000
      000557F557777777777550BFBFBFBFB0555557F555555557F55550FBFBFBFBF0
      555557F555555FF7555550BFBFBF00055555575F555577755555550BFBF05555
      55555575FFF75555555555700007555555555557777555555555555555555555
      5555555555555555555555555555555555555555555555555555}
    NumGlyphs = 2
  end
  object btnLoad: TBitBtn
    Left = 345
    Top = 24
    Width = 22
    Height = 22
    Anchors = [akTop, akRight]
    TabOrder = 9
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333330070
      7700333333337777777733333333008088003333333377F73377333333330088
      88003333333377FFFF7733333333000000003FFFFFFF77777777000000000000
      000077777777777777770FFFFFFF0FFFFFF07F3333337F3333370FFFFFFF0FFF
      FFF07F3FF3FF7FFFFFF70F00F0080CCC9CC07F773773777777770FFFFFFFF039
      99337F3FFFF3F7F777F30F0000F0F09999937F7777373777777F0FFFFFFFF999
      99997F3FF3FFF77777770F00F000003999337F773777773777F30FFFF0FF0339
      99337F3FF7F3733777F30F08F0F0337999337F7737F73F7777330FFFF0039999
      93337FFFF7737777733300000033333333337777773333333333}
    NumGlyphs = 2
  end
  object edtMD5: TEdit
    Left = 0
    Top = 104
    Width = 345
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 10
  end
  object btnMD5: TBitBtn
    Left = 347
    Top = 104
    Width = 45
    Height = 22
    Anchors = [akTop, akRight]
    Caption = 'MD5'
    TabOrder = 11
    OnClick = btnMD5Click
  end
  object edtDescr: TEdit
    Left = 0
    Top = 216
    Width = 391
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 12
  end
  object edtVersion: TEdit
    Left = 0
    Top = 256
    Width = 393
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 13
  end
end
