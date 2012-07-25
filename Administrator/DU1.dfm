object dtmdl1: Tdtmdl1
  OldCreateOrder = False
  Left = 424
  Top = 229
  Height = 271
  Width = 504
  object dsDomain: TDataSource
    DataSet = vkdbfDomain
    OnDataChange = dsDomainDataChange
    Left = 24
    Top = 8
  end
  object vkdbfDomain: TVKDBFNTX
    OEM = True
    SetDeleted = False
    FastPostRecord = False
    LookupOptions = []
    TrimInLocate = False
    TrimCType = False
    StorageType = pstFile
    DBFFileName = 'd:\1\77777777\Journal\domains.dbf'
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
    DbfVersion = xClipper
    LobBlockSize = 512
    LockProtocol = lpClipperLock
    LobLockProtocol = lpClipperLock
    FoxTableFlag.TableFlag = 0
    FoxTableFlag.HasGotIndex = False
    FoxTableFlag.HasGotMemo = False
    FoxTableFlag.ItIsDatabase = False
    Left = 24
    Top = 56
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
        Name = 'SID'
        field_type = 'C'
        extend_type = dbftUndefined
        len = 50
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
        Name = 'NAME'
        field_type = 'C'
        extend_type = dbftUndefined
        len = 50
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
        Name = 'INIPATH'
        field_type = 'C'
        extend_type = dbftUndefined
        len = 250
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
        Name = 'FILEPATH'
        field_type = 'C'
        extend_type = dbftUndefined
        len = 250
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
        len = 250
        dec = 0
        NextAutoInc = 0
        NativeNextAutoInc = 1
        NativeStepAutoInc = 1
        Tag = 0
      end>
  end
  object dsUsers: TDataSource
    DataSet = vkdbfUsers
    OnDataChange = dsUsersDataChange
    Left = 96
    Top = 8
  end
  object vkdbfUsers: TVKDBFNTX
    SetDeleted = False
    FastPostRecord = False
    LookupOptions = []
    TrimInLocate = False
    TrimCType = False
    StorageType = pstFile
    DBFFileName = 'd:\1\77777777\Journal\users.dbf'
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
    DbfVersion = xClipper
    LobBlockSize = 512
    LockProtocol = lpClipperLock
    LobLockProtocol = lpClipperLock
    FoxTableFlag.TableFlag = 0
    FoxTableFlag.HasGotIndex = False
    FoxTableFlag.HasGotMemo = False
    FoxTableFlag.ItIsDatabase = False
    Left = 96
    Top = 56
  end
  object dsGroups: TDataSource
    DataSet = vkdbfGroups
    OnDataChange = dsGroupsDataChange
    Left = 168
    Top = 8
  end
  object vkdbfGroups: TVKDBFNTX
    OEM = True
    SetDeleted = False
    FastPostRecord = False
    LookupOptions = []
    TrimInLocate = False
    TrimCType = False
    StorageType = pstFile
    DBFFileName = 'd:\1\77777777\Journal\groups.dbf'
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
    DbfVersion = xClipper
    LobBlockSize = 512
    LockProtocol = lpClipperLock
    LobLockProtocol = lpClipperLock
    FoxTableFlag.TableFlag = 0
    FoxTableFlag.HasGotIndex = False
    FoxTableFlag.HasGotMemo = False
    FoxTableFlag.ItIsDatabase = False
    Left = 168
    Top = 56
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
        Name = 'SID'
        field_type = 'C'
        extend_type = dbftUndefined
        len = 50
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
        Name = 'NAME'
        field_type = 'C'
        extend_type = dbftUndefined
        len = 50
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
        len = 200
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
        Name = 'PRIORITY'
        field_type = 'N'
        extend_type = dbftUndefined
        len = 6
        dec = 0
        NextAutoInc = 0
        NativeNextAutoInc = 1
        NativeStepAutoInc = 1
        Tag = 0
      end>
  end
  object dsUsersGroup: TDataSource
    DataSet = vkdbfUsersGroup
    Left = 248
    Top = 8
  end
  object vkdbfUsersGroup: TVKDBFNTX
    OEM = True
    SetDeleted = False
    FastPostRecord = False
    LookupOptions = []
    TrimInLocate = False
    TrimCType = False
    StorageType = pstFile
    DBFFileName = 'd:\1\77777777\Journal\users.dbf'
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
    DataSource = dsGroups
    CreateNow = False
    DbfVersion = xClipper
    LobBlockSize = 512
    LockProtocol = lpClipperLock
    LobLockProtocol = lpClipperLock
    FoxTableFlag.TableFlag = 0
    FoxTableFlag.HasGotIndex = False
    FoxTableFlag.HasGotMemo = False
    FoxTableFlag.ItIsDatabase = False
    Left = 248
    Top = 56
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
        Name = 'NAME'
        field_type = 'C'
        extend_type = dbftUndefined
        len = 50
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
        Name = 'SID'
        field_type = 'C'
        extend_type = dbftUndefined
        len = 50
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
        Name = 'DOMAIN'
        field_type = 'C'
        extend_type = dbftUndefined
        len = 50
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
        len = 200
        dec = 0
        NextAutoInc = 0
        NativeNextAutoInc = 1
        NativeStepAutoInc = 1
        Tag = 0
      end>
  end
end
