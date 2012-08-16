object Frm11: TFrm11
  Left = 192
  Top = 137
  Width = 619
  Height = 354
  Caption = #1042#1099#1073#1086#1088' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1103
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    611
    327)
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 0
    Top = 2
    Width = 22
    Height = 13
    Caption = #1048#1084#1103
  end
  object lbl2: TLabel
    Left = 280
    Top = 2
    Width = 18
    Height = 13
    Caption = 'SID'
  end
  object btnOk: TBitBtn
    Left = 396
    Top = 298
    Width = 99
    Height = 25
    Anchors = [akRight, akBottom]
    TabOrder = 0
    Kind = bkOK
  end
  object btnCancel: TBitBtn
    Left = 508
    Top = 298
    Width = 99
    Height = 25
    Anchors = [akRight, akBottom]
    TabOrder = 1
    Kind = bkCancel
  end
  object dbgrd1: TDBGrid
    Left = 0
    Top = 32
    Width = 611
    Height = 257
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = ds1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
  end
  object edtName: TEdit
    Left = 24
    Top = 2
    Width = 241
    Height = 21
    TabOrder = 3
  end
  object edtSID: TEdit
    Left = 304
    Top = 2
    Width = 225
    Height = 21
    TabOrder = 4
  end
  object btn1: TButton
    Left = 536
    Top = 2
    Width = 75
    Height = 25
    Caption = #1053#1072#1081#1090#1080
    TabOrder = 5
    OnClick = btn1Click
  end
  object ds1: TDataSource
    DataSet = vkdbfntx2
    Left = 184
    Top = 160
  end
  object vkdbfntx2: TVKDBFNTX
    OEM = True
    SetDeleted = False
    FastPostRecord = False
    LookupOptions = []
    TrimInLocate = True
    TrimCType = True
    StorageType = pstFile
    AccessMode.AccessMode = 64
    AccessMode.OpenRead = True
    AccessMode.OpenWrite = False
    AccessMode.OpenReadWrite = False
    AccessMode.ShareExclusive = False
    AccessMode.ShareDenyWrite = False
    AccessMode.ShareDenyNone = True
    Crypt.Active = False
    Crypt.CryptMethod = cmNone
    BufferSize = 4096
    WaitBusyRes = 3000
    CreateNow = False
    DbfVersion = xClipper
    LobBlockSize = 512
    LockProtocol = lpClipperLock
    LobLockProtocol = lpClipperLock
    FoxTableFlag.TableFlag = 0
    FoxTableFlag.HasGotIndex = False
    FoxTableFlag.HasGotMemo = False
    FoxTableFlag.ItIsDatabase = False
    Left = 216
    Top = 160
  end
end
