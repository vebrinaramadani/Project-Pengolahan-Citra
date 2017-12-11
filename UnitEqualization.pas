unit UnitEqualization;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TFormEqualization = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpinEditEqualization: TSpinEdit;
    bproses: TButton;
    cekotoproses: TCheckBox;
    procedure Equalization;
    procedure bprosesClick(Sender: TObject);
    procedure otoproses;
    procedure SpinEditEqualizationChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEqualization: TFormEqualization;

implementation

uses UnitCitra, UnitHasil, UnitUtama;

{$R *.dfm}

procedure TFormEqualization.Equalization;
var
  i, j, w, h, faktor: integer;
  Ki, Ri, Gi, Bi : array of array of integer;
  c, cR, cG, cB, cKum, cRKum, cGKum, cBKum: array of integer;
  Ko, Ro, Go, Bo: array of byte;
  PC, PH: PByteArray;
begin
  w := FormCitra.Image.Picture.Width;
  h := FormCitra.Image.Picture.Height;
  try
    faktor := StrToInt(SpinEditEqualization.Text);
  except
    faktor := 1;
  end;
  if (FormCitra.Image.Picture.Bitmap.PixelFormat = pf8bit)
  then
    begin
      SetLength(Ki, h, w);
      SetLength(c, faktor*256);
      SetLength(cKum, faktor*256);
      SetLength(Ko, faktor*256);
      for i:= 0 to h-1 do
        begin
          PC := FormCitra.Image.Picture.Bitmap.Scanline[i];
          for j:= 0 to w-1 do
            begin
              Ki[i,j] := faktor*PC[j]+Random(faktor);
              Inc(c[Ki[i,j]]);
            end;
        end;
      cKum[0] := c[0];
      for i := 1 to faktor*256-1 do
        cKum[i] := cKum[i-1]+c[i];
      for i := 0 to faktor*256-1 do
        Ko[i] := Round(255*cKum[i]/(w*h));
      for i:= 0 to h-1 do
        begin
          PH := FormHasil.Image.Picture.Bitmap.Scanline[i];
          for j:= 0 to w-1 do
            PH[j] := Ko[Ki[i,j]];
        end;
      Ki := nil;
      c := nil;
      cKum := nil;
      Ko := nil;
    end;
  if (FormCitra.Image.Picture.Bitmap.PixelFormat = pf24bit)
  then
    begin
      SetLength(Ri, h, w);
      SetLength(Gi, h, w);
      SetLength(Bi, h, w);
      SetLength(cR, faktor*256);
      SetLength(cG, faktor*256);
      SetLength(cB, faktor*256);
      SetLength(cRKum, faktor*256);
      SetLength(cGKum, faktor*256);
      SetLength(cBKum, faktor*256);
      SetLength(Ro, faktor*256);
      SetLength(Go, faktor*256);
      SetLength(Bo, faktor*256);
      for i:= 0 to h-1 do
        begin
          PC := FormCitra.Image.Picture.Bitmap.Scanline[i];
          for j:= 0 to w-1 do
            begin
              Bi[i,j] := faktor*PC[3*j]+Random(faktor);
              Inc(cB[Bi[i,j]]);
              Gi[i,j] := faktor*PC[3*j+1]+Random(faktor);
              Inc(cG[Gi[i,j]]);
              Ri[i,j] := faktor*PC[3*j+2]+Random(faktor);
              Inc(cR[Ri[i,j]]);
            end;
        end;
      cRKum[0] := cR[0];
      cGKum[0] := cG[0];
      cBKum[0] := cB[0];
      for i := 1 to faktor*256-1 do
        begin
          cRKum[i] := cRKum[i-1]+cR[i];
          cGKum[i] := cGKum[i-1]+cG[i];
          cBKum[i] := cBKum[i-1]+cB[i];
        end;
      for i := 0 to faktor*256-1 do
        begin
          Ro[i] := Round(255*cRKum[i]/(w*h));
          Go[i] := Round(255*cGKum[i]/(w*h));
          Bo[i] := Round(255*cBKum[i]/(w*h));
        end;
      for i:= 0 to h-1 do
        begin
          PH := FormHasil.Image.Picture.Bitmap.Scanline[i];
          for j:= 0 to w-1 do
            begin
              PH[3*j] := Bo[Bi[i,j]];
              PH[3*j+1] := Go[Gi[i,j]];
              PH[3*j+2] := Ro[Ri[i,j]];
            end;
        end;
      Ri := nil;
      Gi := nil;
      Bi := nil;
      cR := nil;
      cG := nil;
      cB := nil;
      cRKum := nil;
      cGKum := nil;
      cBKum := nil;
      Ro := nil;
      Go := nil;
      Bo := nil;
    end;
end;


procedure TFormEqualization.bprosesClick(Sender: TObject);
begin
Equalization;
  FormHasil.Image.Repaint;
  if (FormUtama.cekhistogram.Checked) then
  FormUtama.TampilHistogram;
end;

procedure TFormEqualization.otoproses;
begin
    if cekotoproses.Checked then
  bprosesClick(Self);
end;

procedure TFormEqualization.SpinEditEqualizationChange(Sender: TObject);
begin
otoproses;
end;

procedure TFormEqualization.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Free;
end;

end.
