object frmLuaGlobals: TfrmLuaGlobals
  Left = 481
  Top = 239
  Width = 440
  Height = 188
  BorderStyle = bsSizeToolWin
  Caption = 'Lua Globals'
  Color = clBtnFace
  DockSite = True
  DragKind = dkDock
  DragMode = dmAutomatic
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object tvwLuaGlobals: TTreeView
    Left = 0
    Top = 0
    Width = 432
    Height = 154
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    Indent = 19
    ParentFont = False
    SortType = stText
    TabOrder = 0
  end
  object JvDockClient1: TJvDockClient
    LRDockWidth = 100
    TBDockHeight = 100
    DirectDrag = False
    ShowHint = True
    EnableCloseButton = True
    DockStyle = frmMain.jvDockVSNet
    Left = 24
    Top = 16
  end
end