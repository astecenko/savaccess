object Form1: TForm1
  Left = 192
  Top = 133
  Width = 373
  Height = 264
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object jvTray: TJvTrayIcon
    Active = True
    IconIndex = 0
    Hint = #1050#1083#1080#1077#1085#1090' '#1040#1057#1059#1055#13#10#1042#1077#1088#1089#1080#1103' 1.0'
    PopupMenu = pmMain
    Visibility = [tvVisibleTaskList, tvAutoHide]
  end
  object pmMain: TPopupMenu
    Left = 64
    object N2: TMenuItem
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1077
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N1: TMenuItem
      Action = actExit
    end
  end
  object actlst1: TActionList
    Left = 32
    object actExit: TAction
      Caption = #1042#1099#1093#1086#1076
      OnExecute = actExitExecute
    end
  end
end
