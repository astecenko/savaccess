object Form1: TForm1
  Left = 192
  Top = 133
  Width = 606
  Height = 395
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    598
    368)
  PixelsPerInch = 96
  TextHeight = 13
  object mmo1: TMemo
    Left = 0
    Top = 56
    Width = 593
    Height = 201
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
  end
  object btn1: TButton
    Left = 160
    Top = 8
    Width = 75
    Height = 25
    Caption = 'btn1'
    TabOrder = 1
    OnClick = btn1Click
  end
  object dbgrd1: TDBGrid
    Left = 0
    Top = 264
    Width = 598
    Height = 102
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = ds1
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object jvTray: TJvTrayIcon
    Active = True
    IconIndex = 0
    Hint = #1050#1083#1080#1077#1085#1090' '#1040#1057#1059#1055#13#10#1042#1077#1088#1089#1080#1103' 1.0'
    PopupMenu = pmMain
    Visibility = [tvVisibleTaskList, tvAutoHide, tvRestoreDbClick, tvMinimizeDbClick]
  end
  object pmMain: TPopupMenu
    Left = 64
    object N4: TMenuItem
      Caption = #1054#1090#1082#1088#1099#1090#1100
      OnClick = N4Click
    end
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
  object ds1: TDataSource
    Left = 96
  end
  object ds2: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 128
  end
end
