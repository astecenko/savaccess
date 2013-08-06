object Frm12: TFrm12
  Left = 280
  Top = 76
  Width = 721
  Height = 416
  Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082' '#1076#1077#1081#1089#1090#1074#1080#1081
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCanResize = FormCanResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 161
    Width = 713
    Height = 3
    Cursor = crVSplit
    Align = alTop
  end
  object Panel1: TPanel
    Left = 0
    Top = 348
    Width = 713
    Height = 41
    Align = alBottom
    TabOrder = 0
    DesignSize = (
      713
      41)
    object btnOk: TBitBtn
      Left = 496
      Top = 8
      Width = 97
      Height = 25
      Anchors = [akRight, akBottom]
      TabOrder = 0
      Kind = bkOK
    end
    object btnCancel: TBitBtn
      Left = 608
      Top = 8
      Width = 97
      Height = 25
      Anchors = [akRight, akBottom]
      TabOrder = 1
      Kind = bkCancel
    end
    object txt1: TStaticText
      Left = 8
      Top = 8
      Width = 183
      Height = 17
      Caption = 'Insert - '#1074#1089#1090#1072#1074#1080#1090#1100';   Ctrl+Del - '#1091#1076#1072#1083#1080#1090#1100
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 713
    Height = 161
    Align = alTop
    TabOrder = 1
    object dbgrdExt: TDBGrid
      Left = 1
      Top = 1
      Width = 711
      Height = 159
      Align = alClient
      DataSource = dsExt
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnKeyDown = dbgrdExtKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'ID'
          ReadOnly = True
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'TYPE'
          Title.Alignment = taCenter
          Title.Caption = #1058#1080#1087
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EXT'
          Title.Alignment = taCenter
          Title.Caption = #1056#1072#1089#1096#1080#1088'.'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCR'
          Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
          Width = 550
          Visible = True
        end>
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 164
    Width = 713
    Height = 184
    Align = alClient
    TabOrder = 2
    object dbgrdAct: TDBGrid
      Left = 1
      Top = 1
      Width = 711
      Height = 182
      Align = alClient
      DataSource = dsAct
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnKeyDown = dbgrdActKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'FID'
          ReadOnly = True
          Visible = False
        end
        item
          Expanded = False
          FieldName = 'ACTION'
          Title.Alignment = taCenter
          Title.Caption = 'ID '#1076#1077#1081#1089#1090#1074#1080#1103
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DESCR'
          Title.Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081
          Width = 575
          Visible = True
        end>
    end
  end
  object vkdbfExt: TVKDBFNTX
    OEM = True
    SetDeleted = False
    FastPostRecord = False
    LookupOptions = []
    AfterInsert = vkdbfExtAfterInsert
    AfterDelete = vkdbfExtAfterDelete
    TrimInLocate = True
    TrimCType = True
    StorageType = pstFile
    DBFFileName = 'd:\1\TestBase\Journal\extens.dbf'
    AccessMode.AccessMode = 66
    AccessMode.OpenRead = False
    AccessMode.OpenWrite = False
    AccessMode.OpenReadWrite = True
    AccessMode.ShareExclusive = False
    AccessMode.ShareDenyWrite = False
    AccessMode.ShareDenyNone = True
    Crypt.Active = False
    Crypt.CryptMethod = cmNone
    BufferSize = 4096
    WaitBusyRes = 3000
    CreateNow = False
    DbfVersion = xBaseIII
    LobBlockSize = 512
    LockProtocol = lpClipperLock
    LobLockProtocol = lpClipperLock
    FoxTableFlag.TableFlag = 0
    FoxTableFlag.HasGotIndex = False
    FoxTableFlag.HasGotMemo = False
    FoxTableFlag.ItIsDatabase = False
    Left = 16
    Top = 48
    DBFFieldDefs = <
      item
        FieldFlag.FieldFlag = 0
        FieldFlag.System = False
        FieldFlag.CanStoreNull = False
        FieldFlag.BinaryColumn = False
        FieldFlag.AutoIncrement = False
        Name = 'ID'
        field_type = 'N'
        extend_type = dbftUndefined
        len = 6
        dec = 0
        NextAutoInc = 0
        NativeNextAutoInc = 1
        NativeStepAutoInc = 1
        Tag = 0
      end
      item
        FieldFlag.FieldFlag = 0
        FieldFlag.System = False
        FieldFlag.CanStoreNull = False
        FieldFlag.BinaryColumn = False
        FieldFlag.AutoIncrement = False
        Name = 'EXT'
        field_type = 'C'
        extend_type = dbftUndefined
        len = 10
        dec = 0
        NextAutoInc = 0
        NativeNextAutoInc = 1
        NativeStepAutoInc = 1
        Tag = 0
      end
      item
        FieldFlag.FieldFlag = 0
        FieldFlag.System = False
        FieldFlag.CanStoreNull = False
        FieldFlag.BinaryColumn = False
        FieldFlag.AutoIncrement = False
        Name = 'TYPE'
        field_type = 'C'
        extend_type = dbftUndefined
        len = 1
        dec = 0
        NextAutoInc = 0
        NativeNextAutoInc = 1
        NativeStepAutoInc = 1
        Tag = 0
      end
      item
        FieldFlag.FieldFlag = 0
        FieldFlag.System = False
        FieldFlag.CanStoreNull = False
        FieldFlag.BinaryColumn = False
        FieldFlag.AutoIncrement = False
        Name = 'DESCR'
        field_type = 'C'
        extend_type = dbftUndefined
        len = 150
        dec = 0
        NextAutoInc = 0
        NativeNextAutoInc = 1
        NativeStepAutoInc = 1
        Tag = 0
      end>
  end
  object vkdbfAct: TVKDBFNTX
    OEM = True
    SetDeleted = False
    FastPostRecord = False
    LookupOptions = []
    AfterInsert = vkdbfActAfterInsert
    AfterDelete = vkdbfActAfterDelete
    TrimInLocate = True
    TrimCType = True
    StorageType = pstFile
    DBFFileName = 'd:\1\TestBase\Journal\actions.dbf'
    AccessMode.AccessMode = 66
    AccessMode.OpenRead = False
    AccessMode.OpenWrite = False
    AccessMode.OpenReadWrite = True
    AccessMode.ShareExclusive = False
    AccessMode.ShareDenyWrite = False
    AccessMode.ShareDenyNone = True
    Crypt.Active = False
    Crypt.CryptMethod = cmNone
    BufferSize = 4096
    WaitBusyRes = 3000
    DataSource = dsExt
    CreateNow = False
    DbfVersion = xBaseIII
    LobBlockSize = 512
    LockProtocol = lpClipperLock
    LobLockProtocol = lpClipperLock
    FoxTableFlag.TableFlag = 0
    FoxTableFlag.HasGotIndex = False
    FoxTableFlag.HasGotMemo = False
    FoxTableFlag.ItIsDatabase = False
    Left = 24
    Top = 212
    DBFFieldDefs = <
      item
        FieldFlag.FieldFlag = 0
        FieldFlag.System = False
        FieldFlag.CanStoreNull = False
        FieldFlag.BinaryColumn = False
        FieldFlag.AutoIncrement = False
        Name = 'FID'
        field_type = 'N'
        extend_type = dbftUndefined
        len = 6
        dec = 0
        NextAutoInc = 0
        NativeNextAutoInc = 1
        NativeStepAutoInc = 1
        Tag = 0
      end
      item
        FieldFlag.FieldFlag = 0
        FieldFlag.System = False
        FieldFlag.CanStoreNull = False
        FieldFlag.BinaryColumn = False
        FieldFlag.AutoIncrement = False
        Name = 'ACTION'
        field_type = 'N'
        extend_type = dbftUndefined
        len = 3
        dec = 0
        NextAutoInc = 0
        NativeNextAutoInc = 1
        NativeStepAutoInc = 1
        Tag = 0
      end
      item
        FieldFlag.FieldFlag = 0
        FieldFlag.System = False
        FieldFlag.CanStoreNull = False
        FieldFlag.BinaryColumn = False
        FieldFlag.AutoIncrement = False
        Name = 'DESCR'
        field_type = 'C'
        extend_type = dbftUndefined
        len = 150
        dec = 0
        NextAutoInc = 0
        NativeNextAutoInc = 1
        NativeStepAutoInc = 1
        Tag = 0
      end>
  end
  object dsExt: TDataSource
    AutoEdit = False
    DataSet = vkdbfExt
    OnDataChange = dsExtDataChange
    Left = 48
    Top = 48
  end
  object dsAct: TDataSource
    AutoEdit = False
    DataSet = vkdbfAct
    Left = 56
    Top = 212
  end
end
