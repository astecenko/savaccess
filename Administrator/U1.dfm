object Frm1: TFrm1
  Left = 353
  Top = 104
  Width = 800
  Height = 480
  Caption = 'SAV Access - '#1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088
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
  object stat1: TStatusBar
    Left = 0
    Top = 434
    Width = 792
    Height = 19
    Panels = <>
  end
  object actmmb1: TActionMainMenuBar
    Left = 0
    Top = 0
    Width = 792
    Height = 24
    ActionManager = actmgr1
    Caption = 'actmmb1'
    ColorMap.HighlightColor = 14410210
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = 14410210
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Spacing = 0
  end
  object pgc1: TPageControl
    Left = 144
    Top = 24
    Width = 648
    Height = 410
    ActivePage = tsUsers
    Align = alClient
    TabOrder = 2
    object tsUsers: TTabSheet
      Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
      ImageIndex = 1
      object spl2: TSplitter
        Left = 0
        Top = 277
        Width = 640
        Height = 3
        Cursor = crVSplit
        Align = alBottom
      end
      object pnl4: TPanel
        Left = 0
        Top = 0
        Width = 640
        Height = 277
        Align = alClient
        TabOrder = 0
        DesignSize = (
          640
          277)
        object btn3: TSpeedButton
          Left = 34
          Top = 2
          Width = 31
          Height = 23
          Hint = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072' '#1074' '#1072#1083#1092#1072#1074#1080#1090#1085#1086#1084' '#1087#1086#1088#1103#1076#1082#1077' '#1086#1090' '#1040' '#1076#1086' '#1071
          GroupIndex = 2
          Caption = #1040#1083#1092
          ParentShowHint = False
          ShowHint = True
          OnClick = btn3Click
        end
        object btn4: TSpeedButton
          Left = 65
          Top = 2
          Width = 31
          Height = 23
          Hint = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072' '#1087#1086' '#1085#1086#1084#1077#1088#1091' '#1074#1077#1088#1089#1080#1080
          GroupIndex = 2
          Caption = #1042#1077#1088#1089
          ParentShowHint = False
          ShowHint = True
          OnClick = btn4Click
        end
        object btn8: TSpeedButton
          Left = 2
          Top = 2
          Width = 31
          Height = 23
          Hint = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072' '#1074' '#1072#1083#1092#1072#1074#1080#1090#1085#1086#1084' '#1087#1086#1088#1103#1076#1082#1077' '#1086#1090' '#1040' '#1076#1086' '#1071
          GroupIndex = 2
          Down = True
          Caption = 'ID'
          ParentShowHint = False
          ShowHint = True
          OnClick = btn8Click
        end
        object dbgrdUser: TDBGrid
          Left = 3
          Top = 27
          Width = 634
          Height = 246
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = dtmdl1.dsUsers
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDblClick = dbgrdUserDblClick
        end
      end
      object pnl5: TPanel
        Left = 0
        Top = 280
        Width = 640
        Height = 102
        Align = alBottom
        TabOrder = 1
        DesignSize = (
          640
          102)
        object chklstUserGroups: TCheckListBox
          Left = 3
          Top = 3
          Width = 246
          Height = 96
          Anchors = [akLeft, akTop, akBottom]
          ItemHeight = 13
          TabOrder = 0
        end
        object btnGroupAdd: TBitBtn
          Left = 256
          Top = 5
          Width = 25
          Height = 25
          Hint = #1042#1082#1083#1102#1095#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1074' '#1075#1088#1091#1087#1087#1091
          Caption = '+'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = btnGroupAddClick
          NumGlyphs = 2
        end
        object btnGroupDel: TBitBtn
          Left = 256
          Top = 37
          Width = 25
          Height = 25
          Hint = #1048#1089#1082#1083#1102#1095#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1080#1079' '#1075#1088#1091#1087#1087#1099
          Caption = '-'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = btnGroupDelClick
        end
        object btnGroupGoTo: TBitBtn
          Left = 256
          Top = 69
          Width = 25
          Height = 25
          Hint = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1075#1088#1091#1087#1087#1077
          Caption = '=>'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = btnGroupGoToClick
        end
      end
    end
    object tsGroups: TTabSheet
      Caption = #1043#1088#1091#1087#1087#1099
      ImageIndex = 2
      object spl1: TSplitter
        Left = 0
        Top = 277
        Width = 640
        Height = 3
        Cursor = crVSplit
        Align = alBottom
      end
      object btn1: TSpeedButton
        Left = 312
        Top = 184
        Width = 23
        Height = 22
      end
      object pnl2: TPanel
        Left = 0
        Top = 280
        Width = 640
        Height = 102
        Align = alBottom
        TabOrder = 0
        DesignSize = (
          640
          102)
        object btnUserAdd: TBitBtn
          Left = 256
          Top = 5
          Width = 25
          Height = 25
          Hint = #1042#1082#1083#1102#1095#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1074' '#1075#1088#1091#1087#1087#1091
          Caption = '+'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = btnUserAddClick
          NumGlyphs = 2
        end
        object btnUserDel: TBitBtn
          Left = 256
          Top = 37
          Width = 25
          Height = 25
          Hint = #1048#1089#1082#1083#1102#1095#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103' '#1080#1079' '#1075#1088#1091#1087#1087#1099
          Caption = '-'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = btnUserDelClick
        end
        object chklstGroupUsers: TCheckListBox
          Left = 2
          Top = 2
          Width = 249
          Height = 97
          OnClickCheck = chklstGroupUsersClickCheck
          Anchors = [akLeft, akTop, akBottom]
          ItemHeight = 13
          TabOrder = 2
        end
        object btnUserGoTo: TBitBtn
          Left = 256
          Top = 69
          Width = 25
          Height = 25
          Hint = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1102
          Caption = '=>'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 3
          OnClick = btnUserGoToClick
        end
        object lst1: TListBox
          Left = 352
          Top = 24
          Width = 121
          Height = 97
          ItemHeight = 13
          TabOrder = 4
        end
      end
      object pnl3: TPanel
        Left = 0
        Top = 0
        Width = 640
        Height = 277
        Align = alClient
        TabOrder = 1
        DesignSize = (
          640
          277)
        object btn5: TSpeedButton
          Left = 65
          Top = 2
          Width = 31
          Height = 23
          Hint = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072' '#1087#1086' '#1085#1086#1084#1077#1088#1091' '#1074#1077#1088#1089#1080#1080
          GroupIndex = 3
          Caption = #1042#1077#1088#1089
          ParentShowHint = False
          ShowHint = True
          OnClick = btn5Click
        end
        object btn6: TSpeedButton
          Left = 34
          Top = 2
          Width = 31
          Height = 23
          Hint = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072' '#1074' '#1072#1083#1092#1072#1074#1080#1090#1085#1086#1084' '#1087#1086#1088#1103#1076#1082#1077' '#1086#1090' '#1040' '#1076#1086' '#1071
          GroupIndex = 3
          Caption = #1040#1083#1092
          ParentShowHint = False
          ShowHint = True
          OnClick = btn6Click
        end
        object btn9: TSpeedButton
          Left = 2
          Top = 2
          Width = 31
          Height = 23
          Hint = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072' '#1074' '#1072#1083#1092#1072#1074#1080#1090#1085#1086#1084' '#1087#1086#1088#1103#1076#1082#1077' '#1086#1090' '#1040' '#1076#1086' '#1071
          GroupIndex = 3
          Down = True
          Caption = 'ID'
          ParentShowHint = False
          ShowHint = True
          OnClick = btn9Click
        end
        object dbgrdGroup: TDBGrid
          Left = 3
          Top = 25
          Width = 633
          Height = 248
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = dtmdl1.dsGroups
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDblClick = dbgrdGroupDblClick
          Columns = <
            item
              Expanded = False
              FieldName = 'NAME'
              Title.Caption = #1043#1088#1091#1087#1087#1072
              Width = 180
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCR'
              Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1080
              Width = 300
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ID'
              ReadOnly = True
              Width = 50
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'PRIORITY'
              Title.Caption = #1055#1088#1080#1086#1088#1080#1090#1077#1090
              Visible = True
            end>
        end
      end
    end
    object tsADGroups: TTabSheet
      Caption = #1043#1088#1091#1087#1087#1099' '#1076#1086#1084#1077#1085#1072
      ImageIndex = 2
      object spl3: TSplitter
        Left = 0
        Top = 277
        Width = 640
        Height = 3
        Cursor = crVSplit
        Align = alBottom
      end
      object pnl6: TPanel
        Left = 0
        Top = 280
        Width = 640
        Height = 102
        Align = alBottom
        TabOrder = 0
        DesignSize = (
          640
          102)
        object lstADGroupUsers: TListBox
          Left = 2
          Top = 2
          Width = 247
          Height = 97
          Anchors = [akLeft, akTop, akRight, akBottom]
          ItemHeight = 13
          TabOrder = 0
        end
      end
      object pnl7: TPanel
        Left = 0
        Top = 0
        Width = 640
        Height = 277
        Align = alClient
        TabOrder = 1
        DesignSize = (
          640
          277)
        object btn2: TSpeedButton
          Left = 34
          Top = 2
          Width = 31
          Height = 23
          Hint = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072' '#1074' '#1072#1083#1092#1072#1074#1080#1090#1085#1086#1084' '#1087#1086#1088#1103#1076#1082#1077' '#1086#1090' '#1040' '#1076#1086' '#1071
          GroupIndex = 4
          Caption = #1040#1083#1092
          ParentShowHint = False
          ShowHint = True
          OnClick = btn2Click
        end
        object btn7: TSpeedButton
          Left = 65
          Top = 2
          Width = 31
          Height = 23
          Hint = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072' '#1087#1086' '#1085#1086#1084#1077#1088#1091' '#1074#1077#1088#1089#1080#1080
          GroupIndex = 4
          Caption = #1042#1077#1088#1089
          ParentShowHint = False
          ShowHint = True
          OnClick = btn7Click
        end
        object btn10: TSpeedButton
          Left = 2
          Top = 2
          Width = 31
          Height = 23
          Hint = #1057#1086#1088#1090#1080#1088#1086#1074#1082#1072' '#1074' '#1072#1083#1092#1072#1074#1080#1090#1085#1086#1084' '#1087#1086#1088#1103#1076#1082#1077' '#1086#1090' '#1040' '#1076#1086' '#1071
          GroupIndex = 4
          Down = True
          Caption = 'ID'
          ParentShowHint = False
          ShowHint = True
          OnClick = btn10Click
        end
        object dbgrdADGroups: TDBGrid
          Left = 3
          Top = 32
          Width = 633
          Height = 241
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = dtmdl1.dsADGroups
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          OnDblClick = dbgrdADGroupsDblClick
          Columns = <
            item
              Expanded = False
              FieldName = 'NAME'
              Title.Caption = #1043#1088#1091#1087#1087#1072
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'DESCR'
              Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
              Width = 150
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ID'
              Visible = False
            end
            item
              Expanded = False
              FieldName = 'SID'
              Width = 265
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'VERSION'
              Title.Caption = #1042#1077#1088#1089#1080#1103
              Width = 90
              Visible = True
            end>
        end
      end
    end
  end
  object pnl1: TPanel
    Left = 0
    Top = 24
    Width = 144
    Height = 410
    Align = alLeft
    TabOrder = 3
    DesignSize = (
      144
      410)
    object dbgrdDomain: TDBGrid
      Left = 1
      Top = 2
      Width = 140
      Height = 295
      Anchors = [akLeft, akTop, akBottom]
      DataSource = dtmdl1.dsDomain
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = dbgrdDomainDblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'NAME'
          Title.Alignment = taCenter
          Title.Caption = #1044#1086#1084#1077#1085#1099
          Width = 105
          Visible = True
        end>
    end
    object dbmmoDESCR: TDBMemo
      Left = 4
      Top = 306
      Width = 135
      Height = 95
      Anchors = [akLeft, akBottom]
      DataField = 'DESCR'
      DataSource = dtmdl1.dsDomain
      TabOrder = 1
    end
  end
  object actmgr1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Items = <
              item
                Action = act1
                ImageIndex = 0
              end
              item
                Action = actCreateBase
                ImageIndex = 1
              end
              item
                Action = actBaseSaveAs
                ImageIndex = 2
              end
              item
                Action = actBaseProperty
                ImageIndex = 16
              end
              item
                Caption = '-'
              end
              item
                Action = flxt1
                ImageIndex = 17
              end>
            Caption = #1061#1088#1072#1085#1080#1083#1080#1097#1077
          end
          item
            Items = <
              item
                Action = actDomainAdd
                ImageIndex = 4
              end
              item
                Action = actDomainEdit
              end
              item
                Action = actDomainDelete
                ImageIndex = 3
              end
              item
                Action = actDomainShow
              end>
            Caption = #1044#1086#1084#1077#1085
          end
          item
            Items = <
              item
                Action = actGroupAdd
                ImageIndex = 9
              end
              item
                Action = actGroupEdit
                ImageIndex = 11
              end
              item
                Action = actGroupDelete
                ImageIndex = 12
              end
              item
                Action = actGroupShow
                ImageIndex = 10
              end
              item
                Caption = '-'
              end
              item
                Action = actADGroupAdd
              end
              item
                Action = actADGroupEdit
              end>
            Caption = #1043#1088#1091#1087#1087#1072
          end
          item
            Items = <
              item
                Action = actUserAdd
                ImageIndex = 6
              end
              item
                Action = actUserDelete
                ImageIndex = 8
              end
              item
                Action = actUserEdit
                ImageIndex = 7
              end
              item
                Action = actUserShow
                ImageIndex = 5
              end
              item
                Caption = '-'
              end
              item
                Action = actRemoteUser
              end>
            Caption = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
          end
          item
            Items = <
              item
                Action = actExtDict
              end
              item
                Action = actTemplat
              end
              item
                Action = actSupport
              end
              item
                Action = actAD1
                Caption = '&Active Directory'
              end
              item
                Caption = '-'
              end
              item
                Action = act2
              end>
            Caption = #1057#1077#1088#1074#1080#1089
          end>
        ActionBar = actmmb1
      end>
    Images = il1
    Left = 616
    Top = 16
    StyleName = 'XP Style'
    object act1: TAction
      Category = #1061#1088#1072#1085#1080#1083#1080#1097#1077
      Caption = #1054#1090#1082#1088#1099#1090#1100
      ImageIndex = 0
      OnExecute = act1Execute
    end
    object actCreateBase: TAction
      Category = #1061#1088#1072#1085#1080#1083#1080#1097#1077
      Caption = #1057#1086#1079#1076#1072#1090#1100'...'
      ImageIndex = 1
      OnExecute = actCreateBaseExecute
    end
    object actBaseSaveAs: TAction
      Category = #1061#1088#1072#1085#1080#1083#1080#1097#1077
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1072#1082'...'
      ImageIndex = 2
      OnExecute = actBaseSaveAsExecute
    end
    object flxt1: TFileExit
      Category = #1061#1088#1072#1085#1080#1083#1080#1097#1077
      Caption = #1042#1099#1093#1086#1076
      Hint = #1042#1099#1093#1086#1076'|'#1042#1099#1081#1090#1080' '#1080#1079' '#1087#1088#1086#1075#1088#1072#1084#1084#1099
      ImageIndex = 17
    end
    object actUserAdd: TAction
      Category = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      ImageIndex = 6
      OnExecute = actUserAddExecute
    end
    object actUserDelete: TAction
      Category = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      ImageIndex = 8
    end
    object actUserEdit: TAction
      Category = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      ImageIndex = 7
      OnExecute = actUserEditExecute
    end
    object actUserShow: TAction
      Category = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
      ImageIndex = 5
    end
    object actGroupAdd: TAction
      Category = #1043#1088#1091#1087#1087#1072
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
      ImageIndex = 9
      OnExecute = actGroupAddExecute
    end
    object actGroupEdit: TAction
      Category = #1043#1088#1091#1087#1087#1072
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1075#1088#1091#1087#1087#1091
      ImageIndex = 11
      OnExecute = actGroupEditExecute
    end
    object actGroupDelete: TAction
      Category = #1043#1088#1091#1087#1087#1072
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
      ImageIndex = 12
    end
    object actGroupShow: TAction
      Category = #1043#1088#1091#1087#1087#1072
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1075#1088#1091#1087#1087#1099
      ImageIndex = 10
    end
    object actDomainAdd: TAction
      Category = #1044#1086#1084#1077#1085
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1076#1086#1084#1077#1085
      ImageIndex = 4
      OnExecute = actDomainAddExecute
    end
    object actDomainEdit: TAction
      Category = #1044#1086#1084#1077#1085
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1088#1072#1074#1080#1083#1072' '#1076#1086#1084#1077#1085#1072
      OnExecute = actDomainEditExecute
    end
    object actDomainDelete: TAction
      Category = #1044#1086#1084#1077#1085
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1076#1086#1084#1077#1085
      ImageIndex = 3
    end
    object actDomainShow: TAction
      Category = #1044#1086#1084#1077#1085
      Caption = #1055#1088#1086#1089#1084#1086#1090#1088' '#1076#1086#1084#1077#1085#1072
    end
    object actTemplat: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1056#1077#1076#1072#1082#1090#1086#1088' '#1096#1072#1073#1083#1086#1085#1086#1074
      OnExecute = actTemplatExecute
    end
    object actBaseProperty: TAction
      Category = #1061#1088#1072#1085#1080#1083#1080#1097#1077
      Caption = #1057#1074#1086#1081#1089#1090#1074#1072
      ImageIndex = 16
      OnExecute = actBasePropertyExecute
    end
    object actExtDict: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1076#1077#1081#1089#1090#1074#1080#1081
      OnExecute = actExtDictExecute
    end
    object actSupport: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1055#1086#1076#1076#1077#1088#1078#1082#1072' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
      OnExecute = actSupportExecute
    end
    object actADGroupAdd: TAction
      Category = #1043#1088#1091#1087#1087#1072
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1076#1086#1084#1077#1085#1085#1091#1102' '#1075#1088#1091#1087#1087#1091
      OnExecute = actADGroupAddExecute
    end
    object actAD1: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = 'Active Directory'
      OnExecute = actAD1Execute
    end
    object act2: TAction
      Category = #1057#1077#1088#1074#1080#1089
      Caption = #1042#1088#1077#1084#1077#1085#1085#1072#1103
    end
    object actADGroupEdit: TAction
      Category = #1043#1088#1091#1087#1087#1072
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1076#1086#1084#1077#1085#1085#1091#1102' '#1075#1088#1091#1087#1087#1091
      OnExecute = actADGroupEditExecute
    end
    object actRemoteUser: TAction
      Category = #1055#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1080
      Caption = #1052#1077#1085#1077#1076#1078#1077#1088#1099
      OnExecute = actRemoteUserExecute
    end
  end
  object il1: TImageList
    Left = 580
    Top = 16
    Bitmap = {
      494C010112001400040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000005000000001002000000000000050
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CBCBCB00CBCBCB00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000DBDBDB00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCB
      CB00CBCBCB00396EA1003B6E9E00ACB7C1000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BE9D7800B8895600B88A
      5700B8895500B6855000B6854E00B9875100BD8B5400BF8C5500C08D5500CA8F
      4F002C6CA90029B2FF0044C8FF003A83CC000000000000000000D8D8D8009A9A
      AD0032327D009D9DB100DADADA000000000000000000DDDDDD009E9EB1003232
      7D009A9AAD00D7D7D70000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CBCBCB00BC884E00FFDFAA00BC8D
      5800B5844F00FFFBEE00FFF8EA00D4CDC50074777C005E636D0060646D006868
      6B007F736C003AC6FF0055DBFF003880CB000000000000000000B6B6CF003232
      8C001111D80032328C00B6B6CF000000000000000000B6B6CF0032328C001111
      D80032328C00B6B6CF0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008D8D9000C5CAD10057616E00C697
      5E00B4834C00FFF7E800D1C5B90069686900E4C58F00FFEDA700FFF5B100E8D5
      A30076716D009D9088002A7FD700000000000000000000000000323299001111
      D0001111D0001111D00032329900B6B6DA00B6B6DA00323299001111D0001111
      D0001111D0003232990000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BF894D00AB7A3E00CB9F
      6500B4824C00FFF8E90078777A00E3BF8600FFE6A500FFE7A600FFEFB300FFF9
      BB00E8D6A30078787B00C88C4B00000000000000000000000000B6B6DB003232
      9D001111C4001111C4001111C40032329D0032329D001111C4001111C4001111
      C40032329D00B6B6DB0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CBCBCB00BD874C00FFDFA400D0A5
      6800B4824B00FFF9EA006A6D7300FFE19E00FFEFCA00FFE7B300FFE9AB00FFEF
      B200FFF4B00071757D00BF8C530000000000000000000000000000000000B6B6
      DD003232A2001111B8001111B8001111B8001111B8001111B8001111B8003232
      A200B6B6DD000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008E8D8F00C5C9D100565F6D00D9AE
      6F00B4814B00FFF9EB0070727800FFDD9800FFF7E400FFEDC800FFE7B200FFE6
      A500FFEBA50075798200BD8B5400000000000000000000000000000000000000
      0000B6B6DE003232A6001515AF001111AC001111AC001111AC003232A600B6B6
      DE00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BF884D00A67B3A00DEB5
      7600B2804A00FFF9EA0086858500E7BC7D00FFF5DC00FFF7E400FFEECA00FFE5
      A400E8C993008B8E9300BB895200000000000000000000000000000000000000
      0000B6B6E0003232AA002525B4001111A2001111A2001414A5003232AA00B6B6
      E000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CBCBCB00BD874C00FFE09E00E3BB
      7A00B17F4900FFF7EA00D3C0AC0082818100E8BC7E00FFDC9700FFDF9C00E8C4
      8B0083828400DED7D000B887500000000000000000000000000000000000B6B6
      E1003232AD005353DB002E2EB7003D3DC6003131BA0015159F001E1EA8003232
      AD00B6B6E1000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008E8D9000C5C9D100555D6C00EBC4
      7F00B17E4900FFF6EB00F7D9B900D9D1C90092959B0081848B0080848B008F8E
      8F00D4C0AA00FFFBEF00B5844D00000000000000000000000000B6B6E2003232
      B1006767EF003636BE005E5EE6003232B1003232B1004F4FD7003636BE004545
      CD003232B100B6B6E20000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BF884D00A57C3500ECC5
      8100B07E4900FFF8EE00F2D4B200F5D8B600F9DCBB00FADDBC00F9DCBB00F7D9
      B800F4D6B400FFFAF000B4834C000000000000000000000000003232B3007676
      FE004C4CD4007272FA003232B300B6B6E300B6B6E3003232B3006262EA004C4C
      D4005C5CE4003232B30000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CBCBCB00BD874C00F9D08B00EBC4
      7F00B07D4800FFFBF200EFD1AD00F1D5B200AC794000D0A87B00CEA67900F1D4
      B100EFD1AD00FFFBF300B4824C00000000000000000000000000B6B6E4003232
      B7007777FF003232B700B6B6E4000000000000000000B6B6E4003232B7007070
      F8003232B700B6B6E40000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000008D8D9000C3C8CF00525A6700EBC3
      7B00B07D4600FFFDF800EECCA600EFCEA900F0D1AC00F0D1AC00F0CFAB00EECD
      A800EECCA600FFFEF900B4834C0000000000000000000000000000000000B6B6
      E5003232B900B6B6E50000000000000000000000000000000000B6B6E5003232
      B900B6B6E5000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BC864B00FFF2D400FEF1
      D400B27F4900FFFFFF00FFFEFA00FFFEFA00FFFFFB00FFFFFB00FFFEFA00FFFE
      FA00FFFEFA00FFFFFF00B5844F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CEAD8900B7875200B686
      5200B7875200B5844E00B4824C00B4824B00B4824B00B4824B00B4824B00B482
      4B00B4824C00B5844F00CCAC8800000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CCCCCC00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CCCCCC000000000000000000CBCB
      CB00CBCBCB00CBCBCB00000000000000000000000000CCCCCC00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CDCDCD0000000000CBCBCB00CBCB
      CB00DCDCDC0000000000000000000000000000000000CCCCCC00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CDCDCD0000000000CBCBCB00CBCB
      CB000000000000000000000000000000000000000000CCCCCC00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00C1A99500A7550E00A7530B00A752
      0A00A7520A00A7520A00A7520A00A7530A00AC570A00C7B19C007283D400364D
      CE00384DCB00384DCC007281CA0000000000C1A99500A7550E00A7530B00A752
      0A00A7520A00A7520A00A9530A00AA530B00AE551000CAB2A300008F4F0000CC
      8B00419C7000DDDDDD000000000000000000C1A99500A7550E00A7530B00A752
      0A00A7520A00A7530A00A9530900AD540800AF550A00C5B1A0006C6A69006C6A
      690000000000CBCBCB00CBCBCB0000000000C1A99500A7550E00A7530B00A952
      0800B34F00002C8EE8003788D6003985D2003985D2003985D2003986D3003985
      D2003985D2003985D2003A87D4003B8AD600B25F1800D8995D00E3A97100E3A8
      7000E3A77000E3A77000E3A87000E4A97000E19B530068527D003050E100375D
      FA00375DFA00385DF9003852D700717FCA00B25F1800D8995D00E3A97100E3A8
      7000E3A77000E7A87000F1A97200F8AA7300F1995F00D25C1800008B4B0000E4
      A60000BE8000479F7400CDCDCD0000000000B25F1800D8995D00E3A97100E3A8
      7000E3A77000E4A87000E9A96E0073716F0077757300D8D7D600999796009997
      9600A1A0A0007775730073716F0000000000B25F1800D8995D00E3A97100E4A7
      6E00EFA764003289DD0042D4FF0048DBFF0048DAFF0048DBFF0047DDFF0048DB
      FF0048DAFF0049DBFF0048D6FF003A89D800C2793700EAC09700E1A26100E19F
      5C00E19D5900E19D5900E19F5D00E3A35F00F6C489001F40D8003D63FF003B5F
      FA00395DF8003B5FFA004165FB00344BCC00C2793700EAC09700E1A26100E19F
      5C00E39D5A00EF9F5B00438F4C000089470000894800008A49000084430000D9
      A20000D8A00000BC800012855200A2B4B100C2793700EAC09700E1A26100E19F
      5C00E19D5900E39E5900E9A25B007F7D7B00D5D3D20086848300D5D3D200D5D3
      D20086848300D5D3D20078767500CBCBCB00C2793700EAC09700E1A26100E29F
      5B00E99D5300B59678003096E30050DDFF0051D9FF0050DCFF007047390050DC
      FF0051D9FF0053DEFF003F9AE4007BA3B400CF8D4F00F1D6BC00F0B77600F0B9
      7B00F5F9FD00EBEFF200F0B97900F3B97500FFDBAE001E3BD100A4B6FF00FFFF
      FF00FFFFFF00FFFFFF00A8B8FF003147CB00CF8D4F00F1D6BC00F0B77600F0B9
      7B00F8FAFE00FFF3F70000823B003AE7C00000D7A00000D7A10000D69F0000D0
      9C0000D09C0000D39F0000B97E0010885500CF8D4F00F1D6BC00F0B77600F0B9
      7B00F6FAFD00EEF2F300FFFFFF00D8D7D60087858400D5D3D200817F7D00817F
      7D00D5D3D20087858400D8D7D60026826D00CF8D4F00F1D6BC00F0B77600F0B9
      7A00F9FAFB00FAF1E8005B8EC0004BC3F5005DE0FF005CE2FF0060C0DA005CE2
      FF005EE1FF0052C5F8003D8CC40033816400D0884300F1DBC500FBE6CE00FFF8
      EA00FFFEFE00F6F5F300F0E4D300FFE8CC00FFDFB6001F3AD2006C86FF008A9E
      FF00869BFE008A9EFF007089FF003246CF00D0884300F1DBC500FBE6CE00FFF8
      EA00FFFFFF00FFF8FA00008137006CE7CE0000C8990000C8990000C7990000C7
      970000C8980000CA9A0060E6CB0000894500D0884300F1DBC500FBE6CE00FFF8
      EA00FFFFFE00FAF9F600716F6D00A19F9E00D5D3D20083807F0025A36D0025A3
      6E0083807F00D5D3D200A09E9D007B797700D0884300F1DBC500FBE6CE00FFF8
      EA00FFFFFD00FCF6F000E6DED400398BD90063E2FF0067EBFF006B4A410068EB
      FF0066E2FF003686D4006FBDA00031856D0000000000DD9F6200EEBA8600AFC7
      CE005D9FC3003C7CA00076848800F9BA8200B7954200316FA4003B53DF006A83
      FF006F87FF006C84FF004357E3003468A40000000000DD9F6200EEBA8600AFC7
      CE005FA0C4004B7DA5000086380094EEDF004BE7D1004DE6D0004BE5CF0092E7
      D60000C296005DDEC40014C59C00058A4F0000000000DD9F6200EEBA8600AFC7
      CE005DA0C3003E7EA10072706E00A3A09F00D5D3D20086848000FFFFFF00F3F6
      F30086848000D5D3D200A19F9E007C7A780000000000DD9F6200EEBA8600AFC7
      CE005DA0C3003E7C9F0080878400A8A0A0004AB1EE0075F6FF00694D440076F6
      FF004EB0EE00349AA00096DBB800308673000000000000000000F8ECE00094A8
      A80067A3C4005089A9005E737000A4CAA10089E6C400E0FFE5008892DF002B3F
      CE003D50DB002F3FD2005882C600349270000000000000000000F8ECE00094A8
      A80068A3C4005989AD0000854A0019A26600159F6300159D6200149A60007FE3
      D30057D8C10012BF9800028C5100378C7A000000000000000000F8ECE00094A8
      A80067A3C400518AA9005C787900D8D7D6008C8A8800D5D3D200878584008785
      8400D5D3D2008C8A8800D8D7D60043897A000000000000000000F8ECE00094A8
      A80067A3C4005189A90062746E00AECD9A00509EDA0072E7FF006A4E430073E8
      FF005398D40099E7BF009BDEC400308876000000000000000000C2C8CD0078BD
      E2007FC0E30071AFD2005A97BF004190890063BAA1009DCBD8006EA9C300518A
      9F004C76930070C6A20056A58E00000000000000000000000000C2C8CD0078BD
      E2007FC0E30074AFD3005D98BD003A927E003B9F7E0069B1B20000843A0076E1
      D2000FBB9800018D500059A29200000000000000000000000000C2C8CD0078BD
      E2007FC0E30070AFD2005395BE0086848100D5D3D2008D8B8900D5D3D200D5D3
      D2008D8B8900D5D3D2007F7D7B00000000000000000000000000C2C8CD0078BD
      E2007FC0E30071AFD2005A97BF00459288004EA59C00439BE70087D9DE00429C
      E700568297006BBBA300549E9000000000000000000000000000143C6C00A7EF
      FF008ED1F0007EBFDE0076B3D50026417100000000006AA6B4006EA5C400578C
      A900427A8600DDEBE70000000000000000000000000000000000143C6C00A7EF
      FF008ED1F0007FBFDF0077B3D700294172000000000076A7BF00008636000DBA
      9800148F5300DBEAE60000000000000000000000000000000000143C6C00A7EF
      FF008ED1F0007DBEDE006CAFD4007A78760087858300D8D7D600A9A7A500A9A7
      A500D8D7D600878583007B797700000000000000000000000000143C6C00A7EF
      FF008ED1F0007EBFDE0076B3D5002641710000000000488DBA0048A4E6004589
      C20042788400DDEBE700000000000000000000000000000000000A3A6A0069AA
      CE0079B3D6008CCCEC0080BFE00007235600D5D5D5007FBFE10081C1E20072B0
      D1005F99BF00C4C8CD00000000000000000000000000000000000A3A6A0069AA
      CE0079B3D6008CCCEC0080BFE00007235600D5D5D50084C0E60062B4BD0057A9
      B6005D96BA00C4C8CD00000000000000000000000000000000000A3A6A0069AA
      CE0079B3D6008BCBEB007BBDDF00243B6000B8BDC10076C0E600767472007674
      72005399C200D1D1D100000000000000000000000000000000000A3A6A0069AA
      CE0079B3D6008CCCEC0080BFE00007235600D5D5D50083C0E00070B4DF0075B0
      D0005F99BE00C4C8CD0000000000000000000000000000000000114374002D77
      A9004E89B700517AA500334F7B000D2C5C002B4E7700A8EFFF008FD1F0007FBF
      DE0076B4D500183B690000000000000000000000000000000000114374002D77
      A9004E89B700517AA500334F7B000D2C5C002B4E7700AAF0FF0091D1F30082BF
      E10078B4D7001A3B690000000000000000000000000000000000114374002D77
      A9004E89B700517AA500324E7A000A2A5C002C507900A6F1FF008EC1D70082B3
      CA0072B4D800193A6B0000000000000000000000000000000000114374002D77
      A9004E89B700517AA500334F7B000D2C5C002B4E7700A9F0FF0090D1F00080BF
      DE0077B4D500183B690000000000000000000000000000000000113F6E00287B
      AE00418ABA00407CAB00254A7700284872000A3B6B0069ABCE0079B5D6008CCC
      EC0081C0E0000B2B5B0000000000000000000000000000000000113F6E00287B
      AE00418ABA00407CAB00254A7700284872000A3B6B0069ABCE0079B5D7008DCC
      EC0081C0E1000B2B5B0000000000000000000000000000000000113F6E00287B
      AE00418ABA00407CAB00254A7700264672000A3B6B0068ABCF0079B6D9008BCD
      EE0080C0E10008295A0000000000000000000000000000000000113F6E00287B
      AE00418ABA00407CAB00254A7700284872000A3B6B0069ABCE0079B5D6008CCC
      EC0081C0E0000B2B5B0000000000000000000000000000000000DDE5EB001549
      79001E6293001D5787001944720000000000114474002D78A9004E89B700517A
      A50033507B001031600000000000000000000000000000000000DDE5EB001549
      79001E6293001D5787001944720000000000114474002D78A9004E89B700517A
      A50033507B001031600000000000000000000000000000000000DDE5EB001549
      79001E6293001D5787001944720000000000114474002D78A9004E89B700517A
      A50033507B001031600000000000000000000000000000000000DDE5EB001549
      79001E6293001D5787001944720000000000114474002D78A9004E89B700517A
      A50033507B001031600000000000000000000000000000000000000000000000
      00000000000000000000000000000000000015416F00287BAE004089BA00407C
      AB00244A77001135660000000000000000000000000000000000000000000000
      00000000000000000000000000000000000015416F00287BAE004089BA00407C
      AB00244A77001135660000000000000000000000000000000000000000000000
      00000000000000000000000000000000000015416F00287BAE004089BA00407C
      AB00244A77001135660000000000000000000000000000000000000000000000
      00000000000000000000000000000000000015416F00287BAE004089BA00407C
      AB00244A77001135660000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DEE4EB00134778001D5F91001C57
      860013417000DDE5EB0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DEE4EB00134778001D5F91001C57
      860013417000DDE5EB0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DEE4EB00134778001D5F91001C57
      860013417000DDE5EB0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DEE4EB00134778001D5F91001C57
      860013417000DDE5EB0000000000000000000000000000000000DDDDDD00D4D4
      D400CECECE00CBC8C300CDC8BD00CDC7B900CDC7B900CCC8BE00CBC9C600CFCF
      CF00D5D5D500DFDFDF00000000000000000000000000CCCCCC00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CCCCCC000000000000000000CBCB
      CB00CBCBCB00CBCBCB00000000000000000000000000CCCCCC00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CCCCCC0000000000000000000000
      00000000000000000000000000000000000000000000CCCCCC00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB0000000000000000000000
      0000000000000000000000000000000000000000000000000000D5CEC000B6A0
      7100B4904700BB934200BE964600C09847009F7E51002E267400896D5200B495
      5600C0B39B006C6CA6007575B20000000000C1A99500A7550E00A7530B00A752
      0A00A7520A00A7520A00A7520A00A7530B00AE540E00C9AE9D0059B59300009F
      5F00009D5D00009E5E0052AF8B0000000000C1A99500A7550E00A7530B00A752
      0A00A7520A00A7520A00A7520A00A7530B00A9550D00C5A99300000000000000
      000000000000000000000000000000000000C1A99500A7550E00A7530B00A752
      0A00A8520800B15100004F6E8600486788004993E500C7A89100000000000000
      00000000000000000000000000000000000000000000D7C6A100AF893700B58E
      3D00BB934300C1984800C59C4C00C89E4E005D4D72000B0B8200121183008A6D
      5600483A6E000C0C85000D0D8200D5D5E300B25F1800D8995D00E3A97100E3A8
      7000E3A77000E3A77000E3A87000E5A87100E4955A0049813E0000A96D0000BA
      860077DFC40000BA860000A66A0052AF8B00B25F1800D8995D00E3A97100E3A8
      7000E3A77000E3A77000E3A87000E4A97100DA995D00BF5D1100CBCBCB00C2C6
      C600CBCBCB00CBCBCB00CCCCCC0000000000B25F1800D8995D00E3A97100E3A8
      7000E4A76E00EEA766005285A900769FB5007DC7FC002E6CA700CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CCCCCC000000000000000000D8C7A500B18B3A00B891
      4000BF974600C69C4C00CCA15100CFA45400C79F5A00423988000F0F8F001010
      91000F0F9100121290009C97B90000000000C2793700EAC09700E1A26100E19F
      5C00E19D5900E19D5900E19F5D00E4A26000FBBC9300009E5D0000C18C0000BB
      8200FFFFFF0000BB820000C08C00009E5E00C2793700EAC09700E1A26100E19F
      5C00E19D5900E19D5900E19F5D00E1A26100ECC09700C8681B00268272003485
      6F00337E6C00337E6C00357F6C009FB4AF00C2793700EAC09700E1A26100E19F
      5C00E39D5800EC9D500039AFFC00A2EFFF009CE1FF001C8FF2003B6CA2003582
      620034806900337F6B00357F6C009FB4AF000000000000000000B9974E00BA93
      4200C1994900C99F4F00D0A55500D6AA5A00D6AA5A00C59D5D00211E98001212
      9C0012129C0060527F00EEEBE30000000000CF8D4F00F1D6BC00F0B77600F0B9
      7B00F5F9FD00EBEFF200F0B97900F4B77700FFD3B9000099560070E4CA00FFFF
      FF00FFFFFF00FFFFFF0074E5CB00009C5B00CF8D4F00F1D6BC00F0B77600F0BA
      7B00F5FAFD00EBEFF200F0B97900F1B87700F5D7BD00D272240045AE88004BA9
      800055AE860056AF870050A5830033827000CF8D4F00F1D6BC00F0B77600F0B9
      7B00F6F9FC00F2EFEC00D2BB93002173C9003EC5FF002AABFF002390F1003C6A
      A30058B37F0055B085004FA68300338270000000000000000000EFE9DE00C8A9
      6700C29A4A00CA9F5000D6AC6000E6BE7600E2BA7500564785001414A2001515
      A6001414A6001C1CA200C1C1E10000000000D0884300F1DBC500FBE6CE00FFF8
      EA00FFFEFE00F6F5F300F0E4D300FFE7CE00FFD8C000009855000DD2A20031D9
      B000FFFFFF0031D9B00011D3A300009D5C00D0884300F2DBC500FAE6CE00FFF8
      EA00FFFEFE00F6F5F300F0E4D300FFE7CE00FAD9C100C580340045AC87004EAB
      830039A275003EA5770075C4A20031847200D0884300F1DBC500FBE6CE00FFF8
      EA00FFFEFE00F8F5F100FAE6CE00D9D4D4002A78CB0046C8FF002CACFF00208F
      F3003466A5003CAB740074C6A200318572000000000000000000000000000000
      0000E0CEA800E6C18000F4D6A200E3D7BD007870A8001313A2001818AA009E9A
      CF005555C3001515A8001B1BA100DDDDEA0000000000DD9F6200EEBA8600AFC7
      CE005D9FC3003C7CA00076848800F9B98300BB90480011A0640000AA6A0000D1
      9900A3F5E30000D29A0000AE6E0017956A0000000000DD9F6200EEBA8600AFC7
      CE005D9FC3003C7CA00076848800F8B98300B28F470044AD7A00FDFAFC00F6EF
      EF003BAF810035AF7C0095DABE003086740000000000DD9F6200EEBA8600AFC7
      CE005D9FC3003D7C9F0078858700FFBC7F00919267002E77C90043C8FF0022AB
      FF0083A2C2008473710091E1C0002D8975000000000000000000000000000000
      00000000000000000000C1D9EE00BCD9F20091A6DE002728AE00A5A5E1000000
      0000000000005757C5005353BE00000000000000000000000000F8ECE00094A8
      A80067A3C4005089A9005E737000A4C9A1008AE4C600E5F8EE0068C39F00009B
      510011B07200009C550037B384003A897B000000000000000000F8ECE00094A8
      A80067A3C5005089A9005E737000A4C9A10087E4C500D5F4E700FFFFFD00FFF5
      F200C6DFCF0093E4C5009ADDC600308876000000000000000000F8ECE00094A8
      A80067A3C4005089A9005F736F00A6CAA0008EE7C100C4E1E6002A77CA00B2DD
      F100948A8100B6B0AC00807672002E9178000000000000000000000000000000
      00000000000000000000D5E7F500D0E4F600D0E4F500DCE3F400000000000000
      0000000000000000000000000000000000000000000000000000C2C8CD0078BD
      E2007FC0E30071AFD2005A97BF004190890063B9A1009EC9DA0072A4C9005681
      A9004283830075BEAB0059A19300000000000000000000000000C2C8CD0078BD
      E2007FC0E30071AFD2005A97BF004190890063B9A10099C8D70063A0C200437C
      9F005D86930068BAA400529E9000000000000000000000000000C2C8CD0078BD
      E2007FC0E30071AFD2005A97BF004190890064BAA000A0CCD7005A9AC7009184
      7A00DBD6D2008C8D8500B07CAA00A066D0000000000000000000000000000000
      00000000000000000000D6E6F400D2E5F600D2E5F600D9E8F500000000000000
      0000000000000000000000000000000000000000000000000000143C6C00A7EF
      FF008ED1F0007EBFDE0076B3D50026417100000000006AA6B4006EA4C500588B
      AA0043788900DDEBE70000000000000000000000000000000000143C6C00A7EF
      FF008ED1F0007EBFDE0076B3D50026417100000000006AA6B4006CA3C300548A
      A9003F778600DDEBE70000000000000000000000000000000000143C6C00A7EF
      FF008ED1F0007EBFDE0076B3D50026417100000000006AA6B4006BA4C400628E
      A6008C867C00D3AFCE00CD96C700AF7CCF000000000000000000000000000000
      000000000000DFE7EE00BDD9F200BDD9F200BDD9F200BDD9F200D2D7DE000000
      00000000000000000000000000000000000000000000000000000A3A6A0069AA
      CE0079B3D6008CCCEC0080BFE00007235600D5D5D5007FBFE10081C0E20072B0
      D2005F99BF00C4C8CD00000000000000000000000000000000000A3A6A0069AA
      CE0079B3D6008CCCEC0080BFE00007235600D5D5D5007FBFE10081C0E20072B0
      D1005F99BF00C4C8CD00000000000000000000000000000000000A3A6A0069AA
      CE0079B3D6008CCCEC0080BFE00007235600D5D5D5007FBFE10080C0E2006DAF
      D1006296AC00CD8CD900C28BD500EEE5F4000000000000000000000000000000
      0000000000009CB2CA00A8CEEE00A8CEEE00A8CEEE00A8CEEE00748296000000
      0000000000000000000000000000000000000000000000000000114374002D77
      A9004E89B700517AA500334F7B000D2C5C002B4E7700A8EFFF008FD1F0007FBF
      DE0076B4D500183B690000000000000000000000000000000000114374002D77
      A9004E89B700517AA500334F7B000D2C5C002B4E7700A8EFFF008FD1F0007FBF
      DE0076B4D500183B690000000000000000000000000000000000114374002D77
      A9004E89B700517AA500334F7B000D2C5C002B4E7700A8EFFF008ED1F0007DBF
      DE006EB2D2003B4D7E00F5EBF700000000000000000000000000000000000000
      0000000000006180A50094C1EA0094C1EA008FBBE4007FA5CC00323F57000000
      0000000000000000000000000000000000000000000000000000113F6E00287B
      AE00418ABA00407CAB00254A7700284872000A3B6B0069ABCE0079B5D6008CCC
      EC0081C0E0000B2B5B0000000000000000000000000000000000113F6E00287B
      AE00418ABA00407CAB00254A7700284872000A3B6B0069ABCE0079B5D6008CCC
      EC0081C0E0000B2B5B0000000000000000000000000000000000113F6E00287B
      AE00418ABA00407CAB00254A7700284872000A3B6B0069ABCE0079B5D6008CCC
      EB007DBFDE000023520000000000000000000000000000000000000000000000
      0000E0E2E400344868005F82AA00516C8F002F3B54002B364E002B364D00D8D9
      DD00000000000000000000000000000000000000000000000000DDE5EB001549
      79001E6293001D5787001944720000000000114474002D78A9004E89B700517A
      A50033507B001031600000000000000000000000000000000000DDE5EB001549
      79001E6193001D5787001944720000000000114474002D78A9004E89B700517A
      A50033507B001031600000000000000000000000000000000000DDE5EB001549
      79001E6293001D5787001944720000000000114474002D78A9004E89B700517A
      A500324F7A000B2E5D0000000000000000000000000000000000000000000000
      00000000000069768B002B374F002C3952002C3952002C3952004E586C000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000015416F00287BAE004089BA00407C
      AB00244A77001135660000000000000000000000000000000000000000000000
      00000000000000000000000000000000000015416F00287BAE004089BA00407C
      AB00244A77001135660000000000000000000000000000000000000000000000
      00000000000000000000000000000000000015416F00287BAE004089BA00407C
      AB00244A77001135650000000000000000000000000000000000000000000000
      000000000000000000009CA2AC005B667900525D71008C93A000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DEE4EB00134778001D5F91001C57
      860013417000DDE5EB0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DEE4EB00134778001D5F91001C57
      860013417000DDE5EB0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DEE4EB00134778001D5F91001C57
      860013417000DDE5EB0000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D8D8
      D800D8D8D800D8D8D80000000000000000000000000000000000DDDDDE00D5D6
      D800CFD0D500CCCBCA00CDCAC300CEC9BF00CDC9BF00CDCAC400CBCCCE00D1D2
      D500D5D6D700DEDEDF0000000000000000000000000000000000DDDDDD00D4D4
      D400CECECE00CBC8C300CDC8BD00CDC7B900CDC7B900CCC8BE00CBC9C600CFCF
      CF00D5D5D500DFDFDF0000000000000000000000000000000000DDDDDD00D4D4
      D400CECECE00CBC8C300CDC8BD00CDC7B900CDC7B900C4C2BD00CBC9C600CFCF
      CF00D5D5D500DFDFDF00000000000000000000000000D8D8D800D8D8D800D8D8
      D8000000000000000000D8D8D800D8D8D800D8D8D800DBDBDB005AB69300009E
      5F00009D5D00009E5E0058B59100000000000000000000000000D6D1C400B19B
      6800B68E3C00BC903800BF943E00C1963F00C1963F00BF943E00BC903700B18E
      4800C1B49A00EEECEA0000000000000000000000000000000000D5CEC000B6A0
      7100B4904700BB934200BE964600C0984700C0984700BE964600929A4C003EAF
      6900A4B99900E9E7E20000000000000000000000000000000000D5CEC000B6A0
      7100B4904700BB934200BE964600C0984700C09847004A453600A5AD9C00B7A7
      7A00C2B59A00E9E7E2000000000000000000BF9A5100B7831800B6821700B783
      1800BF9A5100BF9A5100B7831800B9811600C78112004798500000A66C0000BA
      860077DFC40000BA860000A66A0058B5910000000000DDC99E00AF873100B58C
      3800BB924200C1984800C59C4C00C89E4E00C89E4E00C59C4C00C1984800BB92
      4100B58C3700B0893400EEE6D6000000000000000000D7C6A100AF893700B58E
      3D00BB934300C1984800C59C4C00C89E4E00C89E4E00C59C4C0088A658002DBB
      6F007F9F5000B4924700E9E1D1000000000000000000D7C6A100AF893700B58E
      3D00BB934300C1984800C59C4C00C89E4E00C89E4E00AEBFB400A9DAF10072C9
      EE0095976800B4924700E9E1D10000000000B7821800F6CE9000EFBD6B00F6CE
      9000B6821700B6821700F6CE9000F1BD6A00FFCC8900009C5F0000C08C0000BB
      8200FFFFFF0000BB820000C08C00009E5E0000000000DFCDA700B28A3900B991
      4000BF974600C69C4C00CCA15100CFA45400CFA45400CCA15100C69C4C00BF97
      4600B8914000B08A3900E0CCA3000000000000000000D8C7A500B18B3A00B891
      4000BF974600C69C4C00CCA15100CFA45400A4AC5E0095AD5F0068B4670028C4
      790062AF6200839E4F00AFC89C000000000000000000D8C7A500B18B3A00B891
      4000BF974600C69C4C00CCA15100CFA45400CFA45400ABB3960050BEEE0047BB
      EE0048B4DB00A38E4A00D8C8A40000000000B6811500F5D6A300E2A13500F5D6
      A300B5801400B5801400F5D6A300E5A13400FFD39B0000995A0073E5CC00FFFF
      FF00FFFFFF00FFFFFF0077E5CC00009C5C000000000000000000BA934200B891
      4000C2994900CA9F4F00CFA45400D5A85800D5A85800D0A45400C99F4F00C199
      4900B9924000B891410000000000000000000000000000000000B9974E00BA93
      4200C1994900C99F4F00D0A55500D6AA5A002BCB810023CC820023CC820023CC
      820023CC820023CC82002BCC8500000000000000000000000000B9974E00BA93
      4200C1994900C99F4F00D0A55500D6AA5A00D6AA5A00CEA6590068B7CC003BB8
      EC002FB4EA0045A5BA00E9EBE50000000000B7821700F7D8A700F5D5A200F7D8
      A700B6811500B6811500F7D8A700F8D5A100FFD5A000009B5D0000CC980000C8
      8F00FFFFFF0000C88F0000CC9800009D5D00000000000000000000000000CBA9
      6300C0984800C69B4A00D3A75900E9BF7300E9BD7200D1A65600C69A4A00C097
      4600C5A15800F4EEDF0000000000000000000000000000000000EFE9DE00C8A9
      6700C29A4A00CA9F5000D6AC6000E6BE7600ADCE8B0094C37C0063C47B001FD2
      89006BCA8C00ABE9C900B4EED600000000000000000000000000EFE9DE00C8A9
      6700C29A4A00CA9F5000D6AC6000E6BE7600E6BD7500D5AB5E00C0A4630056BB
      E20022B0E8002EB3E700B4CFE10000000000CBA65B00B8821400B8800F00B881
      1300CBA65B00CBA65B00B8811200BA7F0D00C77F0C004E9C540000AF730000D4
      9E0075EDD40000D49E0000AE720067C49F000000000000000000000000000000
      0000E8D4AA00EFC67D00FFDCA200E4D9C100E4D9C200FDDBA300F1C98000E6D1
      A400000000000000000000000000000000000000000000000000000000000000
      0000E0CEA800E6C18000F4D6A200E3D7BD00E3D7BE00F3D6A3009DCF8A001CD7
      8F00ACE8CD000000000000000000000000000000000000000000000000000000
      0000E0CEA800E6C18000F4D6A200E3D7BD00E3D7BE00F3D6A300E7C38100C5CE
      BE0061BFE700859BCA0021219F00DADAE90000000000000000007E7F8100D8D8
      D800D8D8D800D8D8D800D8D8D8007E7F8100D8D8D800D8D8D8006DBB9A00009D
      5800009C5700009C5B0068C59F00000000000000000000000000000000000000
      00000000000000000000B8DAFC00B5D7F600B5D7F600C2DFFB00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C1D9EE00BCD9F200BCD9F200C9DEF000BEEDD7002ADD
      9900B5EDD7000000000000000000000000000000000000000000000000000000
      00000000000000000000C1D9EE00BCD9F200BCD9F200C9DEF000000000000000
      0000B2B4D7001C1CA200A5A5DF000000000000000000000000007E7F81007E7F
      81007E7F81007E7F81007E7F81007E7F81007E7F81007E7F81007E7F81007E7F
      81007E7F81000000000000000000000000000000000000000000000000000000
      00000000000000000000DCEFFD00D5E6F600D3E5F600EEF7FD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D5E7F500D0E4F600D0E4F500E7F0F800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D5E7F500D0E4F600D0E4F500E7F0F800000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000D8D8D800D8D8D800D8D8D8007E7F8100D8D8D800D8D8D800D8D8D8000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DFF0FD00D4E6F600D4E6F600E2F1FD00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D6E6F400D2E5F600D2E5F600D9E8F500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D6E6F400D2E5F600D2E5F600D9E8F500000000000000
      00000000000000000000000000000000000000000000000000000000000046A4
      74000088410000873F0000873F0000873F0000873F0000873F000088410046A4
      7400000000000000000000000000000000000000000000000000000000000000
      000000000000E7EFF700C0DCF500BDD8F200BDD8F200C4E2FB00D9DDE3000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DFE7EE00BDD9F200BDD9F200BDD9F200BDD9F200D2D7DE000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000DFE7EE00BDD9F200BDD9F200BDD9F200BDD9F200D2D7DE000000
      0000000000000000000000000000000000000000000000000000000000000089
      47001DE8B30000DDA00000DDA00000DDA10000DDA00000DDA0001DE8B3000089
      4700000000000000000000000000000000000000000000000000000000000000
      0000000000009CB4CF00ACD3F200A7CEEE00A8CEEE00B2DBFB006B7A90000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009CB2CA00A8CEEE00A8CEEE00A8CEEE00A8CEEE00748296000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000009CB2CA00A8CEEE00A8CEEE00A8CEEE00A8CEEE00748296000000
      0000000000000000000000000000000000000000000000000000000000000088
      450054E4C40000CC990000CC9A0000CD9A0000CC9A0000CC990054E4C4000088
      4500000000000000000000000000000000000000000000000000000000000000
      0000000000006586AD009BCCF60098C8F30096C7F30089B3DE002B354D000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006180A50094C1EA0094C1EA008FBBE4007FA5CC00323F57000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000006180A50094C1EA0094C1EA008FBBE4007FA5CC00323F57000000
      0000000000000000000000000000000000000000000000000000000000000088
      440087E8D90000BF970000BF970000BF980000BF970000BF970087E8D9000088
      4400000000000000000000000000000000000000000000000000000000000000
      0000000000002D3F6000668BB6004F6A8F0022294000222A40002B364D00DDDE
      E200000000000000000000000000000000000000000000000000000000000000
      0000E0E2E400344868005F82AA00516C8F002F3B54002B364E002B364D00D8D9
      DD00000000000000000000000000000000000000000000000000000000000000
      0000E0E2E400344868005F82AA00516C8F002F3B54002B364E002B364D00D8D9
      DD00000000000000000000000000000000000000000000000000000000000089
      46009CEAE70099E7E1009BE7E1009BE7E1009BE7E10099E7E1009CEAE7000089
      4600000000000000000000000000000000000000000000000000000000000000
      00000000000064748A00232C420027334B002A3750002A375100454F65000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000069768B002B374F002C3952002C3952002C3952004E586C000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000069768B002B374F002C3952002C3952002C3952004E586C000000
      0000000000000000000000000000000000000000000000000000000000004EAE
      8100008946000087430000874200008742000087420000874300008946004EAE
      8100000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A2A7B0005B677A00515D70009098A300000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009CA2AC005B667900525D71008C93A000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000009CA2AC005B667900525D71008C93A000000000000000
      0000000000000000000000000000000000000D7C9100087A8F00087A8F00087A
      8F00087A8F00087A8F00087A8F00087A8F00087A8F00087A8F00087A8F001481
      9600C3E1EA000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCBCB00CBCB
      CB00CBCBCB00CBCBCB00CBCBCB00CBCBCB000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000D8D8
      D800D8D8D800D8D8D800000000000000000007798E00A3E6FF0051D0FF0041CA
      FF0042CAFF0042CAFF0042CAFF0042CAFF0042CAFF0041CAFF0044CAFF0087E4
      FF004597A7000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CBCBCB00CBCBCB00CBCB
      CB00CBCBCB00AC731400AD751900AC731600AC721400AB721400AA711300AA70
      1300AA701300AA711300AC741900B07A230000000000D8D8D800D8D8D800D8D8
      D8000000000000000000D8D8D800D8D8D800D8D8D800DBDBDB007685D400374D
      CD00384DCB00384DCC007986D10000000000087A8F004AA6BC0054D1FF0015BC
      FB0014BBFB0015BBFB0015BBFB0015BBFB0015BBFB0015BBFB0014BCFB003AC8
      FE0075C7DF00C5E2EA0000000000000000000000000000000000000000000000
      00000000000067C5A9003DBC96003DBC96003DBC960069C7AB00000000000000
      000000000000000000000000000000000000C1A97900B7821600B37A0600D7D0
      D400D8D1D300A96D0B00F7EFE300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00AC741900BF9A5100B7821700B7821700B782
      1700BF9A5100BF9A5100B7821700B8821500C2870A006A669100324FDE00375D
      FA00375DFA00385DF9003852D7007986D100087A8F00239DBF0089DCF8002DC7
      FE001CC1FD001EC1FD001EC1FD001EC1FD001EC1FD001EC1FD001DC1FD0023C3
      FD0080E2FF004697A60000000000000000000000000000000000000000000000
      0000000000003DBC9600B2E6D40096DEC600B5E7D6003DBC9600000000000000
      000000000000000000000000000000000000B7821800F6CC8A00F0C17200F9F7
      FC00FFFFFF00A6690500F5EBDA00979A9F005354560095969700FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00AA711400B7821700F6CE9000EFBD6B00F6CE
      9000B6821700B6821700F6CE9000F1BE6800FFD37F00203FDA003E63FE003B60
      FA003A5DF8003C60FA004165FB00344BCC00087A8F0036C9FF0050A8B9005FD9
      FF0025C7FD0025C7FD0025C8FD0025C8FD0025C8FD0025C8FD0025C8FD0024C7
      FD0048D2FF0071C4DA00CBE5EB00000000000000000000000000000000000000
      0000000000003DBC96007ADEBE0042D0A2007ADEBE003DBC9600000000000000
      000000000000000000000000000000000000B6811600F3CA8600EBB66000F8F5
      F800FFFFFF00A5680300F5EAD900FFFFFF0057575700FFFFFF00FBFBFA00F6F6
      F500F5F5F400F5F7F700FFFFFF00AA711300B7821700F5D6A300E2A13500F5D6
      A300B5801400B5801400F5D6A300E4A23200FFDB91001E3CD400A6B8FF00FFFF
      FF00FFFFFF00FFFFFF00A9BAFF003148CA00087A8F0041D1FF000E94BC0090E3
      FB0039D1FD002BCDFC002DCEFC002DCEFC002DCEFC002DCEFC002DCEFC002CCD
      FC0031CEFD0088E8FF004897A800000000000000000000000000000000000000
      0000000000003DBC960077DEBE0047D3A60077DEBE003DBC9600000000000000
      000000000000000000000000000000000000B6811600F1CA8900E8B15500F9F8
      FD00FAF8FB00A6690500F6ECDB008C8E9200545556008B8B8C00E3E2E300DFDE
      DE00DEDEDE00DDDEE000FFFFFF00AA711400B7821700F7D8A700F5D5A200F7D8
      A700B6811500B6811500F7D8A700F7D6A000FFDD96001F3ED8005977FF005776
      FE005473FD005776FE005D79FF00334ACB00087A8F0045D1FF001AC3FB0058AB
      BD0069DFFF0037D3FE0036D2FE0036D2FE0036D2FE0036D2FE0036D2FE0036D2
      FE0035D1FE0057DBFF0074C6DD00CFE7EA00000000007ED1B8003DBC96003DBC
      96003DBC96006BD0B10069DCB9004CD5AB0069DCB9006BD0B1003DBC96003DBC
      96003DBC960072CDB2000000000000000000B6811500F3CB8F00E6AD4D00FDFF
      FF00EEE7E500A76B0900F6EFE300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00AC741900CBA65B00B7821700B7821700B782
      1700CBA65B00CBA65B00B7821700B9800C00C38504006E6A9500405BE4006E88
      FF00728BFF006F89FF00465EDD008593DF00087A8F0047D4FF0026CDFF001399
      BA00A6E6FA008AE4FE0087E4FD0088E4FD0088E4FD0088E4FD0087E4FD0086E5
      FF0089E7FF008EE7FF00C0F7FF004F9BAC000000000047BE9A00B7E5D600A2E1
      CD009FE0CC007FDABF0059DAB30052D8B10059DAB3007EE1C4009FE0CC00A1E1
      CD00BBE7D9003DBC96000000000000000000B6811500F3D09500E4AA4600E8CB
      A500FFFFFF00A66D1000A76F1300A76D1000A66D0E00A66C0E00A56C0E00A56B
      0E00A66C0E00A96F1200AC741900B07A230000000000000000007E7F8100D8D8
      D800D8D8D800D8D8D800D8D8D8007E7F8100D8D8D800D8D8D8007F8DD7002943
      D1002B44CF003148CD008795E00000000000087A8F004CD6FF002ACDFD002BCA
      F90009819900087A8F00087A8F00087A8F00087A8F00087A8F00087A8F001080
      96007CB8B4005AA88800268B9B00278B9B000000000047BE9A0081E0C1004FD6
      AC0051D7B00054D9B30057DAB60058DBB70057DAB60054D9B30051D7B0004CD5
      AB007FE0C1003DBC96000000000000000000B6811500F3D39C00E3A53E00E2A2
      3700E4A13200E6A43700E7A53A00E7A63A00E7A63A00E7A63C00E7A84000E8AA
      4300F6D69E00B8821200000000000000000000000000000000007E7F81007E7F
      81007E7F81007E7F81007E7F81007E7F81007E7F81007E7F81007E7F81007E7F
      81007E7F8100000000000000000000000000087A8F004FD8FF002DCEFE0030CF
      FE0031D2FF0030D1FF0034D3FF004CD9FF0053DDFF0053DDFF006BE4FF0069BC
      DF004AB3620042C94A0000000000000000000000000047BE9A00CEF3E700C4F2
      E400C2F1E40074E1C30063DEBD005DDDBC0063DEBD0074E1C300C2F1E400C2F1
      E300D4F5EB003DBC96000000000000000000B6811400F4D5A400E09E3100F4E0
      B700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F4E1B800E19F
      3200F5D6A400B681140000000000000000000000000000000000000000000000
      0000D8D8D800D8D8D800D8D8D8007E7F8100D8D8D800D8D8D800D8D8D8000000
      0000000000000000000000000000000000001784990076E4FF0036D1FE0032D0
      FE0030D0FE0037D1FE0071E2FF001D899F00087A8F00087A8F0018829B002EA4
      690066E6680068EB6D0079C78E0000000000000000007ED1B8003DBC96003DBC
      96003DBC96006ED1B4007AE4C80062E0C0007AE4C8006ED1B4003DBC96003DBC
      96003DBC960074CEB3000000000000000000B6801400F5DAAE00DF982200FCFF
      FF00797C8000A1A3A500FEFBF200797A7C00A3A4A600A0A3A700FBFEFF00DF97
      2200F5DAAE00B6801400000000000000000000000000000000000000000046A4
      74000088410000873F0000873F0000873F0000873F0000873F000088410046A4
      720000000000000000000000000000000000AAD2DA002D93A8007EE7FF0054DC
      FF0053DCFF007AE7FF002C93A900BCDCE00000000000000000008ED29F0074DF
      74006EE1720064DF690030BD3F00000000000000000000000000000000000000
      0000000000003DBC96008CE8D10065E1C3008CE8D1003DBC9600000000000000
      000000000000000000000000000000000000B6801300F7DFB900DD921500FCFC
      FC00FDF8EC00FFF8EA00FDF6E800FCF6E800FBF4E700F9F4E800FAFAFA00DC91
      1500F7DFB900B680130000000000000000000000000000000000000000000089
      47001DE8B30000DDA00000DDA00000DDA10000DDA00000DDA0001DE8B3000089
      47000000000000000000000000000000000000000000CBE6EC0014819500087A
      8F00087A8F0016829800C5E0E5000000000000000000000000006AC1770037A6
      470067D16D004BC355002AB03E0069BE78000000000000000000000000000000
      0000000000003DBC96008FE9D10062E0C0008FE9D1003DBC9600000000000000
      000000000000000000000000000000000000B67F1200FAE5C500DA8C0900FEFE
      FF00787879007A797900A2A1A1009F9E9E00F5EBE0009B9B9D00FCFCFF00DA8C
      0900FAE5C500B67F120000000000000000000000000000000000000000000088
      450054E4C40000CC990000CC9A0000CD9A0000CC9A0000CC990054E4C4000088
      4500000000000000000000000000000000000000000000000000000000000000
      000000000000C8E9D90029A731008DD0A200C6E7D400D1EBDB0096D3A7005BBD
      690088D9890035B1460000000000000000000000000000000000000000000000
      0000000000003DBC9600D9F7EF00C7F3E800D9F7EF003DBC9600000000000000
      000000000000000000000000000000000000B67F1200FBECD200D8840000FFFF
      FF00F1E5DA00F2E6DA00F2E6DA00F0E4D800EEE2D700EEE2D800FEFFFF00D883
      0000FBECD200B67F120000000000000000000000000000000000000000000088
      440087E8D90000BF970000BF970000BF980000BF970000BF970087E8D9000088
      4400000000000000000000000000000000000000000000000000000000000000
      00000000000000000000BAE1C5005BBD65009CD89C009DD8A100B4E2B400B2E3
      B2007FCD830082CA910000000000000000000000000000000000000000000000
      0000000000006ECBAF003DBC96003DBC96003DBC96006ECBAF00000000000000
      000000000000000000000000000000000000B7811400FFECCD00FCE6C300FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FCE6
      C300FFECCD00B781140000000000000000000000000000000000000000000089
      46009CEAE70099E7E1009BE7E1009BE7E1009BE7E10099E7E1009CEAE7000089
      4600000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A4D8B20065BE76005ABA6B0059B9
      6900A5D9AF000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000DCC49400B7811400B57E0F00B57C
      0B00B57C0900B57C0900B57C0900B57C0900B57C0900B57C0900B57C0B00B57E
      0F00B7811400DCC4940000000000000000000000000000000000000000004EAE
      8100008946000087430000874200008742000087420000874300008946004EAE
      810000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000500000000100010000000000800200000000000000000000
      000000000000000000000000FFFFFF00FFF9FFFF000000008000FFFF00000000
      8000C183000000000000C183000000000001C003000000008001C00300000000
      0001E007000000000001F00F000000008001F00F000000000001E00700000000
      0001C003000000008001C003000000000001C183000000000001E3C700000000
      8001FFFF000000008001FFFF0000000080638047804F80000001000300090000
      0000000100010000000000000000000000000000000000000000000000000000
      8000800080008000C000C000C000C000C001C001C001C001C083C083C001C083
      C003C003C003C003C003C003C003C003C003C003C003C003C103C103C103C103
      FF03FF03FF03FF03FF03FF03FF03FF03C0038063807F807FC0010001003F003F
      80000000000100018001000000000000C001000000000000C001000000000000
      F000800080008000FC19C000C000C000FC3FC001C001C000FC3FC083C083C080
      F81FC003C003C000F81FC003C003C001F81FC003C003C003F00FC103C103C103
      F81FFF03FF03FF03FC3FFF03FF03FF03FFE3C003C003C0038C01C003C003C003
      000080018001800100008001800180010000C003C001C0010000E003C001C001
      0000F00FF007F000C001FC3FFC07FC31C007FC3FFC3FFC3FF01FFC3FFC3FFC3F
      E00FF81FF81FF81FE00FF81FF81FF81FE00FF81FF81FF81FE00FF80FF00FF00F
      E00FF81FF81FF81FE00FFC3FFC3FFC3F0007FFFFF800FFE30007FFFF80008C01
      0003F83F000000000003F83F000000000001F83F000000000001F83F00000000
      0000800300000000000080030000C001000080030003C007000380030003F01F
      000180030003E00F00C1F83F0003E00F81C0F83F0003E00FF803F83F0003E00F
      FC03F83F0003E00FFF07FFFF0003E00F00000000000000000000000000000000
      000000000000}
  end
  object dlgOpen1: TOpenDialog
    DefaultExt = '.savaccess'
    Filter = #1060#1072#1081#1083#1099' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1081' (*.savaccess)|*.savaccess|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Title = #1054#1090#1082#1088#1099#1090#1100' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1102
    Left = 484
    Top = 16
  end
  object dlgSave1: TSaveDialog
    DefaultExt = '.savaccess'
    Filter = #1060#1072#1081#1083#1099' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1081' (*.savaccess)|*.savaccess|'#1042#1089#1077' '#1092#1072#1081#1083#1099' (*.*)|*.*'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Title = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1082#1086#1085#1092#1080#1075#1091#1088#1072#1094#1080#1102
    Left = 548
    Top = 16
  end
end
