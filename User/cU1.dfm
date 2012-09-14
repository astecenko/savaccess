object SAVClntFrm1: TSAVClntFrm1
  Left = 328
  Top = 170
  Width = 156
  Height = 106
  Caption = 'SAVClntFrm1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object jvTray: TJvTrayIcon
    Active = True
    IconIndex = 0
    Hint = #1050#1083#1080#1077#1085#1090' '#1040#1057#1059#1055#13#10#1042#1077#1088#1089#1080#1103' 1.0'
    PopupMenu = pmMain
    Visibility = [tvVisibleTaskList, tvAutoHide, tvRestoreDbClick, tvMinimizeDbClick]
    Left = 32
    Top = 24
  end
  object pmMain: TPopupMenu
    Left = 48
    object N4: TMenuItem
      Caption = #1054#1090#1082#1088#1099#1090#1100
      OnClick = N4Click
    end
    object N2: TMenuItem
      Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1089#1086#1086#1073#1097#1077#1085#1080#1077
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N1: TMenuItem
      Action = actExit
    end
  end
  object actlst1: TActionList
    Left = 16
    object actExit: TAction
      Caption = #1042#1099#1093#1086#1076
      OnExecute = actExitExecute
    end
  end
  object idtcpsrvr1: TIdTCPServer
    Bindings = <>
    CommandHandlers = <
      item
        CmdDelimiter = ' '
        Command = 'QUIT'
        Disconnect = True
        Name = 'cmdhQuit'
        OnCommand = idtcpsrvr1cmdhQuitCommand
        ParamDelimiter = ' '
        ParseParams = False
        ReplyExceptionCode = 0
        ReplyNormal.NumericCode = 200
        ReplyNormal.Text.Strings = (
          'Good Bye')
        ReplyNormal.TextCode = '200'
        Tag = 0
      end
      item
        CmdDelimiter = ' '
        Command = 'UPDATE'
        Disconnect = False
        Name = 'cmdhUpdate'
        OnCommand = idtcpsrvr1cmdhUpdateCommand
        ParamDelimiter = #0
        ReplyExceptionCode = 0
        ReplyNormal.NumericCode = 200
        ReplyNormal.TextCode = '200'
        Tag = 0
      end
      item
        CmdDelimiter = ' '
        Command = 'HELP'
        Disconnect = False
        Name = 'cmdhHelp'
        OnCommand = idtcpsrvr1cmdhHelpCommand
        ParamDelimiter = ' '
        ReplyExceptionCode = 0
        ReplyNormal.NumericCode = 200
        ReplyNormal.Text.Strings = (
          'Help follows')
        ReplyNormal.TextCode = '200'
        Response.Strings = (
          'Exit - User'#39's log off'
          
            'Help - Display a list of supported commands and basic help on ea' +
            'ch'
          'Info <base name> - Show info'
          'List - Show opened bases'
          'Login <login> - Enter the user'#39's login '
          'Logout - synonym for Exit'
          'Open <config file name> - Open base via config name'
          'Password <password> - Enter the user'#39's password'
          'Quit - Terminate the session and disconnect'
          'Status - Display last run Update date and time'
          'Update <base name> - Run Update action or send status'
          'Whoami - Information about the current user'
          ''
          'Add the option All to view more commands')
        Tag = 0
      end
      item
        CmdDelimiter = ' '
        Command = 'OPEN'
        Disconnect = False
        Name = 'cmdhOpen'
        OnCommand = idtcpsrvr1cmdhOpenCommand
        ParamDelimiter = #0
        ReplyExceptionCode = 0
        ReplyNormal.NumericCode = 200
        ReplyNormal.TextCode = '200'
        Tag = 0
      end
      item
        CmdDelimiter = ' '
        Command = 'LIST'
        Disconnect = False
        Name = 'cmdhList'
        OnCommand = idtcpsrvr1cmdhListCommand
        ParamDelimiter = ' '
        ReplyExceptionCode = 0
        ReplyNormal.NumericCode = 200
        ReplyNormal.TextCode = '200'
        Tag = 0
      end
      item
        CmdDelimiter = ' '
        Command = 'STATUS'
        Disconnect = False
        Name = 'cmdhStatus'
        OnCommand = idtcpsrvr1cmdhStatusCommand
        ParamDelimiter = ' '
        ParseParams = False
        ReplyExceptionCode = 0
        ReplyNormal.NumericCode = 200
        ReplyNormal.TextCode = '200'
        Tag = 0
      end
      item
        CmdDelimiter = ' '
        Command = 'INFO'
        Disconnect = False
        Name = 'cmdhInfo'
        OnCommand = idtcpsrvr1cmdhInfoCommand
        ParamDelimiter = #0
        ReplyExceptionCode = 0
        ReplyNormal.NumericCode = 200
        ReplyNormal.TextCode = '200'
        Tag = 0
      end
      item
        CmdDelimiter = ' '
        Command = 'EXEC'
        Disconnect = False
        Name = 'cmdhExec'
        OnCommand = idtcpsrvr1cmdhExecCommand
        ParamDelimiter = #0
        ReplyExceptionCode = 0
        ReplyNormal.NumericCode = 200
        ReplyNormal.TextCode = '200'
        Tag = 0
      end
      item
        CmdDelimiter = ' '
        Command = 'SCREEN'
        Disconnect = False
        Name = 'cmdhScreen'
        OnCommand = idtcpsrvr1cmdhScreenCommand
        ParamDelimiter = #0
        ReplyExceptionCode = 0
        ReplyNormal.NumericCode = 200
        ReplyNormal.TextCode = '200'
        Tag = 0
      end
      item
        CmdDelimiter = ' '
        Command = 'LOGIN'
        Disconnect = False
        Name = 'cmdhLogin'
        OnCommand = idtcpsrvr1cmdhLoginCommand
        ParamDelimiter = ' '
        ReplyExceptionCode = 0
        ReplyNormal.NumericCode = 200
        ReplyNormal.Text.Strings = (
          'Login accepted')
        ReplyNormal.TextCode = '200'
        Tag = 0
      end
      item
        CmdDelimiter = ' '
        Command = 'PASSWORD'
        Disconnect = False
        Name = 'cmdhPassword'
        OnCommand = idtcpsrvr1TIdCommandPasswordCommand
        ParamDelimiter = #0
        ReplyExceptionCode = 0
        ReplyNormal.NumericCode = 200
        ReplyNormal.Text.Strings = (
          'Password accepted')
        ReplyNormal.TextCode = '200'
        Tag = 0
      end
      item
        CmdDelimiter = ' '
        Command = 'LOGOUT'
        Disconnect = False
        Name = 'cmdhLogout'
        OnCommand = idtcpsrvr1cmdhLogoutCommand
        ParamDelimiter = #0
        ParseParams = False
        ReplyExceptionCode = 0
        ReplyNormal.NumericCode = 200
        ReplyNormal.Text.Strings = (
          'Logout  successful')
        ReplyNormal.TextCode = '200'
        Tag = 0
      end
      item
        CmdDelimiter = ' '
        Command = 'EXIT'
        Disconnect = False
        Name = 'cmdhExit'
        OnCommand = idtcpsrvr1cmdhLogoutCommand
        ParamDelimiter = ' '
        ParseParams = False
        ReplyExceptionCode = 0
        ReplyNormal.NumericCode = 200
        ReplyNormal.Text.Strings = (
          'Logout  successful')
        ReplyNormal.TextCode = '200'
        Tag = 0
      end
      item
        CmdDelimiter = ' '
        Command = 'WHOAMI'
        Disconnect = False
        Name = 'cmdhWhoami'
        OnCommand = idtcpsrvr1cmdhWhoamiCommand
        ParamDelimiter = ' '
        ParseParams = False
        ReplyExceptionCode = 0
        ReplyNormal.NumericCode = 200
        ReplyNormal.TextCode = '200'
        Tag = 0
      end>
    DefaultPort = 45890
    Greeting.NumericCode = 200
    Greeting.Text.Strings = (
      'Hello')
    Greeting.TextCode = '200'
    MaxConnectionReply.NumericCode = 0
    OnBeforeCommandHandler = idtcpsrvr1BeforeCommandHandler
    OnConnect = idtcpsrvr1Connect
    OnDisconnect = idtcpsrvr1Disconnect
    ReplyExceptionCode = 500
    ReplyTexts = <>
    ReplyUnknownCommand.NumericCode = 400
    ReplyUnknownCommand.Text.Strings = (
      'Unknown Command')
    ReplyUnknownCommand.TextCode = '400'
    ThreadMgr = idthrdmgrdflt1
    Left = 48
    Top = 48
  end
  object idthrdmgrdflt1: TIdThreadMgrDefault
    Left = 64
    Top = 24
  end
  object idntfrz1: TIdAntiFreeze
    Left = 16
    Top = 48
  end
  object aplctnvnts1: TApplicationEvents
    OnException = aplctnvnts1Exception
    Top = 24
  end
end
