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

  csDomainsTable = 'domains.dbf'; //Домены
  csFilesTable = 'files.dbf'; //Настройки к файлам
  csGroupsTable = 'groups.dbf'; //Группы доступа
  csIniTable = 'ini.dbf'; //Настройки к ini-файлам
  csOULinkTable = 'ou-links.dbf'; //Связи орг.модулей
  csOUTable = 'orgunit.dbf'; //Орг.модули (подразделения)
  csProjectsTable = 'projects.dbf'; //Проекты (программы)
  csUsersTable = 'users.dbf'; //Пользователи

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

  { Others }

  csPattern='pattern';
  csDefaultUser = 'DEFAULT';

implementation

end.

