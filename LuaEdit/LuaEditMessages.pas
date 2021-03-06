unit LuaEditMessages;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvComponent, JvDockControlForm, VirtualTrees, ImgList;

type
  PLuaEditMsgLine = ^TPLuaEditMsgLine;
  TPLuaEditMsgLine = record
    FileName:   String;
    MsgText:    String;
    LineNumber: Integer;
    MsgType:    Integer;
  end;

  TfrmLuaEditMessages = class(TForm)
    JvDockClient1: TJvDockClient;
    vstLuaEditMessages: TVirtualStringTree;
    imlMessages: TImageList;
    procedure vstLuaEditMessagesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
    procedure vstLuaEditMessagesGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
    procedure vstLuaEditMessagesGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
    procedure vstLuaEditMessagesDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    function Put(MsgText: String; MsgType: Integer; FileName: String = ''; LineNumber: Integer = -1): PVirtualNode;
    function PutChild(Parent: PVirtualNode; MsgText: String; MsgType: Integer; FileName: String = ''; LineNumber: Integer = -1): PVirtualNode;
  end;

var
  frmLuaEditMessages: TfrmLuaEditMessages;

implementation

uses Main, Misc;

{$R *.dfm}

function TfrmLuaEditMessages.Put(MsgText: String; MsgType: Integer; FileName: String = ''; LineNumber: Integer = -1): PVirtualNode;
var
  pData: PLuaEditMsgLine;
  pNode: PVirtualNode;
begin
  pNode := vstLuaEditMessages.AddChild(vstLuaEditMessages.RootNode);
  pData := vstLuaEditMessages.GetNodeData(pNode);
  pData.FileName := FileName;
  pData.MsgText := MsgText;
  pData.MsgType := MsgType;
  pData.LineNumber := LineNumber;

  // Popup luaedit messages window if it's an error message
  if MsgType = LUAEDIT_ERROR_MSG then
    Self.Show;

  vstLuaEditMessages.FullExpand();
  Result := pNode;
end;

function TfrmLuaEditMessages.PutChild(Parent: PVirtualNode; MsgText: String; MsgType: Integer; FileName: String = ''; LineNumber: Integer = -1): PVirtualNode;
var
  pData: PLuaEditMsgLine;
  pNode: PVirtualNode;
begin
  pNode := vstLuaEditMessages.AddChild(Parent);
  pData := vstLuaEditMessages.GetNodeData(pNode);
  pData.FileName := FileName;
  pData.MsgText := MsgText;
  pData.MsgType := MsgType;
  pData.LineNumber := LineNumber;

  // Popup luaedit messages window if it's an error message
  if MsgType = LUAEDIT_ERROR_MSG then
    Self.Show;

  vstLuaEditMessages.FullExpand();
  Result := pNode;
end;

procedure TfrmLuaEditMessages.vstLuaEditMessagesGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
var
  pData: PLuaEditMsgLine;
begin
  case Column of
    0:
    begin
      pData := vstLuaEditMessages.GetNodeData(Node);

      case pData.MsgType of
        LUAEDIT_HINT_MSG:     CellText := '[HINT]';
        LUAEDIT_WARNING_MSG:  CellText := '[WARNING]';
        LUAEDIT_ERROR_MSG:    CellText := '[ERROR]';
      else
        CellText := '';
      end;
    end;
    1:
    begin
      pData := vstLuaEditMessages.GetNodeData(Node);
      CellText := TrimLeft(pData.MsgText);

      if pData.MsgType = LUAEDIT_ERROR_MSG then
        CellText := UpperCase(CellText[1]) + Copy(CellText, 2, Length(CellText) - 1);
    end;
  end;
end;

procedure TfrmLuaEditMessages.vstLuaEditMessagesGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean; var ImageIndex: Integer);
var
  pData: PLuaEditMsgLine;
begin
  case Column of
    0:
    begin
      pData := vstLuaEditMessages.GetNodeData(Node);
      ImageIndex := pData.MsgType - 1;
    end;
  end;
end;

procedure TfrmLuaEditMessages.vstLuaEditMessagesGetNodeDataSize(Sender: TBaseVirtualTree; var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(TPLuaEditMsgLine);
end;

procedure TfrmLuaEditMessages.vstLuaEditMessagesDblClick(Sender: TObject);
var
  pNode: PVirtualNode;
  pData: PLuaEditMsgLine;
begin
  if vstLuaEditMessages.SelectedCount = 1 then
  begin
    pNode := vstLuaEditMessages.GetFirstSelected();
    if Assigned(pNode) then
    begin
      pData := vstLuaEditMessages.GetNodeData(pNode);

      if pData.MsgType = LUAEDIT_ERROR_MSG then
        frmLuaEditMain.PopUpUnitToScreen(pData.FileName, pData.LineNumber, False, HIGHLIGHT_ERROR);
    end;
  end;
end;

end.
