unit UnitConvolution;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormConvolution = class(TForm)
    Label1: TLabel;
    bproses: TButton;
    procedure bprosesClick(Sender: TObject);
    procedure Convolution;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormConvolution: TFormConvolution;

const
  M = 2;
  N = 2;
  MaskConvolution: array [-M..M,-N..N] of real =
    (( 1, 0, -1, 0,  1),
     ( 0, 0,  0, 0,  0),
     (-1, 0,  1, 0, -1),
     ( 0, 0,  0, 0,  0),
     ( 1, 0, -1, 0,  1));


implementation

uses UnitCitra, UnitHasil, UnitUtama;

{$R *.dfm}

procedure TFormConvolution.Convolution;
var
  x, y, w, h, k, l: integer;
  PC, PH: PByteArray;
  Ki, Ri, Gi, Bi, Ko, Ro, Go, Bo: array of array of byte;
  jumlah: real;
begin
  Randomize;
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
          PH := FormHasil.Image.Picture.Bitmap.Scanline[y];
          for x := 0 to w-1 do
            begin
              Ki[x, y] := PC[x];
              Ko[x, y] := PH[x];
            end;
        end;
      for x := M to w-M-1 do
        for y := N to h-N-1 do
          begin
            jumlah := 0;
            for k := -M to M do
              for l := -N to N do
                jumlah := jumlah+Ki[x-k,y-l]*MaskConvolution[k,l];
            if (Round(jumlah) < 0) then
              Ko[x,y] := 0
            else if (Round(jumlah) > 255) then
              Ko[x,y] := 255
            else
              Ko[x,y] := Round(jumlah);
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
          PH := FormHasil.Image.Picture.Bitmap.Scanline[y];
          for x := 0 to w-1 do
            begin
              Bi[x, y] := PC[3*x];
              Gi[x, y] := PC[3*x+1];
              Ri[x, y] := PC[3*x+2];
              Bo[x, y] := PH[3*x];
              Go[x, y] := PH[3*x+1];
              Ro[x, y] := PH[3*x+2];
            end;
        end;
      for x := M to w-M-1 do
        for y := N to h-N-1 do
          begin
            jumlah := 0;
            for k := -M to M do
              for l := -N to N do
                jumlah := jumlah+Ri[x-k,y-l]*MaskConvolution[k,l];
            if (Round(jumlah) < 0) then
              Ro[x,y] := 0
            else if (Round(jumlah) > 255) then
              Ro[x,y] := 255
            else
              Ro[x,y] := Round(jumlah);
            jumlah := 0;
            for k := -M to M do
              for l := -N to N do
                jumlah := jumlah+Gi[x-k,y-l]*MaskConvolution[k,l];
            if (Round(jumlah) < 0) then
              Go[x,y] := 0
            else if (Round(jumlah) > 255) then
              Go[x,y] := 255
            else
              Go[x,y] := Round(jumlah);
            jumlah := 0;
            for k := -M to M do
              for l := -N to N do
                jumlah := jumlah+Bi[x-k,y-l]*MaskConvolution[k,l];
            if (Round(jumlah) < 0) then
              Bo[x,y] := 0
            else if (Round(jumlah) > 255) then
              Bo[x,y] := 255
            else
              Bo[x,y] := Round(jumlah);
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


procedure TFormConvolution.bprosesClick(Sender: TObject);
begin
Convolution;
FormHasil.Image.Repaint;
if (FormUtama.cekhistogram.Checked) then
      FormUtama.TampilHistogram;
end;

procedure TFormConvolution.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Free;
end;

end.
