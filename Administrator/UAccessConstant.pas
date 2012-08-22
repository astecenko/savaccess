unit UAccessConstant;

interface

const
  { Directory default name }

  csDefUserDir='Users';
  csDefDomainDir='Domains';
  csDefJournalDir='Journal';
  csDefGroupDir='Groups';
  csDefADGroupDir='ADGroups';


  { Default filenames }

  csTemplateMain='main.tpl';
  csContainerCfg='container.cfg';
  csClientData='clientdata.cds';
  csWorkGroupsLst='workgroups.lst';

  { Tables filename }

  csTableDomains = 'domains.dbf'; //������
  csTableFiles = 'files.dbf'; //��������� � ������
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

   { ini-files }
   csIniUsers='users';
   csIniGroups='groups';

  { Others }

  csPattern='pattern';
  csDefaultUser = 'DEFAULT';
  csNotFound='!!! NOT FOUND !!!';

implementation

end.

