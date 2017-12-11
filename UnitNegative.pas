unit UnitNegative;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormNegative = class(TForm)
    Label1: TLabel;
    bproses: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bprosesClick(Sender: TObject);
    procedure Negative;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormNegative: TFormNegative;

implementation

uses UnitHasil, UnitUtama, UnitCitra;

{$R *.dfm}

procedure TFormNegative.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Free;
end;

procedure TFormNegative.bprosesClick(Sender: TObject);
begin
  Negative;
  FormHasil.Image.Repaint;
  if (FormUtama.cekhistogram.Checked) then
  FormUtama.TampilHistogram;
end;

procedure TFormNegative.Negative;
var
  i, j: integer;
  PC, PH: PByteArray;
begin
  if (FormCitra.Image.Picture.Bitmap.PixelFormat = pf8bit)
  then
    begin
      for i:= 0 to FormCitra.Image.Picture.Height-1 do
        begin
          PC := FormCitra.Image.Picture.Bitmap.Scanline[i];
          PH := FormHasil.Image.Picture.Bitmap.Scanline[i];
          for j:= 0 to FormCitra.Image.Picture.Width-1 do
            begin
              PH[j] := 255-PC[j];
            end;
        end;
    end;
  if (FormCitra.Image.Picture.Bitmap.PixelFormat = pf24bit)
  then
    begin
      for i:= 0 to FormCitra.Image.Picture.Height-1 do
        begin
          PC := FormCitra.Image.Picture.Bitmap.Scanline[i];
          PH := FormHasil.Image.Picture.Bitmap.Scanline[i];
          for j:= 0 to FormCitra.Image.Picture.Width-1 do
            begin
              PH[3*j] := 255-PC[3*j];
              PH[3*j+1] := 255-PC[3*j+1];
              PH[3*j+2] := 255-PC[3*j+2];
            end;
        end;
    end;
end;


end.
