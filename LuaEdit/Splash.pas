unit Splash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg, JvGIF;

type
  TfrmSplash = class(TForm)
    Label3: TLabel;
    lblVersion: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    imlLua: TImage;
    Image1: TImage;
    Image2: TImage;
    shpBorder: TShape;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSplash: TfrmSplash;

implementation

uses Main, Misc;

{$R *.dfm}

procedure TfrmSplash.FormShow(Sender: TObject);
begin
  lblVersion.Caption := TCaption(GetFileVersion(PChar(Application.ExeName)));
end;

end.
