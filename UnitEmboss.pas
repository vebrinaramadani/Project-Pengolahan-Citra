unit UnitEmboss;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormEmboss = class(TForm)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    RadioButtonEmbossKiri: TRadioButton;
    RadioButtonEmbossKananAtas: TRadioButton;
    Label2: TLabel;
    EditEmboss: TEdit;
    bproses: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Emboss;
    procedure bprosesClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Mask3x3 = array [-1..1,-1..1] of real;

var
  FormEmboss: TFormEmboss;
  MaskEmboss: Mask3x3;

implementation

uses UnitCitra, UnitHasil, UnitUtama;

{$R *.dfm}

procedure TFormEmboss.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Free;
end;

procedure TFormEmboss.Emboss;
var
  x, y, w, h, u, v: integer;
  PC, PH: PByteArray;
  Ki, Ri, Gi, Bi, Ko, Ro, Go, Bo: array of array of byte;
  beta, jumlah: real;
begin
  try
    beta := StrToFloat(EditEmboss.Text);
  except
    beta := 1
  end;
  if (RadioButtonEmbossKiri.Checked) then
    begin
      maskemboss[-1,-1] := -beta;
      maskemboss[ 0,-1] := 0;
      maskemboss[ 1,-1] := beta;
      maskemboss[-1, 0] := -beta;
      maskemboss[ 0, 0] := 1;
      maskemboss[ 1, 0] := beta;
      maskemboss[-1, 1] := -beta;
      maskemboss[ 0, 1] := 0;
      maskemboss[ 1, 1] := beta;
    end
  else
    begin
      maskemboss[-1,-1] := 0;
      maskemboss[ 0,-1] := -beta;
      maskemboss[ 1,-1] := -beta;
      maskemboss[-1, 0] := beta;
      maskemboss[ 0, 0] := 1;
      maskemboss[ 1, 0] := -beta;
      maskemboss[-1, 1] := beta;
      maskemboss[ 0, 1] := beta;
      maskemboss[ 1, 1] := 0;
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
          PH := FormHasil.Image.Picture.Bitmap.Scanline[y];
          for x := 0 to w-1 do
            begin
              Ki[x, y] := PC[x];
              Ko[x, y] := PH[x];
            end;
        end;
      for x := 1 to w-2 do
        for y := 1 to h-2 do
          begin
            jumlah := 0;
            for u := -1 to 1 do
              for v := -1 to 1 do
                jumlah := jumlah+MaskEmboss[u,v]*Ki[x-u,y-v];
            if (jumlah<0) then
              Ko[x,y] := 0
            else if (jumlah>255) then
              Ko[x,y] := 255
            else
              Ko[x,y] := Round(jumlah)
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
      for x := 1 to w-2 do
        for y := 1 to h-2 do
          begin
            jumlah := 0;
            for u := -1 to 1 do
              for v := -1 to 1 do
                jumlah := jumlah+MaskEmboss[u,v]*Ri[x-u,y-v];
            if (jumlah<0) then
              Ro[x,y] := 0
            else if (jumlah>255) then
              Ro[x,y] := 255
            else
              Ro[x,y] := Round(jumlah);
            jumlah := 0;
            for u := -1 to 1 do
              for v := -1 to 1 do
                jumlah := jumlah+MaskEmboss[u,v]*Gi[x-u,y-v];
            if (jumlah<0) then
              Go[x,y] := 0
            else if (jumlah>255) then
              Go[x,y] := 255
            else
              Go[x,y] := Round(jumlah);
            jumlah := 0;
            for u := -1 to 1 do
              for v := -1 to 1 do
                jumlah := jumlah+MaskEmboss[u,v]*Bi[x-u,y-v];
            if (jumlah<0) then
              Bo[x,y] := 0
            else if (jumlah>255) then
              Bo[x,y] := 255
            else
              Bo[x,y] := Round(jumlah)
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


procedure TFormEmboss.bprosesClick(Sender: TObject);
begin
  Emboss;
  FormHasil.Image.Repaint;
  if (FormUtama.cekhistogram.Checked) then
  FormUtama.TampilHistogram;
end;

end.
