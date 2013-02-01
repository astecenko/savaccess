unit UAccessUserConst;

interface
const
  csUserRootConfig = 'SAVAccessClient'; // from AppData
  csUserConfig = 'Client\'; // from csUserRootConfig
  csPluginsDir = 'Plugins';

  {
  default network or local PC connection log directory
  set in ini configuration file:
  [option]
  netlog=\\workStation\networkDir\
   }
  csNetLogDef = '\\nevz\nevz\ASUP_Data1\PDO\1\';

  csStart_protocol = 'run://';
  csMainCaption = ' ÎËÂÌÚ ¿—”œ: ';
  csError_page = 'd:\html\error.html';

implementation


end.
