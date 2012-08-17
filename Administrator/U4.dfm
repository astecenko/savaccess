object Frm4: TFrm4
  Left = 303
  Top = 65
  Width = 800
  Height = 480
  Caption = #1044#1086#1084#1077#1085
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  DesignSize = (
    792
    453)
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 8
    Top = 8
    Width = 76
    Height = 13
    Caption = #1053#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
  end
  object lbl2: TLabel
    Left = 8
    Top = 32
    Width = 181
    Height = 13
    Caption = #1048#1076#1077#1085#1090#1080#1092#1080#1082#1072#1090#1086#1088' '#1073#1077#1079#1086#1087#1072#1089#1085#1086#1089#1090#1080' (SID)'
  end
  object lbl3: TLabel
    Left = 8
    Top = 56
    Width = 70
    Height = 13
    Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
  end
  object edtCaption: TEdit
    Left = 88
    Top = 5
    Width = 414
    Height = 21
    MaxLength = 50
    TabOrder = 0
    OnChange = edtCaptionChange
  end
  object edtSID: TEdit
    Left = 192
    Top = 29
    Width = 289
    Height = 21
    MaxLength = 50
    TabOrder = 1
  end
  object pnl1: TPanel
    Left = 0
    Top = 78
    Width = 792
    Height = 324
    Align = alCustom
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 2
    object spl1: TSplitter
      Left = 153
      Top = 1
      Height = 322
    end
    object tv1: TTreeView
      Left = 1
      Top = 1
      Width = 152
      Height = 322
      Align = alLeft
      Indent = 19
      TabOrder = 0
    end
    object dbgrd1: TDBGrid
      Left = 156
      Top = 1
      Width = 635
      Height = 322
      Align = alClient
      DataSource = dsUserFiles
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnEditButtonClick = dbgrd1EditButtonClick
      Columns = <
        item
          Expanded = False
          FieldName = 'SRVRFILE'
          ReadOnly = True
          Title.Caption = #1060#1072#1081#1083
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CLNTFILE'
          Title.Caption = #1050#1083#1080#1077#1085#1090#1089#1082#1080#1081' '#1087#1091#1090#1100' ('#1096#1072#1073#1083#1086#1085#1099')'
          Width = 250
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EXT'
          Title.Caption = #1056#1072#1089#1096#1080#1088#1077#1085#1080#1077
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'TYPE'
          PickList.Strings = (
            'F'
            'D')
          Title.Caption = #1058#1080#1087
          Width = 35
          Visible = True
        end
        item
          ButtonStyle = cbsEllipsis
          Expanded = False
          FieldName = 'ACTION'
          Title.Caption = #1044#1077#1081#1089#1090#1074#1080#1077
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCR'
          Title.Caption = #1054#1087#1080#1089#1072#1085#1080#1077
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MD5'
          ReadOnly = True
          Visible = True
        end>
    end
  end
  object stat1: TStatusBar
    Left = 0
    Top = 434
    Width = 792
    Height = 19
    Panels = <>
  end
  object btnSave: TBitBtn
    Left = 536
    Top = 406
    Width = 115
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    TabOrder = 4
    Kind = bkOK
  end
  object btnClose: TBitBtn
    Left = 656
    Top = 406
    Width = 131
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 5
    OnClick = btnCloseClick
    Kind = bkCancel
  end
  object edtDescription: TEdit
    Left = 88
    Top = 53
    Width = 702
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    MaxLength = 250
    TabOrder = 6
  end
  object btnDelete: TBitBtn
    Left = 416
    Top = 406
    Width = 115
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #1059#1076#1072#1083#1080#1090#1100
    ModalResult = 7
    TabOrder = 7
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333FFFFF333333000033333388888833333333333F888888FFF333
      000033338811111188333333338833FFF388FF33000033381119999111833333
      38F338888F338FF30000339119933331111833338F388333383338F300003391
      13333381111833338F8F3333833F38F3000039118333381119118338F38F3338
      33F8F38F000039183333811193918338F8F333833F838F8F0000391833381119
      33918338F8F33833F8338F8F000039183381119333918338F8F3833F83338F8F
      000039183811193333918338F8F833F83333838F000039118111933339118338
      F3833F83333833830000339111193333391833338F33F8333FF838F300003391
      11833338111833338F338FFFF883F83300003339111888811183333338FF3888
      83FF83330000333399111111993333333388FFFFFF8833330000333333999999
      3333333333338888883333330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object btnFileAdd: TBitBtn
    Left = 0
    Top = 406
    Width = 33
    Height = 25
    Hint = #1044#1086#1073#1072#1074#1080#1090#1100' '#1092#1072#1081#1083#1099
    Action = actFileAdd
    Anchors = [akLeft, akBottom]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 8
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      33333333FF33333333FF333993333333300033377F3333333777333993333333
      300033F77FFF3333377739999993333333333777777F3333333F399999933333
      33003777777333333377333993333333330033377F3333333377333993333333
      3333333773333333333F333333333333330033333333F33333773333333C3333
      330033333337FF3333773333333CC333333333FFFFF77FFF3FF33CCCCCCCCCC3
      993337777777777F77F33CCCCCCCCCC3993337777777777377333333333CC333
      333333333337733333FF3333333C333330003333333733333777333333333333
      3000333333333333377733333333333333333333333333333333}
    NumGlyphs = 2
  end
  object btnFileEdit: TBitBtn
    Left = 40
    Top = 406
    Width = 33
    Height = 25
    Hint = #1054#1090#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1092#1072#1081#1083
    Action = actFileEdit
    Anchors = [akLeft, akBottom]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333000000
      000033333377777777773333330FFFFFFFF03FF3FF7FF33F3FF700300000FF0F
      00F077F777773F737737E00BFBFB0FFFFFF07773333F7F3333F7E0BFBF000FFF
      F0F077F3337773F3F737E0FBFBFBF0F00FF077F3333FF7F77F37E0BFBF00000B
      0FF077F3337777737337E0FBFBFBFBF0FFF077F33FFFFFF73337E0BF0000000F
      FFF077FF777777733FF7000BFB00B0FF00F07773FF77373377373330000B0FFF
      FFF03337777373333FF7333330B0FFFF00003333373733FF777733330B0FF00F
      0FF03333737F37737F373330B00FFFFF0F033337F77F33337F733309030FFFFF
      00333377737FFFFF773333303300000003333337337777777333}
    NumGlyphs = 2
  end
  object btnFileDelete: TBitBtn
    Left = 80
    Top = 406
    Width = 33
    Height = 25
    Hint = #1059#1076#1072#1083#1080#1090#1100' '#1092#1072#1081#1083
    Action = actFileDelete
    Anchors = [akLeft, akBottom]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 10
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333FF33333333333330003333333333333777333333333333
      300033FFFFFF3333377739999993333333333777777F3333333F399999933333
      3300377777733333337733333333333333003333333333333377333333333333
      3333333333333333333F333333333333330033333F33333333773333C3333333
      330033337F3333333377333CC3333333333333F77FFFFFFF3FF33CCCCCCCCCC3
      993337777777777F77F33CCCCCCCCCC399333777777777737733333CC3333333
      333333377F33333333FF3333C333333330003333733333333777333333333333
      3000333333333333377733333333333333333333333333333333}
    NumGlyphs = 2
  end
  object chkCopyCaption: TCheckBox
    Left = 486
    Top = 32
    Width = 20
    Height = 17
    Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1085#1072#1080#1084#1077#1085#1086#1074#1072#1085#1080#1077
    Checked = True
    ParentShowHint = False
    ShowHint = True
    State = cbChecked
    TabOrder = 11
  end
  object dbnvgr1: TDBNavigator
    Left = 120
    Top = 406
    Width = 280
    Height = 25
    DataSource = dsUserFiles
    Anchors = [akLeft, akRight, akBottom]
    TabOrder = 12
  end
  object dsUserFiles: TDataSource
    OnStateChange = dsUserFilesStateChange
    Left = 584
    Top = 6
  end
  object dlgOpen1: TOpenDialog
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofEnableSizing]
    Title = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1092#1072#1081#1083#1086#1074
    Left = 616
    Top = 8
  end
  object actlst1: TActionList
    Left = 552
    Top = 6
    object actFileEdit: TAction
      OnExecute = actFileEditExecute
    end
    object actFileAdd: TAction
      OnExecute = actFileAddExecute
    end
    object actFileDelete: TAction
      OnExecute = actFileDeleteExecute
    end
  end
end
