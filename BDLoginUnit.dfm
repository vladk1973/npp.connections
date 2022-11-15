inherited BDLoginForm: TBDLoginForm
  Left = 440
  Top = 383
  Caption = ''
  ClientHeight = 222
  ClientWidth = 239
  Color = clWindow
  KeyPreview = True
  OldCreateOrder = True
  Position = poScreenCenter
  StyleElements = []
  OnKeyDown = FormKeyDown
  ExplicitWidth = 245
  ExplicitHeight = 251
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage [0]
    Left = 5
    Top = 30
    Width = 16
    Height = 13
    AutoSize = True
    Picture.Data = {
      07544269746D6170A6020000424DA60200000000000036000000280000001000
      00000D0000000100180000000000700200000000000000000000000000000000
      0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8080
      80C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF808080000000FF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF808080C0C0C0000000FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFF000000000000FFFFFFFFFFFFFFFFFFFFFFFF0000000000
      00000000000000000000FFFFFFFFFFFF000000FFFFFF000000000000000000FF
      FFFFFFFFFFFFFFFFFFFFFF008080FFFFFF00FFFF008080000000FFFFFFFFFFFF
      000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF008080FFFF
      FF00FFFF008080000000FFFFFFFFFFFF000000000000000000FFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFF008080008080008080008080000000FFFFFFFFFFFF
      000000000000000000000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8080
      80C0C0C0000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFF808080C0C0C0000000FFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF000000C0C0
      C0FFFFFF808080000000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF000000000000000000C0C0C0FFFFFF000000FFFFFF808080000000000000
      000000000000000000000000000000000000C0C0C0C0C0C0C0C0C0FFFFFF0000
      00FFFFFF808080FFFFFFC0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0
      C0C0808080808080808080808080FFFFFFFFFFFFFFFFFF808080808080808080
      808080808080808080808080808080808080}
    Transparent = True
    Visible = False
  end
  object SLabel: TLabel [1]
    Left = 21
    Top = 67
    Width = 48
    Height = 13
    Caption = #1048#1089#1090#1086#1095#1085#1080#1082
    FocusControl = ServerList
  end
  object Label1: TLabel [2]
    Left = 21
    Top = 103
    Width = 25
    Height = 13
    HelpType = htKeyword
    HelpKeyword = 'Port'
    Caption = #1055#1086#1088#1090
  end
  object Label2: TLabel [3]
    Left = 21
    Top = 139
    Width = 22
    Height = 13
    HelpType = htKeyword
    HelpKeyword = 'Login'
    Caption = #1048#1084#1103
  end
  object Label3: TLabel [4]
    Left = 21
    Top = 175
    Width = 38
    Height = 13
    HelpType = htKeyword
    HelpKeyword = 'Password'
    Caption = #1055#1072#1088#1086#1083#1100
  end
  object Label4: TLabel [5]
    Left = 107
    Top = 37
    Width = 87
    Height = 13
    HelpType = htKeyword
    HelpKeyword = 'Custom select'
    Alignment = taRightJustify
    Caption = #1059#1082#1072#1079#1072#1090#1100' '#1074#1088#1091#1095#1085#1091#1102
  end
  inherited TopPanel: TPanel
    Width = 239
    TabOrder = 5
    ExplicitWidth = 239
  end
  inherited OkPanel: TPanel
    Left = 57
    Top = 179
    TabOrder = 6
    ExplicitLeft = 57
    ExplicitTop = 179
  end
  inherited CancelPanel: TPanel
    Left = 138
    Top = 179
    TabOrder = 7
    ExplicitLeft = 138
    ExplicitTop = 179
  end
  inherited CancelBtn: TBitBtn
    Left = 138
    Top = 209
    HelpType = htKeyword
    HelpKeyword = 'Cancel'
    TabOrder = 8
    ExplicitLeft = 138
    ExplicitTop = 209
  end
  inherited OkBtn: TBitBtn
    Left = 57
    Top = 209
    Action = OkAction
    TabOrder = 9
    ExplicitLeft = 57
    ExplicitTop = 209
  end
  object ServerList: TComboBox
    Left = 73
    Top = 64
    Width = 140
    Height = 24
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    Style = csOwnerDrawFixed
    Color = clWhite
    Ctl3D = False
    DoubleBuffered = False
    DropDownCount = 0
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 18
    ParentCtl3D = False
    ParentDoubleBuffered = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    StyleElements = []
    OnChange = ServerListChange
    OnDrawItem = ServerListDrawItem
  end
  object cbCustom: TCheckBox
    Left = 196
    Top = 36
    Width = 17
    Height = 17
    TabStop = False
    Action = customAction
    Alignment = taLeftJustify
    Caption = ' '
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clDefault
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 1
  end
  object Port: TEdit
    Left = 73
    Top = 100
    Width = 140
    Height = 21
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    Color = clWhite
    Enabled = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    StyleElements = []
  end
  object Password: TEdit
    Left = 73
    Top = 172
    Width = 140
    Height = 21
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    Color = clWhite
    ParentShowHint = False
    PasswordChar = '*'
    ShowHint = True
    TabOrder = 4
  end
  object Login: TEdit
    Left = 73
    Top = 136
    Width = 140
    Height = 21
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    Color = clWhite
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
  end
  object ActionList1: TActionList
    Left = 5
    Top = 155
    object OkAction: TAction
      Caption = 'OK'
      HelpKeyword = 'OK'
      OnExecute = OkActionExecute
      OnUpdate = OkActionUpdate
    end
    object customAction: TAction
      Caption = #1059#1082#1072#1079#1072#1090#1100' '#1074#1088#1091#1095#1085#1091#1102
      HelpKeyword = 'Custom select'
      OnExecute = customActionExecute
      OnUpdate = customActionUpdate
    end
  end
end
