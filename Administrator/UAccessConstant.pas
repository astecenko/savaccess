unit UAccessConstant;

interface

const
  { Directory default name }

  csDefUserDir='Users';
  csDefDomainDir='Domains';
  csDefJournalDir='Journal';
  csDefGroupDir='Groups';

  { Default filenames }

  csTemplateMain='main.tpl';
  csContainerCfg='container.cfg';

  { Tables filename }

  csDomainsTable = 'domains.dbf'; //������
  csFilesTable = 'files.dbf'; //��������� � ������
  csGroupsTable = 'groups.dbf'; //������ �������
  csIniTable = 'ini.dbf'; //��������� � ini-������
  csOULinkTable = 'ou-links.dbf'; //����� ���.�������
  csOUTable = 'orgunit.dbf'; //���.������ (�������������)
  csProjectsTable = 'projects.dbf'; //������� (���������)
  csUsersTable = 'users.dbf'; //������������

  { Indexes filename }

  csUsersSIDIndex='users_sid.ntx';

  { Fields name}

  csFieldCaption = 'NAME';
  csFieldChild='CHILD';
  csFieldDescription = 'DESCR';
  csFieldDomain='DOMAIN';
  csFieldID = 'ID';
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

   { ini-files }
   csIniUsers='users';
   csIniGroups='groups';

  { Others }

  csPattern='pattern';
  csDefaultUser = 'DEFAULT';

implementation

end.

