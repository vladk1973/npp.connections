inherited logForm: TlogForm
  ClientHeight = 625
  ClientWidth = 860
  KeyPreview = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  ExplicitWidth = 876
  ExplicitHeight = 664
  PixelsPerInch = 96
  TextHeight = 13
  object BasesPanel: TSplitView
    Left = 0
    Top = 0
    Width = 210
    Height = 625
    Color = clWhite
    OpenedWidth = 210
    Placement = svpLeft
    TabOrder = 0
    object invTreeView: TTreeView
      Left = 112
      Top = 456
      Width = 57
      Height = 49
      BevelEdges = []
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Images = blackTreeImageList
      Indent = 21
      RightClickSelect = True
      ShowRoot = False
      TabOrder = 0
      Visible = False
    end
    object BDPanel: TPanel
      Left = 0
      Top = 0
      Width = 210
      Height = 23
      Align = alTop
      Alignment = taLeftJustify
      BevelEdges = [beBottom]
      BevelKind = bkFlat
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      PopupMenu = BDPopupMenu
      TabOrder = 1
      object msSQL: TPanel
        Left = 0
        Top = 1
        Width = 45
        Height = 20
        HelpContext = 1000
        BevelOuter = bvNone
        Caption = 'MS SQL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        OnClick = msModeActionExecute
        OnMouseEnter = P1MouseEnter
        OnMouseLeave = P1MouseLeave
      end
      object Sybase: TPanel
        Left = 45
        Top = 1
        Width = 48
        Height = 20
        HelpContext = 1001
        BevelOuter = bvNone
        Caption = 'SYBASE'
        Color = clBtnShadow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        OnClick = sybModeActionExecute
        OnMouseEnter = P1MouseEnter
        OnMouseLeave = P1MouseLeave
      end
      object PostgreSQL: TPanel
        Left = 93
        Top = 1
        Width = 72
        Height = 20
        HelpContext = 1002
        BevelOuter = bvNone
        Caption = 'POSTGRESQL'
        Color = clBtnShadow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
        OnClick = postgresqlModeActionExecute
        OnMouseEnter = P1MouseEnter
        OnMouseLeave = P1MouseLeave
      end
      object odbc: TPanel
        Left = 165
        Top = 1
        Width = 43
        Height = 20
        HelpContext = 1003
        BevelOuter = bvNone
        Caption = 'ODBC'
        Color = clBtnShadow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 3
        OnClick = odbcModeActionExecute
        OnMouseEnter = P1MouseEnter
        OnMouseLeave = P1MouseLeave
      end
    end
    object onePixelPanel1: TPanel
      Left = 0
      Top = 23
      Width = 210
      Height = 1
      Align = alTop
      BevelOuter = bvNone
      Color = clActiveCaption
      ParentBackground = False
      TabOrder = 2
    end
  end
  object Panel1: TPanel
    Left = 211
    Top = 0
    Width = 649
    Height = 625
    Align = alClient
    BevelEdges = [beLeft]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Caption = 'Panel1'
    ParentColor = True
    TabOrder = 1
    object ResultLabel: TPanel
      Left = 0
      Top = 0
      Width = 647
      Height = 23
      Align = alTop
      Alignment = taLeftJustify
      BevelEdges = [beBottom]
      BevelKind = bkFlat
      BevelOuter = bvNone
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      object rightPanel: TPanel
        Left = 516
        Top = 0
        Width = 131
        Height = 21
        Align = alRight
        BevelEdges = []
        BevelOuter = bvNone
        ParentColor = True
        TabOrder = 0
        object SqlButton: TPanel
          Left = 0
          Top = 1
          Width = 65
          Height = 20
          BevelOuter = bvNone
          Caption = #1047#1040#1055#1056#1054#1057#1067
          Color = clBtnShadow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 0
          OnClick = SqlShowModeActionExecute
          OnMouseEnter = P1MouseEnter
          OnMouseLeave = P1MouseLeave
        end
        object ProlivkaButton: TPanel
          Left = 65
          Top = 1
          Width = 65
          Height = 20
          BevelOuter = bvNone
          Caption = #1055#1056#1054#1051#1048#1042#1050#1040
          Color = clBtnShadow
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentBackground = False
          ParentFont = False
          TabOrder = 1
          OnClick = prolivkaShowModeActionExecute
          OnMouseEnter = P1MouseEnter
          OnMouseLeave = P1MouseLeave
        end
      end
    end
    object ButtonPanel: TPanel
      Left = 0
      Top = 603
      Width = 647
      Height = 22
      Align = alBottom
      BevelEdges = [beTop]
      BevelKind = bkFlat
      BevelOuter = bvNone
      Color = clBtnShadow
      ParentBackground = False
      TabOrder = 1
      object P1: TPanel
        Left = 0
        Top = 1
        Width = 60
        Height = 20
        BevelOuter = bvNone
        Caption = 'SQL'
        Color = clBtnShadow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 0
        OnClick = P1Click
        OnMouseEnter = P1MouseEnter
        OnMouseLeave = P1MouseLeave
      end
      object P2: TPanel
        Left = 60
        Top = 1
        Width = 60
        Height = 20
        BevelOuter = bvNone
        Caption = 'SQL'
        Color = clBtnShadow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 1
        Visible = False
        OnClick = P1Click
        OnMouseEnter = P1MouseEnter
        OnMouseLeave = P1MouseLeave
      end
      object P3: TPanel
        Left = 120
        Top = 1
        Width = 60
        Height = 20
        BevelOuter = bvNone
        Caption = 'SQL'
        Color = clBtnShadow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
        Visible = False
        OnClick = P1Click
        OnMouseEnter = P1MouseEnter
        OnMouseLeave = P1MouseLeave
      end
      object P4: TPanel
        Left = 180
        Top = 1
        Width = 60
        Height = 20
        BevelOuter = bvNone
        Caption = 'SQL'
        Color = clBtnShadow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 3
        Visible = False
        OnClick = P1Click
        OnMouseEnter = P1MouseEnter
        OnMouseLeave = P1MouseLeave
      end
      object P5: TPanel
        Left = 240
        Top = 1
        Width = 60
        Height = 20
        BevelOuter = bvNone
        Caption = 'SQL'
        Color = clBtnShadow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 4
        Visible = False
        OnClick = P1Click
        OnMouseEnter = P1MouseEnter
        OnMouseLeave = P1MouseLeave
      end
      object P6: TPanel
        Left = 300
        Top = 1
        Width = 60
        Height = 20
        BevelOuter = bvNone
        Caption = 'SQL'
        Color = clBtnShadow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 5
        Visible = False
        OnClick = P1Click
        OnMouseEnter = P1MouseEnter
        OnMouseLeave = P1MouseLeave
      end
      object P7: TPanel
        Left = 360
        Top = 1
        Width = 60
        Height = 20
        BevelOuter = bvNone
        Caption = 'SQL'
        Color = clBtnShadow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 6
        Visible = False
        OnClick = P1Click
        OnMouseEnter = P1MouseEnter
        OnMouseLeave = P1MouseLeave
      end
      object P8: TPanel
        Left = 420
        Top = 1
        Width = 60
        Height = 20
        BevelOuter = bvNone
        Caption = 'SQL'
        Color = clBtnShadow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 7
        Visible = False
        OnClick = P1Click
        OnMouseEnter = P1MouseEnter
        OnMouseLeave = P1MouseLeave
      end
      object P9: TPanel
        Left = 480
        Top = 1
        Width = 60
        Height = 20
        BevelOuter = bvNone
        Caption = 'SQL'
        Color = clBtnShadow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 8
        Visible = False
        OnClick = P1Click
        OnMouseEnter = P1MouseEnter
        OnMouseLeave = P1MouseLeave
      end
      object P10: TPanel
        Left = 540
        Top = 1
        Width = 60
        Height = 20
        BevelOuter = bvNone
        Caption = 'SQL'
        Color = clBtnShadow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 9
        Visible = False
        OnClick = P1Click
        OnMouseEnter = P1MouseEnter
        OnMouseLeave = P1MouseLeave
      end
      object NPanel: TPanel
        Left = 60
        Top = 1
        Width = 60
        Height = 20
        BevelOuter = bvNone
        Caption = '>>'
        Color = clBtnShadow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBackground = False
        ParentFont = False
        TabOrder = 10
        OnClick = NPanelClick
        OnMouseEnter = P1MouseEnter
        OnMouseLeave = P1MouseLeave
      end
    end
    object invGrid: TStringGrid
      Left = 41
      Top = 50
      Width = 333
      Height = 119
      BorderStyle = bsNone
      Color = clHighlight
      DefaultColWidth = 80
      DefaultRowHeight = 20
      DrawingStyle = gdsClassic
      FixedCols = 0
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
      ScrollBars = ssNone
      TabOrder = 2
      Visible = False
      StyleElements = []
      ColWidths = (
        80
        80
        80
        80
        80)
      RowHeights = (
        20
        20
        20
        20
        20)
    end
    object sql: TPanel
      Left = 60
      Top = 175
      Width = 296
      Height = 289
      BevelOuter = bvNone
      BorderWidth = 1
      Color = clTeal
      ParentBackground = False
      TabOrder = 3
      StyleElements = []
      object ActivityIndicator1: TActivityIndicator
        Left = 22
        Top = 10
        IndicatorSize = aisLarge
        IndicatorType = aitRotatingSector
      end
    end
    object LogBox: TListBox
      Left = 408
      Top = 224
      Width = 176
      Height = 71
      Style = lbOwnerDrawFixed
      BevelEdges = []
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clGradientInactiveCaption
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      PopupMenu = LogPopupMenu
      TabOrder = 4
      Visible = False
      OnDblClick = LogBoxDblClick
      OnDrawItem = LogBoxDrawItem
    end
    object onepixelPanel2: TPanel
      Left = 0
      Top = 23
      Width = 647
      Height = 1
      Align = alTop
      BevelOuter = bvNone
      Color = clActiveCaption
      ParentBackground = False
      TabOrder = 5
    end
    object ScrollBox1: TScrollBox
      Left = 456
      Top = 440
      Width = 185
      Height = 41
      TabOrder = 6
      Visible = False
    end
  end
  object LeftPanel: TPanel
    Left = 210
    Top = 0
    Width = 1
    Height = 625
    Align = alLeft
    BevelOuter = bvNone
    Color = clActiveCaption
    ParentBackground = False
    TabOrder = 2
  end
  object ActionManager1: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = OpenListBDAction
            ImageIndex = 13
            ShowCaption = False
          end
          item
            Action = SQLAction
            Caption = #1042#1099#1087#1086#1083#1085#1080#1090#1100' &SQL'
            ImageIndex = 9
            ShowCaption = False
          end
          item
            Caption = '-'
          end>
      end
      item
        Items = <
          item
            Action = msModeAction
            Caption = '&MS SQL'
          end
          item
            Action = sybModeAction
            Caption = '&SYBASE'
          end
          item
            Action = postgresqlModeAction
            Caption = '&POSTGRESQL'
          end
          item
            Action = odbcModeAction
            Caption = '&ODBC'
          end>
      end>
    Images = Images
    Left = 56
    Top = 176
    StyleName = 'Platform Default'
    object SQLAction: TAction
      Category = 'SQL'
      OnExecute = SQLActionExecute
    end
    object CopyGridRowAction: TAction
      Category = 'SQL'
      Caption = #1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
      HelpKeyword = 'Copy to clipboard'
      Hint = #1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
      ShortCut = 16451
      OnExecute = CopyGridRowActionExecute
    end
    object CopyAllGridAction: TAction
      Category = 'SQL'
      Caption = #1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      HelpKeyword = 'Copy table'
      Hint = #1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1090#1072#1073#1083#1080#1094#1091
      OnExecute = CopyAllGridActionExecute
    end
    object OpenListBDAction: TAction
      Category = 'BD'
      Caption = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
      HelpKeyword = 'Connections'
      Hint = #1055#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
      OnExecute = OpenListBDActionExecute
    end
    object ConnectAction: TAction
      Category = 'BD'
      Caption = #1053#1086#1074#1086#1077' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
      HelpKeyword = 'New connection'
      Hint = #1053#1086#1074#1086#1077' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1077
      OnExecute = ConnectActionExecute
    end
    object DisonnectSQLAction: TAction
      Category = 'BD'
      Caption = #1054#1090#1082#1083#1102#1095#1080#1090#1100#1089#1103
      HelpKeyword = 'Disconnect'
      Hint = #1054#1090#1082#1083#1102#1095#1080#1090#1100#1089#1103
      OnExecute = DisonnectSQLActionExecute
      OnUpdate = DisonnectSQLActionUpdate
    end
    object rtiRecordAction: TAction
      Category = 'BD'
      Caption = #1053#1072#1095#1072#1090#1100' '#1087#1088#1086#1090#1086#1082#1086#1083#1080#1088#1086#1074#1072#1085#1080#1077
      Hint = #1053#1072#1095#1072#1090#1100' '#1087#1088#1086#1090#1086#1082#1086#1083#1080#1088#1086#1074#1072#1085#1080#1077
      OnExecute = rtiRecordActionExecute
      OnUpdate = rtiRecordActionUpdate
    end
    object rtiRecordStopAction: TAction
      Category = 'BD'
      Caption = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1087#1088#1086#1090#1086#1082#1086#1083#1080#1088#1086#1074#1072#1085#1080#1077
      Hint = #1054#1089#1090#1072#1085#1086#1074#1080#1090#1100' '#1087#1088#1086#1090#1086#1082#1086#1083#1080#1088#1086#1074#1072#1085#1080#1077
      OnExecute = rtiRecordStopActionExecute
      OnUpdate = rtiRecordActionUpdate
    end
    object rtiSaveAction: TAction
      Category = 'BD'
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' RTI'
      Hint = #1057#1086#1093#1088#1072#1085#1080#1090#1100' RTI'
      OnExecute = rtiSaveActionExecute
      OnUpdate = rtiRecordActionUpdate
    end
    object rtiClearAction: TAction
      Category = 'BD'
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1083#1086#1075
      Hint = #1054#1095#1080#1089#1090#1080#1090#1100' '#1083#1086#1075
      OnExecute = rtiClearActionExecute
      OnUpdate = rtiRecordActionUpdate
    end
    object AfterSQLAction: TAction
      Category = 'SQL'
      Caption = 'AfterSQLAction'
      OnExecute = AfterSQLActionExecute
    end
    object PrAction: TAction
      Category = 'BD'
      Caption = #1055#1088#1086#1083#1080#1090#1100' '#1089#1082#1088#1080#1087#1090
      Hint = #1055#1088#1086#1083#1080#1090#1100' '#1089#1082#1088#1080#1087#1090
      OnExecute = PrActionExecute
      OnUpdate = PrActionUpdate
    end
    object msModeAction: TAction
      Category = 'BD'
      Caption = 'MS SQL'
      Hint = 'MS SQL'
      OnExecute = msModeActionExecute
    end
    object sybModeAction: TAction
      Category = 'BD'
      Caption = 'SYBASE'
      Hint = 'SYBASE'
      OnExecute = sybModeActionExecute
    end
    object postgresqlModeAction: TAction
      Category = 'BD'
      Caption = 'POSTGRESQL'
      Hint = 'POSTGRESQL'
      OnExecute = postgresqlModeActionExecute
    end
    object odbcModeAction: TAction
      Category = 'BD'
      Caption = 'ODBC'
      Hint = 'ODBC'
      OnExecute = odbcModeActionExecute
    end
    object AfterAddServerAction: TAction
      Category = 'BD'
      Caption = 'AfterAddServerAction'
      OnExecute = AfterAddServerActionExecute
    end
    object AfterSQLIndexAction: TAction
      Category = 'SQL'
      Caption = 'AfterSQLIndexAction'
      OnExecute = AfterSQLIndexActionExecute
    end
    object AfterRTIAction: TAction
      Category = 'BD'
      Caption = 'AfterRTIAction'
      OnExecute = AfterRTIActionExecute
    end
    object AfterClearRTIAction: TAction
      Category = 'BD'
      Caption = 'AfterClearRTIAction'
      OnExecute = AfterClearRTIActionExecute
    end
    object AfterWriteRTIAction: TAction
      Category = 'BD'
      Caption = 'AfterWriteRTIAction'
      OnExecute = AfterWriteRTIActionExecute
    end
    object DeclareVarsAction: TAction
      Category = 'SQL'
      Caption = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1076#1077#1082#1083#1072#1088#1072#1094#1080#1102' '#1087#1077#1088#1077#1084#1077#1085#1085#1099#1093
      Hint = #1057#1092#1086#1088#1084#1080#1088#1086#1074#1072#1090#1100' '#1076#1077#1082#1083#1072#1088#1072#1094#1080#1102' '#1087#1077#1088#1077#1084#1077#1085#1085#1099#1093
      OnExecute = DeclareVarsActionExecute
      OnUpdate = DeclareVarsActionUpdate
    end
    object addFavoriteConnectionAction: TAction
      Category = 'Favorite'
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100
      HelpKeyword = 'Save'
      OnExecute = addFavoriteConnectionActionExecute
      OnUpdate = DisonnectSQLActionUpdate
    end
    object removeFavoriteConnectionAction: TAction
      Category = 'Favorite'
      Caption = #1059#1076#1072#1083#1080#1090#1100
      HelpKeyword = 'Delete'
      OnExecute = removeFavoriteConnectionActionExecute
      OnUpdate = DisonnectSQLActionUpdate
    end
    object prolivkaShowModeAction: TAction
      Category = 'ShowMode'
      Caption = #1055#1088#1086#1083#1080#1074#1082#1072' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1099
      OnExecute = prolivkaShowModeActionExecute
    end
    object SqlShowModeAction: TAction
      Category = 'ShowMode'
      Caption = 'SQL '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1099
      HelpKeyword = 'SQL results'
      OnExecute = SqlShowModeActionExecute
    end
    object AfterPrAction: TAction
      Category = 'Prolivka'
      Caption = 'AfterPrAction'
      OnExecute = AfterPrActionExecute
    end
    object ReloadPrAction: TAction
      Category = 'Prolivka'
      Caption = 'ReloadPrAction'
      OnExecute = ReloadPrActionExecute
    end
    object SubFileAction: TAction
      Category = 'Prolivka'
      Caption = #1054#1090#1082#1088#1099#1090#1100' t01'
      Hint = #1054#1090#1082#1088#1099#1090#1100' t01'
      OnExecute = SubFileActionExecute
      OnUpdate = SubFileActionUpdate
    end
    object AfterConversionAction: TAction
      Category = 'Prolivka'
      Caption = 'AfterConversionAction'
      OnExecute = AfterConversionActionExecute
    end
    object pgConvertAction: TAction
      Category = 'Prolivka'
      Caption = #1050#1086#1085#1074#1077#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1074' PostgreSQL'
      Hint = #1050#1086#1085#1074#1077#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1074' PostgreSQL'
      ImageIndex = 1
      OnExecute = pgConvertActionExecute
      OnUpdate = SubFileActionUpdate
    end
    object InstallerLogAction: TAction
      Category = 'Prolivka'
      Caption = #1054#1090#1082#1088#1099#1090#1100' '#1087#1072#1087#1082#1091' '#1080#1085#1089#1090#1072#1083#1083#1103#1090#1086#1088#1072
      Hint = #1054#1090#1082#1088#1099#1090#1100' '#1087#1072#1087#1082#1091' '#1080#1085#1089#1090#1072#1083#1083#1103#1090#1086#1088#1072
      OnExecute = InstallerLogActionExecute
      OnUpdate = SubFileActionUpdate
    end
    object CopyLogAction: TAction
      Category = 'Prolivka'
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
      Hint = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074' '#1073#1091#1092#1077#1088' '#1086#1073#1084#1077#1085#1072
      OnExecute = CopyLogActionExecute
    end
    object AfterTableListAction: TAction
      Category = 'SQL'
      Caption = 'AfterTableListAction'
      OnExecute = AfterTableListActionExecute
    end
    object TableListAction: TAction
      Category = 'SQL'
      Caption = 'TableListAction'
      OnExecute = TableListActionExecute
    end
    object AfterFieldListAction: TAction
      Category = 'SQL'
      Caption = 'AfterFieldListAction'
      OnExecute = AfterFieldListActionExecute
    end
  end
  object blackTreeImageList: TImageList
    Height = 18
    Width = 18
    Left = 120
    Top = 576
    Bitmap = {
      494C010104009801140312001200FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000480000002400000001002000000000008028
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000DEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDE
      DEFFDEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000500FFFF0500FFFF0500FFFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEDEDEFF000000000000000000000000000000000000
      000000000000000000000000000000000000DEDEDEFF00000000000000000000
      0000000000000000000000000000FCFCFC17F0F0F06DDEDEDEFFDEDEDEFFDEDE
      DEFFDEDEDEFFF0F0F06DFCFCFC17000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FCFCFC17F0F0F06DDEDE
      DEFFDEDEDEFFDEDEDEFFDEDEDEFF0500FFFF0500FFFF0500FFFF0500FFFF0500
      FFFF00000000000000000000000000000000C6C6C6B5C1C1C1C6C1C1C1C6C1C1
      C1C6C1C1C1C6C1C1C1C6C1C1C1C6C1C1C1C6C1C1C1C6C1C1C1C6C1C1C1C6C1C1
      C1C6C1C1C1C6C6C6C6B500000000000000000000000000000000FCFCFC17F0F0
      F06DDEDEDEFFFEFEFE07DEDEDEFF000000000000000000000000000000000000
      000000000000000000000000000000000000DEDEDEFF00000000000000000000
      00000000000000000000ECECEC8FDEDEDEFF0000000000000000000000000000
      00000000000000000000DEDEDEFFECECEC8F0000000000000000000000000000
      000000000000000000000000000000000000ECECEC8FDEDEDEFF000000000000
      000000000000000000000500FFFF0500FFFF0500FFFF0500FFFF0500FFFF0500
      FFFF0500FFFF000000000000000000000000C2C2C2C3BBBBBBD9C1C1C1C6C1C1
      C1C6C1C1C1C6C1C1C1C6C1C1C1C6C1C1C1C6C1C1C1C6C1C1C1C6C1C1C1C6C1C1
      C1C6BBBBBBD9C2C2C2C3000000000000000000000000ECECEC8FDEDEDEFF0000
      00000000000000000000DEDEDEFF000000000000000000000000000000000000
      0000000000000000000000000000DEDEDEFFDEDEDEFF00000000000000000000
      00000000000000000000DEDEDEFF000000000000000000000000000000000000
      0000000000000000000000000000DEDEDEFF0000000000000000000000000000
      000000000000000000000000000000000000DEDEDEFF00000000000000000000
      000000000000000000000500FFFF0500FFFF0500FFFF0500FFFF0500FFFF0500
      FFFF0500FFFF000000000000000000000000C6C6C6B6BCBCBCD8000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BBBBBBD9C6C6C6B6000000000000000000000000DEDEDEFF000000000000
      00000000000000000000DEDEDEFF0000000000000000E9E9E9A7000000000000
      000000000000DEDEDEFFDEDEDEFFDEDEDEFF0000000000000000000000000000
      00000000000000000000DEDEDEFF000000000000000000000000000000000000
      0000000000000000000000000000DEDEDEFF0000000000000000000000000000
      000000000000000000000000000000000000DEDEDEFF00000000000000000000
      000000000000000000000500FFFF0500FFFF0500FFFF0500FFFF0500FFFF0500
      FFFF0500FFFF00000000000000000000000000000000BABABADDC7C7C7B40000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C6B5BABABADD00000000000000000000000000000000DEDEDEFF000000000000
      0000000000000000000000000000DEDEDEFFDEDEDEFFDEDEDEFF000000000000
      00000000000000000000DEDEDEFF000000000000000000000000000000000000
      00000000000000000000DEDEDEFFFCFCFC17F0F0F06DDEDEDEFFDEDEDEFFDEDE
      DEFFDEDEDEFFF0F0F06DFCFCFC17DEDEDEFF0000000000000000000000000000
      000000000000000000000000000000000000DEDEDEFFFCFCFC17F0F0F06DDEDE
      DEFFDEDEDEFFDEDEDEFFDEDEDEFF0500FFFF0500FFFF0500FFFF0500FFFF0500
      FFFF0000000000000000000000000000000000000000C5C5C5BBBABABADDC7C7
      C7B2000000000000000000000000000000000000000000000000C7C7C7B2BABA
      BADDC5C5C5BB00000000000000000000000000000000DEDEDEFFFCFCFC17F0F0
      F06DDEDEDEFFDEDEDEFFFEFEFE030000000000000000DEDEDEFF000000000000
      000000000000DEDEDEFFDEDEDEFF000000000000000000000000000000000000
      00000000000000000000DEDEDEFFDEDEDEFF0000000000000000000000000000
      00000000000000000000DEDEDEFFDEDEDEFF0000000000000000000000000000
      000000000000000000000000000000000000DEDEDEFFDEDEDEFF000000000000
      0000000000000000000000000000000000000500FFFF0500FFFF0500FFFF0000
      0000000000000000000000000000000000000000000000000000C2C2C2C2B9B9
      B9DFC5C5C5BB00000000000000000000000000000000C5C5C5BBB9B9B9DFC3C3
      C3C10000000000000000000000000000000000000000DEDEDEFFDEDEDEFF0000
      00000000000000000000000000000000000000000000DEDEDEFFDEDEDEFFDEDE
      DEFFDEDEDEFFDEDEDEFF00000000000000000000000000000000000000000000
      00000000000000000000DEDEDEFF000000000000000000000000000000000000
      0000000000000000000000000000DEDEDEFF0000000000000000000000000000
      000000000000000000000000000000000000DEDEDEFF00000000000000000000
      00000000000000000000000000000000000000000000DEDEDEFF000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C6B6BDBDBDD5B8B8B8E3BABABADEBABABADEB8B8B8E3BDBDBDD5C6C6C6B60000
      00000000000000000000000000000000000000000000DEDEDEFF000000000000
      0000000000000000000000000000000000000000000000000000FEFEFE030000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEDEDEFF000000000000000000000000000000000000
      0000000000000000000000000000DEDEDEFF0000000000000000000000000000
      000000000000000000000000000000000000DEDEDEFF00000000000000000000
      00000000000000000000000000000000000000000000DEDEDEFF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000BFBFBFCEBCBCBCD7C5C5C5BAC5C5C5BABCBCBCD7BFBFBFCD000000000000
      00000000000000000000000000000000000000000000DEDEDEFF000000000000
      0000000000000000000000000000000000000000000000000000DEDEDEFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEDEDEFF000000000000000000000000000000000000
      0000000000000000000000000000DEDEDEFF0000000000000000000000000000
      000000000000000000000000000000000000DEDEDEFF00000000000000000000
      00000000000000000000000000000000000000000000DEDEDEFF000000000000
      000000000000000000000000000000000000000000000000000000000000C5C5
      C5B9BBBBBBDA00000000000000000000000000000000BBBBBBDBC5C5C5B90000
      00000000000000000000000000000000000000000000DEDEDEFF000000000000
      0000000000000000000000000000000000000000000000000000DEDEDEFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEDEDEFFF5F5F54DE9E9E9A7DEDEDEFFDEDEDEFFDEDE
      DEFFDEDEDEFFE9E9E9A7F5F5F54DDEDEDEFF0000000000000000000000000000
      000000000000000000000000000000000000DEDEDEFFF5F5F54DE9E9E9A7DEDE
      DEFFDEDEDEFFDEDEDEFFDEDEDEFFE9E9E9A7F5F5F54DDEDEDEFF000000000000
      000000000000000000000000000000000000000000000000000000000000BFBF
      BFCCC2C2C2C300000000000000000000000000000000C2C2C2C3C0C0C0CB0000
      00000000000000000000000000000000000000000000DEDEDEFFF5F5F54DE9E9
      E9A7DEDEDEFFDEDEDEFFDEDEDEFFDEDEDEFFE9E9E9A7F5F5F54DDEDEDEFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEDEDEFFDEDEDEFF0000000000000000000000000000
      00000000000000000000DEDEDEFFDEDEDEFF0000000000000000000000000000
      000000000000000000000000000000000000DEDEDEFFDEDEDEFF000000000000
      000000000000000000000000000000000000DEDEDEFFDEDEDEFF000000000000
      000000000000000000000000000000000000000000000000000000000000C1C1
      C1C7C1C1C1C600000000000000000000000000000000C1C1C1C6C1C1C1C60000
      00000000000000000000000000000000000000000000DEDEDEFFDEDEDEFF0000
      00000000000000000000000000000000000000000000DEDEDEFFDEDEDEFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DEDEDEFF000000000000000000000000000000000000
      0000000000000000000000000000DEDEDEFF0000000000000000000000000000
      000000000000000000000000000000000000DEDEDEFF00000000000000000000
      00000000000000000000000000000000000000000000DEDEDEFF000000000000
      000000000000000000000000000000000000000000000000000000000000C6C6
      C6B5BABABADEC7C7C7B20000000000000000C7C7C7B2B9B9B9DFC7C7C7B40000
      00000000000000000000000000000000000000000000DEDEDEFF000000000000
      0000000000000000000000000000000000000000000000000000DEDEDEFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000F1F1F16ADEDEDEFFDEDEDEFF00000000000000000000
      00000000000000000000DEDEDEFFEDEDED860000000000000000000000000000
      000000000000000000000000000000000000F1F1F16ADEDEDEFFDEDEDEFF0000
      000000000000000000000000000000000000DEDEDEFFEDEDED86000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C3C3C3C1B9B9B9DFBFBFBFCEBFBFBFCEB9B9B9DFC3C3C3C0000000000000
      00000000000000000000000000000000000000000000F1F1F16ADEDEDEFFDEDE
      DEFF0000000000000000000000000000000000000000DEDEDEFFEDEDED860000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F5F5F54DE9E9E9A7E2E2E2DFDEDEDEFADEDE
      DEFAE2E2E2DFE9E9E9A7F5F5F54D000000000000000000000000000000000000
      00000000000000000000000000000000000000000000F5F5F54DE9E9E9A7E2E2
      E2DFDEDEDEFADEDEDEFAE2E2E2DFE9E9E9A7F5F5F54D00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C7C7C7B2C3C3C3BFC4C4C4BEC7C7C7B200000000000000000000
      0000000000000000000000000000000000000000000000000000F5F5F54DE9E9
      E9A7E2E2E2DFDEDEDEFADEDEDEFAE2E2E2DFE9E9E9A7F5F5F54D000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000048000000240000000100010000000000B00100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FFFFFFFFFFFFFFFFFF000000FE00FFFFFFFF1FFFFF000000
      FDFF7E01FF800F0003000000C1FF7CFCFF3C0700030000009DFE7DFEFF7C073F
      F3000000BDB8FDFEFF7C079FE7000000BE3DFC00FF000F8FC700000081B9FCFC
      FF3F1FC78F0000009F83FDFEFF7FBFE01F000000BFDFFDFEFF7FBFF03F000000
      BFDFFDFEFF7FBFE79F000000BFDFFC00FF003FE79F000000801FFCFCFF3F3FE7
      9F0000009F9FFDFEFF7FBFE31F000000BFDFFC7CFF1F3FF03F0000008F9FFE01
      FF807FF87F000000C03FFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000
      00000000000000000000000000000000000000000000}
  end
  object TreeViewPopupMenu: TPopupMenu
    OnPopup = TreeViewPopupMenuPopup
    Left = 160
    Top = 202
    object New_Connection: TMenuItem
      Action = ConnectAction
    end
    object Disconnect: TMenuItem
      Action = DisonnectSQLAction
    end
    object N6: TMenuItem
      Caption = '-'
    end
    object My_Connections: TMenuItem
      Caption = #1052#1086#1080' '#1087#1086#1076#1082#1083#1102#1095#1077#1085#1080#1103
      Hint = 'My connections'
      object AddOrRemoveFavoriteItem: TMenuItem
        Action = addFavoriteConnectionAction
      end
      object NFavoriteLine: TMenuItem
        Caption = '-'
      end
    end
    object N10: TMenuItem
      Caption = '-'
    end
    object RTIStartItem: TMenuItem
      Action = rtiRecordAction
    end
    object RTIStopItem: TMenuItem
      Action = rtiRecordStopAction
    end
    object RTI2: TMenuItem
      Action = rtiSaveAction
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N12: TMenuItem
      Action = rtiClearAction
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object N5: TMenuItem
      Action = PrAction
    end
  end
  object GridMenu: TPopupMenu
    Left = 204
    Top = 335
    object N1: TMenuItem
      Action = CopyGridRowAction
    end
    object N2: TMenuItem
      Action = CopyAllGridAction
    end
    object N7: TMenuItem
      Caption = '-'
    end
    object N13: TMenuItem
      Action = DeclareVarsAction
    end
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'rti'
    Left = 92
    Top = 99
  end
  object whiteTreeImageList: TImageList
    Height = 18
    Width = 18
    Left = 112
    Top = 528
    Bitmap = {
      494C010104006C01000312001200FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000480000002400000001002000000000008028
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000383838FF383838FF383838FF383838FF3838
      38FF383838FF383838FF383838FF383838FF0000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000500FFFF0500FFFF0500FFFF0000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000383838FF000000000000000000000000000000000000
      000000000000000000000000000000000000383838FF00000000000000000000
      0000000000000000000000000000EAEAEA17A0A0A06D212121FF212121FF2121
      21FF212121FFA0A0A06DEAEAEA17000000000000000000000000000000000000
      00000000000000000000000000000000000000000000EAEAEA17A0A0A06D2121
      21FF212121FF212121FF212121FF0500FFFF0500FFFF0500FFFF0500FFFF0500
      FFFF000000000000000000000000000000004A4A4AB5393939C6393939C63939
      39C6393939C6393939C6393939C6393939C6393939C6393939C6393939C63939
      39C6393939C64A4A4AB500000000000000000000000000000000EDEDED17A9A9
      A96D383838FFF9F9F907383838FF000000000000000000000000000000000000
      000000000000000000000000000000000000383838FF00000000000000000000
      000000000000000000008282828F212121FF0000000000000000000000000000
      00000000000000000000212121FF8282828F0000000000000000000000000000
      0000000000000000000000000000000000008282828F212121FF000000000000
      000000000000000000000500FFFF0500FFFF0500FFFF0500FFFF0500FFFF0500
      FFFF0500FFFF0000000000000000000000003C3C3CC3262626D9393939C63939
      39C6393939C6393939C6393939C6393939C6393939C6393939C6393939C63939
      39C6262626D93C3C3CC30000000000000000000000008F8F8F8F383838FF0000
      00000000000000000000383838FF000000000000000000000000000000000000
      0000000000000000000000000000383838FF383838FF00000000000000000000
      00000000000000000000212121FF000000000000000000000000000000000000
      0000000000000000000000000000212121FF0000000000000000000000000000
      000000000000000000000000000000000000212121FF00000000000000000000
      000000000000000000000500FFFF0500FFFF0500FFFF0500FFFF0500FFFF0500
      FFFF0500FFFF000000000000000000000000494949B6272727D8000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000262626D9494949B6000000000000000000000000383838FF000000000000
      00000000000000000000383838FF00000000000000007C7C7CA7000000000000
      000000000000383838FF383838FF383838FF0000000000000000000000000000
      00000000000000000000212121FF000000000000000000000000000000000000
      0000000000000000000000000000212121FF0000000000000000000000000000
      000000000000000000000000000000000000212121FF00000000000000000000
      000000000000000000000500FFFF0500FFFF0500FFFF0500FFFF0500FFFF0500
      FFFF0500FFFF00000000000000000000000000000000222222DD4B4B4BB40000
      0000000000000000000000000000000000000000000000000000000000004A4A
      4AB5222222DD00000000000000000000000000000000383838FF000000000000
      0000000000000000000000000000383838FF383838FF383838FF000000000000
      00000000000000000000383838FF000000000000000000000000000000000000
      00000000000000000000212121FFEAEAEA17A0A0A06D212121FF212121FF2121
      21FF212121FFA0A0A06DEAEAEA17212121FF0000000000000000000000000000
      000000000000000000000000000000000000212121FFEAEAEA17A0A0A06D2121
      21FF212121FF212121FF212121FF0500FFFF0500FFFF0500FFFF0500FFFF0500
      FFFF0000000000000000000000000000000000000000444444BB222222DD4D4D
      4DB20000000000000000000000000000000000000000000000004D4D4DB22222
      22DD444444BB00000000000000000000000000000000383838FFEDEDED17A9A9
      A96D383838FF383838FFFCFCFC030000000000000000383838FF000000000000
      000000000000383838FF383838FF000000000000000000000000000000000000
      00000000000000000000212121FF212121FF0000000000000000000000000000
      00000000000000000000212121FF212121FF0000000000000000000000000000
      000000000000000000000000000000000000212121FF212121FF000000000000
      0000000000000000000000000000000000000500FFFF0500FFFF0500FFFF0000
      00000000000000000000000000000000000000000000000000003D3D3DC22020
      20DF444444BB00000000000000000000000000000000444444BB202020DF3E3E
      3EC10000000000000000000000000000000000000000383838FF383838FF0000
      00000000000000000000000000000000000000000000383838FF383838FF3838
      38FF383838FF383838FF00000000000000000000000000000000000000000000
      00000000000000000000212121FF000000000000000000000000000000000000
      0000000000000000000000000000212121FF0000000000000000000000000000
      000000000000000000000000000000000000212121FF00000000000000000000
      00000000000000000000000000000000000000000000212121FF000000000000
      0000000000000000000000000000000000000000000000000000000000004949
      49B62A2A2AD51C1C1CE3212121DE212121DE1C1C1CE32A2A2AD5494949B60000
      00000000000000000000000000000000000000000000383838FF000000000000
      0000000000000000000000000000000000000000000000000000FCFCFC030000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000212121FF000000000000000000000000000000000000
      0000000000000000000000000000212121FF0000000000000000000000000000
      000000000000000000000000000000000000212121FF00000000000000000000
      00000000000000000000000000000000000000000000212121FF000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000313131CE282828D7454545BA454545BA282828D7323232CD000000000000
      00000000000000000000000000000000000000000000383838FF000000000000
      0000000000000000000000000000000000000000000000000000383838FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000212121FF000000000000000000000000000000000000
      0000000000000000000000000000212121FF0000000000000000000000000000
      000000000000000000000000000000000000212121FF00000000000000000000
      00000000000000000000000000000000000000000000212121FF000000000000
      0000000000000000000000000000000000000000000000000000000000004646
      46B9252525DA00000000000000000000000000000000242424DB464646B90000
      00000000000000000000000000000000000000000000383838FF000000000000
      0000000000000000000000000000000000000000000000000000383838FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000212121FFBBBBBB4D6D6D6DA7212121FF212121FF2121
      21FF212121FF6D6D6DA7BBBBBB4D212121FF0000000000000000000000000000
      000000000000000000000000000000000000212121FFBBBBBB4D6D6D6DA72121
      21FF212121FF212121FF212121FF6D6D6DA7BBBBBB4D212121FF000000000000
      0000000000000000000000000000000000000000000000000000000000003333
      33CC3C3C3CC3000000000000000000000000000000003C3C3CC3343434CB0000
      00000000000000000000000000000000000000000000383838FFC2C2C24D7C7C
      7CA7383838FF383838FF383838FF383838FF7C7C7CA7C2C2C24D383838FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000212121FF212121FF0000000000000000000000000000
      00000000000000000000212121FF212121FF0000000000000000000000000000
      000000000000000000000000000000000000212121FF212121FF000000000000
      000000000000000000000000000000000000212121FF212121FF000000000000
      0000000000000000000000000000000000000000000000000000000000003838
      38C7393939C600000000000000000000000000000000393939C6393939C60000
      00000000000000000000000000000000000000000000383838FF383838FF0000
      00000000000000000000000000000000000000000000383838FF383838FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000212121FF000000000000000000000000000000000000
      0000000000000000000000000000212121FF0000000000000000000000000000
      000000000000000000000000000000000000212121FF00000000000000000000
      00000000000000000000000000000000000000000000212121FF000000000000
      0000000000000000000000000000000000000000000000000000000000004A4A
      4AB5212121DE4D4D4DB200000000000000004D4D4DB2202020DF4B4B4BB40000
      00000000000000000000000000000000000000000000383838FF000000000000
      0000000000000000000000000000000000000000000000000000383838FF0000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000A2A2A26A212121FF212121FF00000000000000000000
      00000000000000000000212121FF8A8A8A860000000000000000000000000000
      000000000000000000000000000000000000A2A2A26A212121FF212121FF0000
      000000000000000000000000000000000000212121FF8A8A8A86000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00003E3E3EC1202020DF313131CE313131CE202020DF3F3F3FC0000000000000
      00000000000000000000000000000000000000000000ACACAC6A383838FF3838
      38FF0000000000000000000000000000000000000000383838FF969696860000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000BBBBBB4D6D6D6DA73C3C3CDF252525FA2525
      25FA3C3C3CDF6D6D6DA7BBBBBB4D000000000000000000000000000000000000
      00000000000000000000000000000000000000000000BBBBBB4D6D6D6DA73C3C
      3CDF252525FA252525FA3C3C3CDF6D6D6DA7BBBBBB4D00000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000004D4D4DB2404040BF414141BE4D4D4DB200000000000000000000
      0000000000000000000000000000000000000000000000000000C2C2C24D7C7C
      7CA7505050DF3B3B3BFA3B3B3BFA505050DF7C7C7CA7C2C2C24D000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000048000000240000000100010000000000B00100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FFFFFFFFFFFFFFFFFF000000FE00FFFFFFFF1FFFFF000000
      FDFF7E01FF800F0003000000C1FF7CFCFF3C0700030000009DFE7DFEFF7C073F
      F3000000BDB8FDFEFF7C079FE7000000BE3DFC00FF000F8FC700000081B9FCFC
      FF3F1FC78F0000009F83FDFEFF7FBFE01F000000BFDFFDFEFF7FBFF03F000000
      BFDFFDFEFF7FBFE79F000000BFDFFC00FF003FE79F000000801FFCFCFF3F3FE7
      9F0000009F9FFDFEFF7FBFE31F000000BFDFFC7CFF1F3FF03F0000008F9FFE01
      FF807FF87F000000C03FFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFF000000
      00000000000000000000000000000000000000000000}
  end
  object Images: TImageList
    Left = 176
    Top = 40
    Bitmap = {
      494C010102009000640110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000FFFFFF14FFFFFF6EFFFFFF7FFFFFFF220000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF09FAF4EC58E2C593DFD8AF6AE1F4E9D6A0FFFF
      FF15000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF1CF2E6D09EC88E2DFFC17F12FFD9B170E2FFFF
      FF5A000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000FFFFFF21EFDFC3BABE7905FFBD7600FFCD9943ECFFFF
      FF7A000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF07FDFBF848F8F2
      E6B0FBF7F0A0F2E6D1B5F4E9D7C1EEDDC0E6BC7500FFBC7500FFCC973FF6FFFF
      FFBDFFFFFF64FFFFFF2A00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000212C7B003149CE003149CE003149CE00212C7B000000
      00000000000000000000000000000000000000000000FEFDFB2CEDDABBCDCD97
      3EFEDBB778F8E6CDA1FFE1C18DFFE7CCA1FDBC7500FFBC7500FFCA9133FEEAD4
      B0F5D5A960E7EAD6B4BDFFFFFF47000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000212C7B004259DE006B8AFF00738EFF006B8AFF004259DE00212C
      7B0000000000000000000000000000000000FFFFFF0BF8F1E56BD8AF69FFBD77
      03FFCF9B46FFEEDBBCFFE3C594FFCF9B46FFBC7600FFBC7600FFC78B28FFE9D3
      ACFFEFDFC4F1F8F1E6A7FFFFFF45000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003149CE005A7DFF00637DFF005A79FF00637DFF005A7DFF003149
      CE0000000000000000000000000000000000FFFFFF20F1E3CCADC4861EFFC485
      1CFFD8AF6BFFD2A151FFD6AA61FFD1A150FFBC7600FFBE7905FFD09D4AFFF4E7
      D2FFEEDCBEDDFFFFFF54FFFEFE0C000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003149CE006B8AFF004A6DFF004A6DFF004A6DFF006B8AFF003149
      CE0000000000000000000000000000000000FDFCF931E8CFA7E4BC7500FFC88D
      2BFFDEBC82FFBE7A07FFCB9337FFDCB678FFBC7400FFC4861EFFDFBE86FFE1C1
      8BFFDCB87CF2FBF6EE8D00000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000003149CE0094A6FF005A79FF005271FF005A79FF0094A6FF003149
      CE0000000000000000000000000000000000F9F4EB48DCB77AFFBB7400FFC88E
      2DFFDFBC83FFBF7A06FFD1A04EFFDCB678FFBB7400FFC99030FFECD8B5FFDAB3
      72FFD3A355FFEBD6B4C5FFFFFF13000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000182C7B00425DDE0094A6FF0094AEFF0094A6FF00425DDE00182C
      7B0000000000000000000000000000000000F6EDDF68D3A557FFBC7400FFC88D
      2BFFE4C899FFDBB677FFE8CEA4FFD1A04FFFBC7400FFC99031FFF0E2C9FFE6CC
      A0FFCF9D48FFDAB576DBFFFFFF46000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000182C7B003149CE003149CE003149CE00182C7B000000
      000000000000000000000000000000000000F5EBDB74D09D4AFFBC7500FFC689
      23FFDFBD85FFD8B06BFFD1A14FFFC17E10FFBD7601FFC07D0DFFD3A457FFE4C9
      99FFC99031FFD1A150E5FFFFFF66000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000F7EEE065D4A75BFFBC7500FFC07E
      0FFFD2A353FFD9B271FFBE7905FFBD7600FFBD7601FFBE7804FFCE9A43FFE0C1
      8BFFC07C0CFFD2A353E8FFFFFF6E000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FCFAF63EE6CDA0F0C07C0CFFBC74
      00FFC68A26FFDFBC83FFD09D4AFFBE7A07FFC38217FFD5A85CFFDEBB7FFFC88D
      2AFFCB9437FFEDDBBBCBFFFFFF2D000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000FFFFFE0FFAF5ED69EBD5B1DAE0C0
      89FEE6CEA2EDF6EDDDBCF5ECDB9CEFDFC5BBF1E3CACBF2E5CFEDEAD3ADFFE7CC
      A0EBF3E6D2A2FDFBF83DFFFFFF04000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000FFFFFF0DFEFDFB2EFBF7
      F03AFCFAF634FFFFFF25FFFFFF1AFFFFFF25FFFFFF2AFEFDFB35FAF5EE3BFCFA
      F734FFFFFF1DFFFFFF0200000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFE1F00000000FFFFFC0F00000000
      FFFFFC0F00000000FFFFFC0F00000000FFFF800300000000FC1F800100000000
      F80F000100000000F80F000100000000F80F000300000000F80F000100000000
      F80F000100000000FC1F000100000000FFFF000100000000FFFF000100000000
      FFFF000100000000FFFF80030000000000000000000000000000000000000000
      000000000000}
  end
  object LogPopupMenu: TPopupMenu
    Images = Images
    Left = 752
    Top = 242
    object MenuItem2: TMenuItem
      Action = SubFileAction
    end
    object MenuItem3: TMenuItem
      Action = InstallerLogAction
    end
    object MenuItem4: TMenuItem
      Caption = '-'
    end
    object PostgreSQL1: TMenuItem
      Action = pgConvertAction
    end
    object MenuItem5: TMenuItem
      Caption = '-'
    end
    object MenuItem6: TMenuItem
      Action = CopyLogAction
    end
  end
  object BDPopupMenu: TPopupMenu
    Left = 144
    Top = 32
    object MSSQL1: TMenuItem
      Caption = 'MS SQL'
      Checked = True
      HelpContext = 1000
      OnClick = MSSQL1Click
    end
    object SYBASE1: TMenuItem
      Caption = 'SYBASE'
      Checked = True
      HelpContext = 1001
      OnClick = MSSQL1Click
    end
    object POSTGRESQL2: TMenuItem
      Caption = 'POSTGRESQL'
      Checked = True
      HelpContext = 1002
      OnClick = MSSQL1Click
    end
    object ODBC1: TMenuItem
      Caption = 'ODBC'
      Checked = True
      HelpContext = 1003
      OnClick = MSSQL1Click
    end
  end
end
