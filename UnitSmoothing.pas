unit UnitSmoothing;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFormSmoothing = class(TForm)
    Label1: TLabel;
    RadioGroup1: TRadioGroup;
    RadioButtonSmoothing5: TRadioButton;
    RadioButtonSmoothing9: TRadioButton;
    RadioButtonSmoothing25: TRadioButton;
    RadioButtonSmoothing49: TRadioButton;
    bproses: TButton;
    procedure Smoothing;
    procedure bprosesClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSmoothing: TFormSmoothing;

implementation

uses UnitCitra, UnitHasil, UnitUtama;

{$R *.dfm}

procedure TFormSmoothing.Smoothing;
var
  x, y, w, h: integer;
  PC, PH: PByteArray;
  Ki, Ri, Gi, Bi, Ko, Ro, Go, Bo: array of array of byte;
begin
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
      if (RadioButtonSmoothing5.Checked) then
        for x := 1 to w-2 do
          for y := 1 to h-2 do
            Ko[x,y] := Round((Ki[x,y-1]+Ki[x-1,y]
              +Ki[x+1,y]+Ki[x,y]+Ki[x,y+1])/5);
      if (RadioButtonSmoothing9.Checked) then
        for x := 1 to w-2 do
          for y := 1 to h-2 do
            Ko[x,y] := Round((Ki[x-1,y-1]+Ki[x,y-1]
              +Ki[x+1,y-1]+Ki[x-1,y]+Ki[x,y]+Ki[x+1,y]
              +Ki[x-1,y+1]+Ki[x,y+1]+Ki[x+1,y+1])/9);
      if (RadioButtonSmoothing25.Checked) then
        for x := 2 to w-3 do
          for y := 2 to h-3 do
            Ko[x,y] := Round((Ki[x-2,y-2]+Ki[x-1,y-2]
              +Ki[x,y-2]+Ki[x+1,y-2]+Ki[x+2,y-2]
              +Ki[x-2,y-1]+Ki[x-1,y-1]+Ki[x,y-1]
              +Ki[x+1,y-1]+Ki[x+2,y-1]+Ki[x-2,y]
              +Ki[x-1,y]+Ki[x,y]+Ki[x+1,y]+Ki[x+2,y]
              +Ki[x-2,y+1]+Ki[x-1,y+1]+Ki[x,y+1]
              +Ki[x+1,y+1]+Ki[x+2,y+1]+Ki[x-2,y+2]
              +Ki[x-1,y+2]+Ki[x,y+2]+Ki[x+1,y+2]
              +Ki[x+2,y+2])/25);
      if (RadioButtonSmoothing49.Checked) then
        for x := 3 to w-4 do
          for y := 3 to h-4 do
            Ko[x,y] := Round((Ki[x-3,y-3]+Ki[x-2,y-3]
              +Ki[x-1,y-3]+Ki[x,y-3]+Ki[x+1,y-3]
              +Ki[x+2,y-3]+Ki[x+3,y-3]+Ki[x-3,y-2]
              +Ki[x-2,y-2]+Ki[x-1,y-2]+Ki[x,y-2]
              +Ki[x+1,y-2]+Ki[x+2,y-2]+Ki[x+3,y-2]
              +Ki[x-3,y-1]+Ki[x-2,y-1]+Ki[x-1,y-1]
              +Ki[x,y-1]+Ki[x+1,y-1]+Ki[x+2,y-1]
              +Ki[x+3,y-1]+Ki[x-3,y]+Ki[x-2,y]+Ki[x-1,y]
              +Ki[x,y]+Ki[x+1,y]+Ki[x+2,y]+Ki[x+3,y]
              +Ki[x-3,y+1]+Ki[x-2,y+1]+Ki[x-1,y+1]
              +Ki[x,y+1]+Ki[x+1,y+1]+Ki[x+2,y+1]
              +Ki[x+3,y+1]+Ki[x-3,y+2]+Ki[x-2,y+2]
              +Ki[x-1,y+2]+Ki[x,y+2]+Ki[x+1,y+2]
              +Ki[x+2,y+2]+Ki[x+3,y+2]+Ki[x-3,y+3]
              +Ki[x-2,y+3]+Ki[x-1,y+3]+Ki[x,y+3]
              +Ki[x+1,y+3]+Ki[x+2,y+3]+Ki[x+3,y+3])/49);
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
      if (RadioButtonSmoothing5.Checked) then
        for x := 1 to w-2 do
          for y := 1 to h-2 do
            begin
              Ro[x,y] := Round((Ri[x,y-1]+Ri[x-1,y]
                +Ri[x+1,y]+Ri[x,y]+Ri[x,y+1])/5);
              Go[x,y] := Round((Gi[x,y-1]+Gi[x-1,y]
                +Gi[x+1,y]+Gi[x,y]+Gi[x,y+1])/5);
              Bo[x,y] := Round((Bi[x,y-1]+Bi[x-1,y]
                +Bi[x+1,y]+Bi[x,y]+Bi[x,y+1])/5);
            end;
      if (RadioButtonSmoothing9.Checked) then
        for x := 1 to w-2 do
          for y := 1 to h-2 do
            begin
              Ro[x,y] := Round((Ri[x-1,y-1]+Ri[x,y-1]
                +Ri[x+1,y-1]+Ri[x-1,y]+Ri[x,y]+Ri[x+1,y]
                +Ri[x-1,y+1]+Ri[x,y+1]+Ri[x+1,y+1])/9);
              Go[x,y] := Round((Gi[x-1,y-1]+Gi[x,y-1]
                +Gi[x+1,y-1]+Gi[x-1,y]+Gi[x,y]+Gi[x+1,y]
                +Gi[x-1,y+1]+Gi[x,y+1]+Gi[x+1,y+1])/9);
              Bo[x,y] := Round((Bi[x-1,y-1]+Bi[x,y-1]
                +Bi[x+1,y-1]+Bi[x-1,y]+Bi[x,y]+Bi[x+1,y]
                +Bi[x-1,y+1]+Bi[x,y+1]+Bi[x+1,y+1])/9);
            end;
      if (RadioButtonSmoothing25.Checked) then
        for x := 2 to w-3 do
          for y := 2 to h-3 do
            begin
              Ro[x,y] := Round((Ri[x-2,y-2]+Ri[x-1,y-2]
                +Ri[x,y-2]+Ri[x+1,y-2]+Ri[x+2,y-2]
                +Ri[x-2,y-1]+Ri[x-1,y-1]+Ri[x,y-1]
                +Ri[x+1,y-1]+Ri[x+2,y-1]+Ri[x-2,y]
                +Ri[x-1,y]+Ri[x,y]+Ri[x+1,y]+Ri[x+2,y]
                +Ri[x-2,y+1]+Ri[x-1,y+1]+Ri[x,y+1]
                +Ri[x+1,y+1]+Ri[x+2,y+1]+Ri[x-2,y+2]
                +Ri[x-1,y+2]+Ri[x,y+2]+Ri[x+1,y+2]
                +Ri[x+2,y+2])/25);
              Go[x,y] := Round((Gi[x-2,y-2]+Gi[x-1,y-2]
                +Gi[x,y-2]+Gi[x+1,y-2]+Gi[x+2,y-2]
                +Gi[x-2,y-1]+Gi[x-1,y-1]+Gi[x,y-1]
                +Gi[x+1,y-1]+Gi[x+2,y-1]+Gi[x-2,y]
                +Gi[x-1,y]+Gi[x,y]+Gi[x+1,y]+Gi[x+2,y]
                +Gi[x-2,y+1]+Gi[x-1,y+1]+Gi[x,y+1]
                +Gi[x+1,y+1]+Gi[x+2,y+1]+Gi[x-2,y+2]
                +Gi[x-1,y+2]+Gi[x,y+2]+Gi[x+1,y+2]
                +Gi[x+2,y+2])/25);
              Bo[x,y] := Round((Bi[x-2,y-2]+Bi[x-1,y-2]
                +Bi[x,y-2]+Bi[x+1,y-2]+Bi[x+2,y-2]
                +Bi[x-2,y-1]+Bi[x-1,y-1]+Bi[x,y-1]
                +Bi[x+1,y-1]+Bi[x+2,y-1]+Bi[x-2,y]
                +Bi[x-1,y]+Bi[x,y]+Bi[x+1,y]+Bi[x+2,y]
                +Bi[x-2,y+1]+Bi[x-1,y+1]+Bi[x,y+1]
                +Bi[x+1,y+1]+Bi[x+2,y+1]+Bi[x-2,y+2]
                +Bi[x-1,y+2]+Bi[x,y+2]+Bi[x+1,y+2]
                +Bi[x+2,y+2])/25);
            end;
      if (RadioButtonSmoothing49.Checked) then
        for x := 3 to w-4 do
          for y := 3 to h-4 do
            begin
              Ro[x,y] := Round((Ri[x-3,y-3]+Ri[x-2,y-3]
                +Ri[x-1,y-3]+Ri[x,y-3]+Ri[x+1,y-3]
                +Ri[x+2,y-3]+Ri[x+3,y-3]+Ri[x-3,y-2]
                +Ri[x-2,y-2]+Ri[x-1,y-2]+Ri[x,y-2]
                +Ri[x+1,y-2]+Ri[x+2,y-2]+Ri[x+3,y-2]
                +Ri[x-3,y-1]+Ri[x-2,y-1]+Ri[x-1,y-1]
                +Ri[x,y-1]+Ri[x+1,y-1]+Ri[x+2,y-1]
                +Ri[x+3,y-1]+Ri[x-3,y]+Ri[x-2,y]+Ri[x-1,y]
                +Ri[x,y]+Ri[x+1,y]+Ri[x+2,y]+Ri[x+3,y]
                +Ri[x-3,y+1]+Ri[x-2,y+1]+Ri[x-1,y+1]
                +Ri[x,y+1]+Ri[x+1,y+1]+Ri[x+2,y+1]
                +Ri[x+3,y+1]+Ri[x-3,y+2]+Ri[x-2,y+2]
                +Ri[x-1,y+2]+Ri[x,y+2]+Ri[x+1,y+2]
                +Ri[x+2,y+2]+Ri[x+3,y+2]+Ri[x-3,y+3]
                +Ri[x-2,y+3]+Ri[x-1,y+3]+Ri[x,y+3]
                +Ri[x+1,y+3]+Ri[x+2,y+3]+Ri[x+3,y+3])/49);
              Go[x,y] := Round((Gi[x-3,y-3]+Gi[x-2,y-3]
                +Gi[x-1,y-3]+Gi[x,y-3]+Gi[x+1,y-3]
                +Gi[x+2,y-3]+Gi[x+3,y-3]+Gi[x-3,y-2]
                +Gi[x-2,y-2]+Gi[x-1,y-2]+Gi[x,y-2]
                +Gi[x+1,y-2]+Gi[x+2,y-2]+Gi[x+3,y-2]
                +Gi[x-3,y-1]+Gi[x-2,y-1]+Gi[x-1,y-1]
                +Gi[x,y-1]+Gi[x+1,y-1]+Gi[x+2,y-1]
                +Gi[x+3,y-1]+Gi[x-3,y]+Gi[x-2,y]+Gi[x-1,y]
                +Gi[x,y]+Gi[x+1,y]+Gi[x+2,y]+Gi[x+3,y]
                +Gi[x-3,y+1]+Gi[x-2,y+1]+Gi[x-1,y+1]
                +Gi[x,y+1]+Gi[x+1,y+1]+Gi[x+2,y+1]
                +Gi[x+3,y+1]+Gi[x-3,y+2]+Gi[x-2,y+2]
                +Gi[x-1,y+2]+Gi[x,y+2]+Gi[x+1,y+2]
                +Gi[x+2,y+2]+Gi[x+3,y+2]+Gi[x-3,y+3]
                +Gi[x-2,y+3]+Gi[x-1,y+3]+Gi[x,y+3]
                +Gi[x+1,y+3]+Gi[x+2,y+3]+Gi[x+3,y+3])/49);
              Bo[x,y] := Round((Bi[x-3,y-3]+Bi[x-2,y-3]
                +Bi[x-1,y-3]+Bi[x,y-3]+Bi[x+1,y-3]
                +Bi[x+2,y-3]+Bi[x+3,y-3]+Bi[x-3,y-2]
                +Bi[x-2,y-2]+Bi[x-1,y-2]+Bi[x,y-2]
                +Bi[x+1,y-2]+Bi[x+2,y-2]+Bi[x+3,y-2]
                +Bi[x-3,y-1]+Bi[x-2,y-1]+Bi[x-1,y-1]
                +Bi[x,y-1]+Bi[x+1,y-1]+Bi[x+2,y-1]
                +Bi[x+3,y-1]+Bi[x-3,y]+Bi[x-2,y]+Bi[x-1,y]
                +Bi[x,y]+Bi[x+1,y]+Bi[x+2,y]+Bi[x+3,y]
                +Bi[x-3,y+1]+Bi[x-2,y+1]+Bi[x-1,y+1]
                +Bi[x,y+1]+Bi[x+1,y+1]+Bi[x+2,y+1]
                +Bi[x+3,y+1]+Bi[x-3,y+2]+Bi[x-2,y+2]
                +Bi[x-1,y+2]+Bi[x,y+2]+Bi[x+1,y+2]
                +Bi[x+2,y+2]+Bi[x+3,y+2]+Bi[x-3,y+3]
                +Bi[x-2,y+3]+Bi[x-1,y+3]+Bi[x,y+3]
                +Bi[x+1,y+3]+Bi[x+2,y+3]+Bi[x+3,y+3])/49);
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

procedure TFormSmoothing.bprosesClick(Sender: TObject);
begin
Smoothing;
FormHasil.Image.Repaint;
if (FormUtama.cekhistogram.Checked) then
      FormUtama.TampilHistogram;
end;

procedure TFormSmoothing.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Free;
end;

end.
