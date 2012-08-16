inherited Frm5: TFrm5
  Caption = #1043#1088#1091#1087#1087#1072
  PixelsPerInch = 96
  TextHeight = 13
  object lbl4: TLabel [3]
    Left = 656
    Top = 8
    Width = 54
    Height = 13
    Anchors = [akTop, akRight]
    Caption = #1055#1088#1080#1086#1088#1080#1090#1077#1090
  end
  inherited edtCaption: TEdit
    Anchors = [akLeft, akTop, akRight]
  end
  inherited edtSID: TEdit
    Anchors = [akLeft, akTop, akRight]
  end
  inherited chkCopyCaption: TCheckBox
    Anchors = [akTop, akRight]
  end
  inherited dbnvgr1: TDBNavigator
    Hints.Strings = ()
  end
  object sePriority: TSpinEdit [17]
    Left = 712
    Top = 5
    Width = 73
    Height = 22
    Anchors = [akTop, akRight]
    MaxLength = 4
    MaxValue = 9999
    MinValue = 0
    TabOrder = 13
    Value = 0
  end
end
