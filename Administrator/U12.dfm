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
    object btnAdd: TBitBtn
      Left = 16
      Top = 8
      Width = 97
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #1057#1086#1079#1076#1072#1090#1100
      TabOrder = 2
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
        333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
        0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
        0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
        33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
        B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
        3BB33773333773333773B333333B3333333B7333333733333337}
      NumGlyphs = 2
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
    end
  end
  object vkdbfExt: TVKDBFNTX
    OEM = True
    SetDeleted = False
    FastPostRecord = False
    LookupOptions = []
    TrimInLocate = False
    TrimCType = False
    StorageType = pstFile
    DBFFileName = 'd:\1\TestBase\Journal\extens.dbf'
    AccessMode.AccessMode = 16
    AccessMode.OpenRead = True
    AccessMode.OpenWrite = False
    AccessMode.OpenReadWrite = False
    AccessMode.ShareExclusive = True
    AccessMode.ShareDenyWrite = False
    AccessMode.ShareDenyNone = False
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
    TrimInLocate = False
    TrimCType = False
    StorageType = pstFile
    DBFFileName = 'd:\1\TestBase\Journal\actions.dbf'
    AccessMode.AccessMode = 16
    AccessMode.OpenRead = True
    AccessMode.OpenWrite = False
    AccessMode.OpenReadWrite = False
    AccessMode.ShareExclusive = True
    AccessMode.ShareDenyWrite = False
    AccessMode.ShareDenyNone = False
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
    DataSet = vkdbfExt
    Left = 48
    Top = 48
  end
  object dsAct: TDataSource
    DataSet = vkdbfAct
    Left = 56
    Top = 212
  end
end
