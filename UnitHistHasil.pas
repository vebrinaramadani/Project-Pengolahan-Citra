unit UnitHistHasil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TFormHistHasil = class(TForm)
  procedure MenghitungHistogram(max: Integer);
    procedure FormPaint(Sender: TObject);
    procedure FormActivate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    Picture: TPicture;
    c, cR, cG, cB: array [0..255] of Integer;
    cMax: Integer;
  end;

var
  FormHistHasil: TFormHistHasil;

implementation

{$R *.dfm}

procedure TFormHistHasil.MenghitungHistogram(max: Integer);
var
  i, j: Integer;
  PC: PByteArray;
begin
  if (Picture = nil) then
  Exit;
  if (Picture.Bitmap.PixelFormat = pf8bit) then
  begin
    for i := 0 to 255 do
      c[i] := 0;
    for i := 0 to Picture.Height-1 do
    begin
      PC := Picture.Bitmap.ScanLine[i];
      for j:= 0 to Picture.Width-1 do
        Inc(c[PC[j]]);
    end;
    if (max <> 0) then
      cMax := max
    else
    begin
      cMax := 0;
      for i := 0 to 255 do
        if (c[i] > cMax) then
          cMax := c[i];
    end;
  end;

  if (Picture.Bitmap.PixelFormat = pf24bit) then
   begin
     for i:= 0 to 255 do
       begin
         cR[i] := 0;
         cG[i] := 0;
         cB[i] := 0;
       end;
     for i := 0 to Picture.Height-1 do
       begin
         PC := Picture.Bitmap.ScanLine[i];
         for j:= 0 to Picture.Width-1 do
            begin
              Inc(cB[PC[3*j]]);
              Inc(cG[PC[3*j+1]]);
              Inc(cR[PC[3*j+2]]);
            end;
       end;
     if (max <> 0) then
      cMax := max
     else
        begin
         cMax := 0;
         for i := 0 to 255 do
           begin
             if (cR[i] > cMax) then
               cMax := cR[i];
             if (cG[i] > cMax) then
               cMax := cG[i];
             if (cB[i] > cMax) then
               cMax := cB[i];
            end;
        end;
    end;
end;

procedure TFormHistHasil.FormActivate(Sender: TObject);
begin
Repaint;
end;

procedure TFormHistHasil.FormPaint(Sender: TObject);
var
  i, w, h: Integer;
begin
  if (Picture = nil) then
  exit;
  w := ClientWidth-10;
  h := ClientHeight-10;
  Canvas.Pen.Color := clBlack;
  Canvas.Brush.Color := clWhite;
  Canvas.Rectangle (0,0,w+10,h+10);
  Canvas.Pen.Color := clSkyBlue;
  Canvas.MoveTo (10, h);
  Canvas.LineTo (10, 10);
  Canvas.MoveTo (10, h);
  Canvas.LineTo (w, h);
  if (Picture.Bitmap.PixelFormat = pf8bit) then
     begin
       Canvas.Pen.Color := clBlack;
       for i := 0 to 254 do
         begin
           Canvas.MoveTo (10+i, h-Round(c[i]/cMax*150));
           Canvas.LineTo(11+i, h-Round(c[i+1]/cMax*150));
         end;
     end;
  if (Picture.Bitmap.PixelFormat = pf24bit) then
     begin
       for i:=0 to 254 do
         begin
           Canvas.Pen.Color := clRed;
               Canvas.MoveTo (10+i, h-Round(cR[i]/cMax*150));
               Canvas.LineTo (10+i, h-Round(cR[i+1]/cMax*150));
           Canvas.Pen.Color := clGreen;
               Canvas.MoveTo (10+i, h-Round(cG[i]/cMax*150));
               Canvas.LineTo (10+i, h-Round(cG[i+1]/cMax*150));
           Canvas.Pen.Color := clBlue;
               Canvas.MoveTo (10+i, h-Round(cB[i]/cMax*150));
               Canvas.LineTo (10+i, h-Round(cB[i+1]/cMax*150));
         end;
     end;
end;
end.
