unit UnitNoise;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math;

type
  TFormNoise = class(TForm)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    RadioButtonNoiseGaussian: TRadioButton;
    RadioButtonNoiseSaltPepper: TRadioButton;
    bproses: TButton;
    EditNoise: TEdit;
    procedure Noise;
    procedure bprosesClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormNoise: TFormNoise;

implementation

uses UnitCitra, UnitHasil, UnitUtama;

{$R *.dfm}

procedure TFormNoise.Noise;
var
  x, y, w, h: integer;
  PC, PH: PByteArray;
  Ki, Ri, Gi, Bi, Ko, Ro, Go, Bo: array of array of byte;
  Noise, temp: real;
begin
  Randomize;
  try
    Noise := StrToFloat(EditNoise.Text);
  except
    Noise := 0.1;
  end;
  w := FormCitra.Image.Picture.Width;
  h := FormCitra.Image.Picture.Height;
  if (FormCitra.Image.Picture.Bitmap.PixelFormat = pf8bit)
  then
    begin
      SetLength(Ki, w, h);
      SetLength(Ko, w, h);
      for y := 0 to h-1 do
        begin
          PC := FormCitra.Image.Picture.Bitmap.Scanline[y];
          for x := 0 to w-1 do
            Ki[x, y] := PC[x];
        end;
      for x := 0 to w-1 do
        for y := 0 to h-1 do
          begin
            if (RadioButtonNoiseGaussian.Checked) then
              begin
                temp := Ki[x, y]+RandG(0, Noise*255);
                if (temp < 0) then
                  Ko[x, y] := 0
                else if (temp > 255) then
                  Ko[x, y] := 255
                else
                  Ko[x, y] := Round(temp);
              end;
            if (RadioButtonNoiseSaltPepper.Checked) then
              begin
                temp := Random;
                if (temp < Noise/2) then
                  Ko[x, y] := 0
                else if (temp > 1-(Noise/2)) then
                  Ko[x, y] := 255
                else
                  Ko[x, y] := Ki[x, y];
              end;
          end;
      for y := 0 to h-1 do
        begin
          PH := FormHasil.Image.Picture.Bitmap.Scanline[y];
          for x := 0 to w-1 do
            PH[x] := Ko[x, y];
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
      SetLength(Ro, w, h);
      SetLength(Go, w, h);
      SetLength(Bo, w, h);
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
      for x := 0 to w-1 do
        for y := 0 to h-1 do
          begin
            if (RadioButtonNoiseGaussian.Checked) then
              begin
                temp := Ri[x, y]+RandG(0, Noise*255);
                if (temp < 0) then
                  Ro[x, y] := 0
                else if (temp > 255) then
                  Ro[x, y] := 255
                else
                  Ro[x, y] := Round(temp);
              end;
            if (RadioButtonNoiseSaltPepper.Checked) then
              begin
                temp := Random;
                if (temp < Noise/2) then
                  Ro[x, y] := 0
                else if (temp > 1-(Noise/2)) then
                  Ro[x, y] := 255
                else
                  Ro[x, y] := Ri[x, y];
              end;
            if (RadioButtonNoiseGaussian.Checked) then
              begin
                temp := Gi[x, y]+RandG(0, Noise*255);
                if (temp < 0) then
                  Go[x, y] := 0
                else if (temp > 255) then
                  Go[x, y] := 255
                else
                  Go[x, y] := Round(temp);
              end;
            if (RadioButtonNoiseSaltPepper.Checked) then
              begin
                temp := Random;
                if (temp < Noise/2) then
                  Go[x, y] := 0
                else if (temp > 1-(Noise/2)) then
                  Go[x, y] := 255
                else
                  Go[x, y] := Gi[x, y];
              end;
            if (RadioButtonNoiseGaussian.Checked) then
              begin
                temp := Bi[x, y]+RandG(0, Noise*255);
                if (temp < 0) then
                  Bo[x, y] := 0
                else if (temp > 255) then
                  Bo[x, y] := 255
                else
                  Bo[x, y] := Round(temp);
              end;
            if (RadioButtonNoiseSaltPepper.Checked) then
              begin
                temp := Random;
                if (temp < Noise/2) then
                  Bo[x, y] := 0
                else if (temp > 1-(Noise/2)) then
                  Bo[x, y] := 255
                else
                  Bo[x, y] := Bi[x, y];
              end;
          end;
      for y := 0 to h-1 do
        begin
          PH := FormHasil.Image.Picture.Bitmap.Scanline[y];
          for x := 0 to w-1 do
            begin
              PH[3*x] := Bo[x, y];
              PH[3*x+1] := Go[x, y];
              PH[3*x+2] := Ro[x, y];
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

procedure TFormNoise.bprosesClick(Sender: TObject);
begin
  Noise;
FormHasil.Image.Repaint;
if (FormUtama.cekhistogram.Checked) then
      FormUtama.TampilHistogram;
end;

procedure TFormNoise.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Free;
end;

end.
