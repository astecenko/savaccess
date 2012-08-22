inherited Frm15: TFrm15
  Caption = 'Frm15'
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inherited dbnvgr1: TDBNavigator
    Hints.Strings = ()
  end
  object cbbGroupCn: TComboBox [16]
    Left = 512
    Top = 5
    Width = 273
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 13
    OnChange = cbbGroupCnChange
  end
  inherited dsUserFiles: TDataSource
    Left = 296
    Top = 78
  end
  inherited dlgOpen1: TOpenDialog
    Left = 232
    Top = 80
  end
  inherited actlst1: TActionList
    Left = 264
    Top = 78
  end
end
