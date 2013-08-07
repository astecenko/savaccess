unit UAccessConstant;

interface

const
  { Directory default name }

  csDefUserDir='U';
  csDefDomainDir='D';
  csDefJournalDir='J';
  csDefGroupDir='G';
  csDefADGroupDir='A';


  { Default filenames }

  csTemplateMain='main.tpl';
  csContainerCfg='container.cfg';
  csClientData='clientdata.cds';
  csWorkGroupsLst='workgroups.lst';
  csWorkADGroupsLst='workgadroups.lst';
  csManagersList='managers.pwd';
  csTCPLog='ip.log';

  { Tables filename }

  csTableDomains = 'domains.dbf'; //������
  csTableFiles = 'files.dbf'; //��������� � ������
  csTableFilesReverse='rfiles.dbf';
  csTableGroups = 'groups.dbf'; //������ �������
  csTableADGroups = 'adgroups.dbf'; //������ �������
  csTableIni = 'ini.dbf'; //��������� � ini-������
  csTableOULink = 'ou-links.dbf'; //����� ���.�������
  csTableOU = 'orgunit.dbf'; //���.������ (�������������)
  csTableProjects = 'projects.dbf'; //������� (���������)
  csTableUsers = 'users.dbf'; //������������
  csTableExt = 'extens.dbf';
  csTableAction = 'actions.dbf';
  csTableSupport = 'support.dbf';

  { Indexes filename }

  csUsersSIDIndex='users_sid.ntx';
  csIndexFilePriority='file_prio.ntx';
  csIndexFilePriorityR='rfile_prio.ntx';
  csIndexDomainVersion='dom_vers.ntx';
  csIndexDomainName='dom_name.ntx';
  csIndexADGroupVersion='adg_vers.ntx';
  csIndexADGroupName='adg_name.ntx';
  csIndexGroupVersion='grp_vers.ntx';
  csIndexGroupName='grp_name.ntx';
  csIndexUserVersion='usr_vers.ntx';
  csIndexUserName='usr_name.ntx';
  csIndexExtensExt='ext_ext.ntx';

  { Fields name}

  csFieldCaption = 'NAME';
  csFieldChild='CHILD';
  csFieldDescription = 'DESCR';
  csFieldDomain='DOMAIN';
  csFieldID = 'ID';
  csFieldFID = 'FID';
  csFieldIni='INIPATH';
  csFieldParent='PARENT';
  csFieldPath='FILEPATH';
  csFieldPrority='PRIORITY';
  csFieldSID = 'SID';
  csFieldVersion = 'VERSION';
  csFieldClntFile='CLNTFILE';
  csFieldSrvrFile='SRVRFILE';
  csFieldType='TYPE';
  csFieldExt='EXT';
  csFieldAction='ACTION';
  csFieldMD5='MD5';
  csFieldSource='SOURCE';
  csFieldSAMAccount='sAMAccountName';
  csFieldADDescription='description';
  csFieldCN='CN';
  csFieldDisting='distinguishedName';

   { ini-files }
   csIniUsers='users';
   csIniGroups='groups';
   csIniADGroups='adgroups';

   {  errors}

   csOpenError='������ �������� ';
   csSaveError='������ ���������� ';
   csFLockError='Unable FLock table! ';
   csTableCreateError='Table create error! ';
   csIndexCreateError='Index create error! ';

  { Others }

  csPattern='pattern';
  csDefaultUser = 'DEFAULT';
  csNotFound='!!! NOT FOUND !!!';

implementation

end.

