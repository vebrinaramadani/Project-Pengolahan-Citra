unit UnitRotation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFormRotation = class(TForm)
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    RadioButtonRotation1: TRadioButton;
    RadioButtonRotation2: TRadioButton;
    bproses: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bprosesClick(Sender: TObject);
    procedure Rotation;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormRotation: TFormRotation;

implementation

uses UnitHasil, UnitUtama, UnitCitra;

{$R *.dfm}

procedure TFormRotation.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Free;
end;

procedure TFormRotation.bprosesClick(Sender: TObject);
begin
  Rotation;
  FormHasil.Image.Repaint;
  if (FormUtama.cekhistogram.Checked) then
  FormUtama.TampilHistogram;
end;

procedure TFormRotation.Rotation;
var
  x, y, x1, y1, w, h, w1, h1: integer;
  PC, PH: PByteArray;
  Ki, Ri, Gi, Bi, Ko, Ro, Go, Bo: array of array of byte;
begin
  w := FormCitra.Image.Picture.Width;
  h := FormCitra.Image.Picture.Height;
  if (RadioButtonRotation1.Checked) then
    begin
      w1 := h;
      h1 := w;
    end;
  if (RadioButtonRotation2.Checked) then
    begin
      w1 := w;
      h1 := h;
    end;
  FormHasil.Image.Picture.Bitmap.Width := w1;
  FormHasil.Image.Picture.Bitmap.Height := h1;
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
      if (RadioButtonRotation1.Checked) then
        for x1 := 0 to w1-1 do
          for y1 := 0 to h1-1 do
            begin
              x := y1;
              y := w1-1-x1;
              Ko[x1, y1] := Ki[x, y];
            end;
      if (RadioButtonRotation2.Checked) then
        for x1 := 0 to w1-1 do
          for y1 := 0 to h1-1 do
            begin
              x := w1-1-x1;
              y := h1-1-y1;
              Ko[x1, y1] := Ki[x, y];
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
      if (RadioButtonRotation1.Checked) then
        for x1 := 0 to w1-1 do
          for y1 := 0 to h1-1 do
            begin
              x := y1;
              y := w1-1-x1;
              Ro[x1, y1] := Ri[x, y];
              Go[x1, y1] := Gi[x, y];
              Bo[x1, y1] := Bi[x, y];
            end;
      if (RadioButtonRotation2.Checked) then
        for x1 := 0 to w1-1 do
          for y1 := 0 to h1-1 do
            begin
              x := w1-1-x1;
              y := h1-1-y1;
              Ro[x1, y1] := Ri[x, y];
              Go[x1, y1] := Gi[x, y];
              Bo[x1, y1] := Bi[x, y];
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
  FormHasil.Image.ClientHeight := FormHasil.Image.Picture.Height;
  FormHasil.Image.ClientWidth := FormHasil.Image.Picture.Width;
  FormHasil.Image.ClientHeight := FormHasil.Image.Picture.Height;
end;


end.
