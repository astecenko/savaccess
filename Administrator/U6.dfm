inherited Frm6: TFrm6
  Hint = #1042#1099#1073#1086#1088' '#1080#1079' '#1076#1086#1084#1077#1085#1072
  Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1100
  ShowHint = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited edtCaption: TEdit
    Anchors = [akLeft, akTop, akRight]
  end
  inherited edtSID: TEdit
    Anchors = [akLeft, akTop, akRight]
  end
  inherited chkCopyCaption: TCheckBox
    Anchors = [akTop, akRight]
  end
  object btnSelectUser: TBitBtn
    Left = 504
    Top = 4
    Width = 33
    Height = 22
    Anchors = [akTop, akRight]
    TabOrder = 12
    OnClick = btnSelectUserClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000333300
      0000377777F3337777770FFFF099990FFFF07FFFF7FFFF7FFFF7000000999900
      00007777777777777777307703399330770337FF7F37F337FF7F300003399330
      000337777337F337777333333339933333333FFFFFF7F33FFFFF000000399300
      0000777777F7F37777770FFFF099990FFFF07FFFF7F7FF7FFFF7000000999900
      00007777777777777777307703399330770337FF7F37F337FF7F300003399330
      0003377773F7FFF77773333330000003333333333777777F3333333330FFFF03
      3333333337FFFF7F333333333000000333333333377777733333333333077033
      33333333337FF7F3333333333300003333333333337777333333}
    NumGlyphs = 2
  end
  object edtDomain: TEdit
    Left = 632
    Top = 5
    Width = 158
    Height = 21
    Hint = #1044#1086#1084#1077#1085
    Anchors = [akTop, akRight]
    ReadOnly = True
    TabOrder = 13
  end
end
