unit UnitMirroring;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFormMirroring = class(TForm)
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    RadioButtonMirroringHorizontal: TRadioButton;
    RadioButtonMirroringVertikal: TRadioButton;
    RadioButtonMirroringKombinasi: TRadioButton;
    bproses: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bprosesClick(Sender: TObject);
    procedure Mirroring;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMirroring: TFormMirroring;

implementation

uses UnitHasil, UnitUtama, UnitCitra;

{$R *.dfm}

procedure TFormMirroring.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Free;
end;

procedure TFormMirroring.bprosesClick(Sender: TObject);
begin
  Mirroring;
  FormHasil.Image.Repaint;
  if (FormUtama.cekhistogram.Checked) then
  FormUtama.TampilHistogram;
end;

procedure TFormMirroring.Mirroring;
var
  x, y, x1, y1, w, h, w1, h1: integer;
  PC, PH: PByteArray;
  Ki, Ri, Gi, Bi, Ko, Ro, Go, Bo: array of array of byte;
begin
  w := FormCitra.Image.Picture.Width;
  h := FormCitra.Image.Picture.Height;
  w1 := w;
  h1 := h;
  if (FormCitra.Image.Picture.Bitmap.PixelFormat = pf8bit)
  then
    begin
      SetLength(Ki, w, h);
      SetLength(Ko, w1, h1);
      for y := 0 to h-1 do
        begin
          PC := FormCitra.Image.Picture.Bitmap.Scanline[y];
          for x := 0 to w-1 do
            Ki[x, y] := PC[x];
        end;
      if (RadioButtonMirroringHorizontal.Checked) then
        begin
          for x1 := 0 to w1-1 do
            for y1 := 0 to h1-1 do
              begin
                x := w1-1-x1;
                y := y1;
                Ko[x1, y1] := Ki[x, y];
              end;
        end;
      if (RadioButtonMirroringVertikal.Checked) then
        begin
          for x1 := 0 to w1-1 do
            for y1 := 0 to h1-1 do
              begin
                x := x1;
                y := h1-1-y1;
                Ko[x1, y1] := Ki[x, y];
              end;
        end;
      if (RadioButtonMirroringKombinasi.Checked) then
        begin
          for x1 := 0 to w1-1 do
            for y1 := 0 to h1-1 do
              begin
                x := w1-1-x1;
                y := h1-1-y1;
                Ko[x1, y1] := Ki[x, y];
              end;
        end;
      for y1 := 0 to h1-1 do
        begin
          PH := FormHasil.Image.Picture.Bitmap.Scanline[y1];
          for x1 := 0 to w1-1 do
            PH[x1] := Ko[x1, y1];
        end;
      Ki := nil;
      Ko := nil;
    end;
  if (FormCitra.Image.Picture.Bitmap.PixelFormat = pf24bit)
  then
    begin
      SetLength(Ri, w, h);
      SetLength(Gi, w, h);
      SetLength(Bi, w, h);
      SetLength(Ro, w1, h1);
      SetLength(Go, w1, h1);
      SetLength(Bo, w1, h1);
      for y := 0 to h-1 do
        begin
          PC := FormCitra.Image.Picture.Bitmap.Scanline[y];
          for x := 0 to w-1 do
            begin
              Bi[x, y] := PC[3*x];
              Gi[x, y] := PC[3*x+1];
              Ri[x, y] := PC[3*x+2];
            end;
        end;
      if (RadioButtonMirroringHorizontal.Checked) then
        begin
          for x1 := 0 to w1-1 do
            for y1 := 0 to h1-1 do
              begin
                x := w1-1-x1;
                y := y1;
                Ro[x1, y1] := Ri[x, y];
                Go[x1, y1] := Gi[x, y];
                Bo[x1, y1] := Bi[x, y];
              end;
        end;
      if (RadioButtonMirroringVertikal.Checked) then
        begin
          for x1 := 0 to w1-1 do
            for y1 := 0 to h1-1 do
              begin
                x := x1;
                y := h1-1-y1;
                Ro[x1, y1] := Ri[x, y];
                Go[x1, y1] := Gi[x, y];
                Bo[x1, y1] := Bi[x, y];
              end;
        end;
      if (RadioButtonMirroringKombinasi.Checked) then
        begin
          for x1 := 0 to w1-1 do
            for y1 := 0 to h1-1 do
              begin
                x := w1-1-x1;
                y := h1-1-y1;
                Ro[x1, y1] := Ri[x, y];
                Go[x1, y1] := Gi[x, y];
                Bo[x1, y1] := Bi[x, y];
              end;
        end;
      for y1 := 0 to h1-1 do
        begin
          PH := FormHasil.Image.Picture.Bitmap.Scanline[y1];
          for x1 := 0 to w1-1 do
            begin
              PH[3*x1] := Bo[x1, y1];
              PH[3*x1+1] := Go[x1, y1];
              PH[3*x1+2] := Ro[x1, y1];
            end;
        end;
      Ri := nil;
      Gi := nil;
      Bi := nil;
      Ro := nil;
      Go := nil;
      Bo := nil;
    end;
end;

end.
