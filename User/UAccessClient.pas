unit UAccessClient;

interface
uses Classes, UAccessConstant, DBClient, DB, MidasLib, CRTL, IniFiles, UAccessPattern,
  PluginAPI;

type
  TVersionString = string[30];

  { TSAVAccessFileProc = function(const rNew, rOld: TClientFile;
     const aDir, aSID: string; const aPath: string = ''): Boolean;}

  { TSAVAccessFileAction = class
   private
     procedure SetFileAction(const Value: Integer);
     procedure SetFileExt(const Value: string);
     procedure SetFileType(const Value: string);
   protected
     FFileType: string;
     FFileAction: Integer;
     FFileExt: string;
     FFileProc: TSAVAccessFileProc;
   public
     property FileType: string read FFileType write SetFileType;
     property FileAction: Integer read FFileAction write SetFileAction;
     property FileExt: string read FFileExt write SetFileExt;
     property FileProc: TSAVAccessFileProc read FFileProc write FFileProc;
     constructor Create(const AFileType, AFileExt: string; const AFileAct:
       Integer; AFunc: TSAVAccessFileProc);
   end;         }

  TSAVAccessClient = class(TObject)
  private
    FUser: string;
    FDomain: string;
    FSID: string;
    FIniFile: TIniFile;
    FWorkstation: string;
    FDataSet: TClientDataSet;
    FConfigDir: string;
    FJournalsDir: string;
    FUsersDir: string;
    FGroupsDir: string;
    FADGroupsDir: string;
    FTemplate: TPathTemplate;
    FDomainsDir: string;
    FActions: TList;
    procedure SetDataSet(const Value: TClientDataSet);
    procedure SetIniFile(const Value: TIniFile);
    procedure SetActions(const Value: TList);
    procedure SetADGroupsDir(const Value: string);
  public
    property ConfigDir: string read FConfigDir;
    property Domain: string read FDomain;
    property SID: string read FSID;
    property Actions: TList read FActions write SetActions;
    property User: string read FUser;
    property DataSet: TClientDataSet read FDataSet write SetDataSet;
    property JournalsDir: string read FJournalsDir;
    property UsersDir: string read FUsersDir;
    property GroupsDir: string read FGroupsDir;
    property ADGroupsDir: string read FADGroupsDir write SetADGroupsDir;
    property DomainsDir: string read FDomainsDir;
    property Workstation: string read FWorkstation;
    property IniFile: TIniFile read FIniFile write SetIniFile;
    procedure LoadFromFile(const aFileName: string);
    procedure SortListVal(Source: TStrings);
    function Record2ClientFile(table1: TDataSet; const aSID, aSource: string;
      const DefaultAction: Integer = -1):
      TClientFile;
    procedure ClientFile2Record(table1: TDataSet; const ClntFile1: TClientFile);
    function CheckDomainVersion: Boolean; //True = Equal
    function CheckUserVersion: Boolean;
    function GetDirBySource(const aSource: Char): string;
    function CheckGroupVersion(const aSID: string): Boolean;
    function FileProcessing(const aOld, aNew: TClientFile; const DeleteOnly:
      Boolean = False): Boolean;
    function AddedProc(const aOld, aNew: TClientFile; const aDir, aSID, aPath:
      string):
      Boolean;
    procedure UpdateContainerFile(const aDir, aSID, aVersion: string);
    procedure DeleteContainerFile(const aDir, aSID: string);
    function Update: Boolean;
    function FindPlugin(const AFileType: Char; AExt: string; AID: Integer; const
      AGUID:
      TGUID; out Obj): Boolean;
    constructor Create(const aConfDirName: string = ''); overload;
    destructor Destroy; override;

  end;

implementation
uses SAVLib, SysUtils, SPGetSid, MsAD, VKDBFDataSet, SAVLib_DBF, Variants,
  KoaUtils, Windows, PluginManager;

{ TSAVAccessContainer }

function TSAVAccessClient.AddedProc(const aOld,
  aNew: TClientFile; const aDir, aSID, aPath: string): Boolean;
var
  {i: Integer;
  b: Byte;}
  Plugin: ISAVAccessFileAct;
begin
  // b := 0;
  Result := False;
  // i := 0;
  if FindPlugin(Char(aNew.TypeF), aNew.Ext, aNew.Action, ISAVAccessFileAct,
    Plugin) then
  begin
    Result := Plugin.ProcessedFile(aNew, aOld, aDir, aSID, aPath) > 0
  end;
end;

function TSAVAccessClient.CheckDomainVersion: Boolean;
var
  ini: TIniFile;
  s: string;
begin
  ini := TIniFile.Create(DomainsDir + Domain + '\' + csContainerCfg);
  s := ini.ReadString('main', 'version', '');
  FreeAndNil(ini);
  Result := (s <> '') and (s = FIniFile.ReadString('version', 'domain', ''));

end;

function TSAVAccessClient.CheckGroupVersion(const aSID: string): Boolean;
var
  ini: TIniFile;
  s: string;
begin
  ini := TIniFile.Create(GroupsDir + aSID + '\' + csContainerCfg);
  s := ini.ReadString('main', 'version', '');
  FreeAndNil(ini);
  Result := (s <> '') and (s = FIniFile.ReadString('version', 'gr' + aSID, ''));
end;

function TSAVAccessClient.CheckUserVersion: Boolean;
var
  ini: TIniFile;
  s: string;
begin
  ini := TIniFile.Create(UsersDir + SID + '\' + csContainerCfg);
  s := ini.ReadString('main', 'version', '');
  FreeAndNil(ini);
  Result := (s <> '') and (s = FIniFile.ReadString('version', 'user', ''));
end;

procedure TSAVAccessClient.ClientFile2Record(table1: TDataSet;
  const ClntFile1: TClientFile);
begin

end;

constructor TSAVAccessClient.Create(const aConfDirName: string);
var
  datFile: string;
  procedure CreatDS;
  begin
    with FDataSet.FieldDefs.AddFieldDef as TFieldDef do
    begin
      DisplayName := csFieldSrvrFile;
      DataType := ftString;
      Size := 50;
    end;
    with FDataSet.FieldDefs.AddFieldDef as TFieldDef do
    begin
      DisplayName := csFieldVersion;
      DataType := ftString;
      Size := 30;
    end;
    with FDataSet.FieldDefs.AddFieldDef as TFieldDef do
    begin
      DisplayName := csFieldClntFile;
      DataType := ftString;
      Size := 2047;
    end;
    with FDataSet.FieldDefs.AddFieldDef as TFieldDef do
    begin
      DisplayName := csFieldExt;
      DataType := ftString;
      Size := 10;
    end;
    with FDataSet.FieldDefs.AddFieldDef as TFieldDef do
    begin
      DisplayName := csFieldType;
      DataType := ftString;
      Size := 1;
    end;
    with FDataSet.FieldDefs.AddFieldDef as TFieldDef do
    begin
      DisplayName := csFieldAction;
      DataType := ftInteger;
    end;
    with FDataSet.FieldDefs.AddFieldDef as TFieldDef do
    begin
      DisplayName := csFieldMD5;
      DataType := ftString;
      Size := 32;
    end;
    with FDataSet.FieldDefs.AddFieldDef as TFieldDef do
    begin
      DisplayName := csFieldSID;
      DataType := ftString;
      Size := 50;
    end;
    with FDataSet.FieldDefs.AddFieldDef as TFieldDef do
    begin
      DisplayName := csFieldSource;
      DataType := ftString;
      Size := 1;
    end;
    FDataSet.CreateDataSet;
  end;
begin
  {if aConfDirName = '' then
    s := 'SAVAccessClient'
  else
    s := aConfDirName;
  FConfigDir := GetSpecialFolderLocation(CSIDL_APPDATA,
    FOLDERID_RoamingAppData);
  if FConfigDir = '' then
    FConfigDir := GetCurrentDir;
  FConfigDir :=
    IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(FConfigDir) + s);
  }
  FConfigDir := IncludeTrailingPathDelimiter(aConfDirName);
  if not (DirectoryExists(ConfigDir)) then
    ForceDirectories(ConfigDir);
  FSID := SPGetSid.GetCurrentUserSid;
  FWorkstation := MsAD.GetCurrentComputerName;
  FUser := MsAD.GetCurrentUserName;
  FDomain := MsAD.CurrentDomainName;
  FDataSet := TClientDataSet.Create(nil);

  datFile := FConfigDir + csClientData;
  if FileExists(datFile) then
    try
      FDataSet.LoadFromFile(datFile);
    except
      FDataSet.Close;
      Windows.DeleteFile(PChar(datFile));
      CreatDS;
    end
  else
    CreatDS;
  FDataSet.Open;
  FDataSet.LogChanges := False;
  FDataSet.FileName := datFile;
  FIniFile := TIniFile.Create(FConfigDir + csContainerCfg);
  FActions := TList.Create;
end;

function TSAVAccessClient.FindPlugin(const AFileType: Char; AExt: string; AID:
  Integer; const AGUID:
  TGUID; out Obj): Boolean;
var
  X: Integer;
begin
  Result := False;
  for X := 0 to Plugins.Count - 1 do
    if (Plugins[X].ActionID = AID) and (Plugins[X].Extension = AExt) and
      (Plugins[x].FileType = AFileType) then
    begin
      Result := Supports(Plugins[X], AGUID, Obj);
      if Result then
        Break;
    end;
end;

destructor TSAVAccessClient.Destroy;
var
  I: Integer;
begin
  if Assigned(FDataSet) then
  begin
    if FDataSet.Active then
    FDataSet.ApplyUpdates(-1);
    FDataSet.Close;
    FreeAndNil(FDataset);
  end;
  if Assigned(FTemplate) then
    FreeAndNil(FTemplate);
  if Assigned(FIniFile) then
  begin
    FIniFile.WriteDateTime('option', 'LastChange', Now);
    FreeAndNil(Finifile);
  end;
  if Assigned(FActions) then
  begin
    for i := 0 to FACtions.Count - 1 do
      TObject(FACtions[i]).Free;
    FreeAndNil(FACtions);
  end;
  inherited;
end;

function TSAVAccessClient.FileProcessing(const aOld,
  aNew: TClientFile; const DeleteOnly: Boolean = False): Boolean;
var
  hFile: Cardinal;
  sf, ContDir: string;
begin
  Result := True;
  sf := FTemplate.GetPath(aNew.ClntFile);
  ContDir := IncludeTrailingPathDelimiter(GetDirBySource(char(aNew.Source))) +
    aNew.SID
    + '\f\';
  case aNew.TypeF of
    'F': //Файловая операция
      begin
        if (aNew.Ext = '') or (AddedProc(aOld, aNew, ContDir, aNew.SID, sf) =
          False) then
          case aNew.Action of
            0: // Удаление
              begin
                if FileExists(sf) then
                  Result := Windows.DeleteFile(PChar(sf));
              end;
            1: // Копирование
              begin
                try
                  fCopyFile(ContDir + aNew.SrvrFile, sf);
                except
                  Result := False;
                end;
              end;
            2: // Создать файл пустой
              begin
                hFile := CreateFile(PChar(sf), GENERIC_WRITE,
                  FILE_SHARE_WRITE or FILE_SHARE_READ, nil,
                  OPEN_ALWAYS, FILE_FLAG_WRITE_THROUGH, 0);
                Result := hFile <> INVALID_HANDLE_VALUE;
                CloseHandle(hFile);
              end;
          end
      end;
    'D': //Операция с каталогом
      begin
        if DeleteOnly = False then
          case aNew.Action of
            0: // Удаление
              begin
                if DirectoryExists(sf) then
                  Result := fRemoveDir(sf)
              end;
            { 1: // Копирование -
               begin
                 fCopyDir();
               end;}
            2: // Создать пустую директорию
              begin
                Result := ForceDirectories(ExcludeTrailingPathDelimiter(sf));
              end;
          else
            begin
              ;
            end;
          end
      end;
  else
    begin
      AddedProc(aOld, aNew, ContDir, aNew.SID, sf);
    end;
  end;
end;

function TSAVAccessClient.GetDirBySource(const aSource: Char): string;
begin
  Result := '';
  case aSource of
    'D': Result := FDomainsDir;
    'G': Result := FGroupsDir;
    'U': Result := FUsersDir;
    'A': Result := FADGroupsDir;
  end;
end;

procedure TSAVAccessClient.LoadFromFile(const aFileName: string);
var
  list: TStringList;
begin
  if FileExists(aFileName) then
  begin
    list := TStringList.Create;
    list.LoadFromFile(aFileName);
    FUsersDir := list.Values['users'];
    FJournalsDir := list.Values['journals'];
    FGroupsDir := list.Values['groups'];
    FADGroupsDir := list.Values['adgroups'];
    FDomainsDir := list.Values['domains'];
    FreeAndNil(list);
    if Assigned(FTemplate) then
      FreeAndNil(FTemplate);

    FTemplate := TPathTemplate.Create(IncludeTrailingPathDelimiter(FJournalsDir)
      + csTemplateMain, False);
  end
  else
    raise Exception.Create('Нет доступа к файлу ' + aFileName);
end;

function TSAVAccessClient.Record2ClientFile(table1: TDataSet; const aSID,
  aSource: string; const DefaultAction: Integer = -1): TClientFile;
begin
  Result.SrvrFile := table1.fieldbyname(csFieldSrvrFile).AsString;
  Result.Ext := table1.fieldbyname(csFieldExt).AsString;
  Result.Version := table1.fieldbyname(csFieldVersion).AsString;
  Result.ClntFile := table1.fieldbyname(csFieldClntFile).AsString;
  Result.TypeF := WideChar(table1.fieldbyname(csFieldType).AsString[1]);
  if DefaultAction > -1 then
    Result.Action := DefaultAction
  else
    Result.Action := table1.FieldByName(csFieldAction).AsInteger;
  Result.MD5 := table1.fieldbyname(csFieldMD5).AsString;
  Result.Source := WideChar(aSource[1]);
  Result.SID := aSID;
end;

procedure TSAVAccessClient.SetActions(const Value: TList);
begin
  FActions := Value;
end;

procedure TSAVAccessClient.SetDataSet(const Value: TClientDataSet);
begin
  FDataSet := Value;
end;

procedure TSAVAccessClient.SetIniFile(const Value: TIniFile);
begin
  FIniFile := Value;
end;

//основная ф-ция обновления

procedure TSAVAccessClient.SortListVal(Source: TStrings);

var
  ListWork, ListRes: TStringList;
  j: Integer;

  function GetMinListNumb(List1: TStrings): Integer;
  var
    vMin: integer;
    i, x: Integer;
  begin
    if List1.Count > 1 then
    begin
      Result := 0;
      vMin := StrToIntDef(List1.ValueFromIndex[Result], Result);
      for i := 1 to pred(List1.Count) do
      begin
        x := StrToIntDef(List1.ValueFromIndex[i], 0);
        if vMin > x then
        begin
          Result := i;
          vMin := x;
        end;
      end;
    end
    else
      Result := 0;
  end;
begin
  if Source.Count > 1 then
  begin
    ListWork := TStringList.Create;
    ListRes := TStringList.Create;
    ListWork.Assign(Source);
    while ListWork.Count > 0 do
    begin
      j := GetMinListNumb(ListWork);
      ListRes.Add(ListWork[j]);
      ListWork.Delete(j);
    end;
    FreeAndNil(ListWork);
    Source.Clear;
    Source.Assign(ListRes);
    FreeAndNil(ListRes);
  end
end;

function TSAVAccessClient.Update: Boolean;
var
  ini: TIniFile;
  list1, oldGroups, ADGroups, ADOldGroups: TStringList;
  sUserIni, WorkLst, ADWorkLst, sDNS: string;
  i, j: Integer;
  b,
    DelGroups // есть удаленные группы
  : Boolean;
begin
  Result := True;
  WorkLst := FConfigDir + csWorkGroupsLst;
  ADWorkLst := FConfigDir + csWorkADGroupsLst;
  sUserIni := IncludeTrailingPathDelimiter(FUsersDir) + FSID + '\' +
    csContainerCfg;
  sDNS := GetDNSDomainName(Domain);
  list1 := TStringList.Create;
  ADGroups := TStringList.Create;
  DelGroups := False;
  b := FileExists(sUserIni);
  if b then
  begin
    ini := TIniFile.Create(sUserIni);
    ini.ReadSectionValues(csIniGroups, list1);
    FreeAndNil(ini);
  end;
  GetAllUserGroups(User, GetDomainController(Domain), ADGroups);
  for i := 0 to pred(ADGroups.Count) do
    ADGroups[i] := GetSID(ADGroups[i], sdns) + '=' + ADGroups[i];
  if FileExists(ADWorkLst) then
  begin
    ADOldGroups := TStringList.Create;
    ADOldGroups.LoadFromFile(ADWorkLst);
    for i := Pred(ADOldGroups.Count) downto 0 do
    begin
      j := 0;
      while j < ADGroups.Count do
        if ADGroups.Names[j] = ADOldGroups.Names[i] then
        begin
          ADOldGroups.Delete(i);
          j := ADGroups.Count;
        end
        else
          Inc(j);
    end;
    if ADOldGroups.Count > 0 then
      // есть группы из которых пользователь был удален
    begin
      for i := 0 to pred(ADOldGroups.Count) do
        DeleteContainerFile(FADGroupsDir, ADOldGroups.Names[i]);
      DelGroups := True;
    end;
    FreeAndNil(ADOldGroups);
  end;
  SortListVal(list1);
  if FileExists(WorkLst) then
  begin
    oldGroups := TStringList.Create;
    oldGroups.LoadFromFile(WorkLst);
    for i := Pred(oldGroups.Count) downto 0 do
    begin
      j := 0;
      while j < list1.Count do
        if list1.Names[j] = oldGroups.Names[i] then
        begin
          oldGroups.Delete(i);
          j := list1.Count;
        end
        else
          Inc(j);
    end;
    if oldGroups.Count > 0 then // есть группы из которых пользователь был удален
    begin
      for i := 0 to pred(oldGroups.Count) do
        DeleteContainerFile(FGroupsDir, oldGroups.Names[i]);
      DelGroups := True;
    end;
    FreeAndNil(oldGroups);
  end;
  try
    ADGroups.SaveToFile(ADWorkLst);
    list1.SaveToFile(WorkLst);
  except
    Result := False;
  end;
  if DelGroups then
  begin
    UpdateContainerFile(FDomainsDir, Domain, '');
    for i := 0 to pred(ADGroups.Count) do
      UpdateContainerFile(FADGroupsDir, ADGroups.Names[i], '');
    for i := 0 to pred(list1.Count) do
      UpdateContainerFile(FGroupsDir, list1.Names[i], '');
  end
  else
  begin
    UpdateContainerFile(FDomainsDir, Domain, FIniFile.ReadString('D', Domain,
      ''));
    for i := 0 to pred(ADGroups.Count) do
      UpdateContainerFile(FADGroupsDir, ADGroups.Names[i],
        FIniFile.ReadString('A', ADGroups.Names[i], ''));
    for i := 0 to pred(list1.Count) do
      UpdateContainerFile(FGroupsDir, list1.Names[i], FIniFile.ReadString('G',
        list1.Names[i], ''));
  end;
  FreeAndNil(ADGroups);
  FreeAndNil(list1);
  if b then
  begin
    if DelGroups then
      UpdateContainerFile(FUsersDir, SID, '')
    else
      UpdateContainerFile(FUsersDir, SID, FIniFile.ReadString('U', SID, ''));
  end;
  FDataSet.ApplyUpdates(-1);
  FDataSet.Close;
  FDataSet.Open;
end;

//Обновление файлов определенного контейнера хранилища переданного в aDir+aSID

procedure TSAVAccessClient.UpdateContainerFile(const aDir, aSID, aVersion:
  string);
var
  ini: TIniFile;
  c: Char;
  s, vers: string;
  sPath, sLocIni: string;
  table1: TVKDBFNTX;

  procedure FileInfoMove(aFrom, aTo: TDataSet; const aFull: Boolean);
  begin
    if aFull then
    begin
      aTo.fieldbyname(csFieldSrvrFile).AsString :=
        aFrom.fieldbyname(csFieldSrvrFile).AsString;
      aTo.fieldbyname(csFieldExt).AsString :=
        aFrom.fieldbyname(csFieldExt).AsString;
      aTo.fieldbyname(csFieldType).AsString :=
        aFrom.fieldbyname(csFieldType).AsString;
      aTo.FieldByName(csFieldSource).AsString := c;
      aTo.FieldByName(csFieldSID).AsString := aSID;
    end;
    aTo.fieldbyname(csFieldClntFile).AsString :=
      aFrom.fieldbyname(csFieldClntFile).AsString;
    aTo.fieldbyname(csFieldVersion).AsString :=
      aFrom.fieldbyname(csFieldVersion).AsString;
    aTo.fieldbyname(csFieldMD5).AsString :=
      aFrom.fieldbyname(csFieldMD5).AsString;
    aTo.fieldbyname(csFieldAction).AsInteger :=
      aFrom.fieldbyname(csFieldAction).AsInteger;
  end;

begin
  s := '';
  sPath := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(aDir) +
    aSID);
  sLocIni := sPath + csContainerCfg;
  if FileExists(sLocIni) then
  begin
    ini := TIniFile.Create(sLocIni);
    c := Ini.ReadString('main', 'type', ' ')[1];
    vers := Ini.ReadString('main', 'version', '');
    FreeAndNil(ini);
    if (FileExists(sPath + csTableFiles)) and (vers <> aVersion) then
    begin
      table1 := TVKDBFNTX.Create(nil);
      InitOpenDBF(table1, sPath + csTableFiles, 64);
      table1.Open;
      while not (table1.Eof) do
      begin
        if FDataSet.Locate(csFieldSrvrFile + ';' + csFieldExt + ';' + csFieldType
          + ';' + csFieldSource + ';' + csFieldSID,
          varArrayOf([table1.fieldbyname(csFieldSrvrFile).AsString,
          table1.fieldbyname(csFieldExt).AsString,
            table1.fieldbyname(csFieldType).AsString, c, aSID]), []) then
        begin
          if FDataSet.fieldbyname(csFieldVersion).AsString <>
            table1.fieldbyname(csFieldVersion).AsString then
          begin
            if FileProcessing(Record2ClientFile(FDataSet, aSID, c),
              Record2ClientFile(table1, aSID, c)) then
            begin
              FDataSet.Edit;
              FileInfoMove(table1, FDataSet, False);
              FDataSet.Post;
            end;
          end
        end
        else
        begin
          if FileProcessing(Record2ClientFile(table1, aSID, c),
            Record2ClientFile(table1, aSID, c)) then
          begin
            FDataSet.Insert;
            FileInfoMove(table1, FDataSet, True);
            FDataSet.Post;
          end;
        end;
        table1.Next;
      end;
      table1.Close;
      FreeAndNil(table1);
      FIniFile.WriteString(c, aSID, vers);
    end;
    FDataSet.ApplyUpdates(-1);
//   FDataSet.Close;
//    FDataSet.Open;
  end;
end;

procedure TSAVAccessClient.DeleteContainerFile(const aDir, aSID: string);
var
  ini: TIniFile;
  c: Char;
  s: string;
  sPath, sPathIni: string;
  table1: TVKDBFNTX;
begin
  sPath := IncludeTrailingPathDelimiter(IncludeTrailingPathDelimiter(aDir) +
    aSID);
  sPathINI := sPath + csContainerCfg;
  if FileExists(sPathIni) then
  begin
    s := '';
    ini := TIniFile.Create(sPathIni);
    c := Ini.ReadString('main', 'type', ' ')[1];
    FreeAndNil(ini);
    if FileExists(sPath + csTableFiles) {and (vers <> aVersion)} then
    begin
      table1 := TVKDBFNTX.Create(nil);
      InitOpenDBF(table1, sPath + csTableFiles, 64);
      table1.Open;
      while not (table1.Eof) do
      begin
        if FileProcessing(Record2ClientFile(table1, aSID, c, 0),
          Record2ClientFile(table1, aSID, c, 0), True) then
        begin
          while FDataSet.Locate(csFieldClntFile + ';' + csFieldType,
            varArrayOf([table1.fieldbyname(csFieldClntFile).AsString,
            table1.fieldbyname(csFieldType).AsString]), []) do
            FDataSet.Delete;
        end;
        table1.Next;
      end;
      table1.Close;
      FreeAndNil(table1);
      FDataSet.ApplyUpdates(-1);
    end;
    if c <> ' ' then
      FIniFile.DeleteKey(c, aSID);
  end;
end;

procedure TSAVAccessClient.SetADGroupsDir(const Value: string);
begin
  FADGroupsDir := Value;
end;

end.

