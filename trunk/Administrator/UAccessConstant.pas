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
  csWorkADGroupsLst='workgadroups.lst';
  csManagersList='managers.pwd';
  csTCPLog='ip.log';

  { Tables filename }

  csTableDomains = 'domains.dbf'; //Домены
  csTableFiles = 'files.dbf'; //Настройки к файлам
  csTableGroups = 'groups.dbf'; //Группы доступа
  csTableADGroups = 'adgroups.dbf'; //Группы доступа
  csTableIni = 'ini.dbf'; //Настройки к ini-файлам
  csTableOULink = 'ou-links.dbf'; //Связи орг.модулей
  csTableOU = 'orgunit.dbf'; //Орг.модули (подразделения)
  csTableProjects = 'projects.dbf'; //Проекты (программы)
  csTableUsers = 'users.dbf'; //Пользователи
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
  csFieldSAMAccount='sAMAccountName';
  csFieldADDescription='description';
  csFieldCN='CN';
  csFieldDisting='distinguishedName';

   { ini-files }
   csIniUsers='users';
   csIniGroups='groups';
   csIniADGroups='adgroups';

   {  errors}

   csOpenError='Ошибка открытия ';
   csSaveError='Ошибка сохранения ';

  { Others }

  csPattern='pattern';
  csDefaultUser = 'DEFAULT';
  csNotFound='!!! NOT FOUND !!!';

implementation

end.

