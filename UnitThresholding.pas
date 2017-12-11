unit UnitThresholding;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormThresholding = class(TForm)
    lbl1: TLabel;
    ScrollBar1: TScrollBar;
    Edit1: TEdit;
    Label1: TLabel;
    bproses: TButton;
    cekotoproses: TCheckBox;
    procedure ScrollBar1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Thresholding;
    procedure bprosesClick(Sender: TObject);
    procedure otoproses;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormThresholding: TFormThresholding;

implementation

uses UnitCitra, UnitHasil, UnitUtama;

{$R *.dfm}

procedure TFormThresholding.ScrollBar1Change(Sender: TObject);
begin
Edit1.Text := IntToStr(ScrollBar1.Position);
otoproses;
end;

procedure TFormThresholding.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Free;
end;

procedure TFormThresholding.Thresholding;
var
  i, j, Thresholding, gray: integer;
  PC, PH: PByteArray;
begin
  Thresholding := FormThresholding.ScrollBar1.Position;
  if (FormCitra.Image.Picture.Bitmap.PixelFormat = pf8bit)
  then
    for i:= 0 to FormCitra.Image.Picture.Height-1 do
      begin
        PC := FormCitra.Image.Picture.Bitmap.Scanline[i];
        PH := FormHasil.Image.Picture.Bitmap.Scanline[i];
        for j:= 0 to FormCitra.Image.Picture.Width-1 do
          begin
            if (PC[j] < Thresholding) then
              PH[j] := 0
            else
              PH[j] := 255;
          end;
      end;
  if (FormCitra.Image.Picture.Bitmap.PixelFormat = pf24bit)
  then
    for i:= 0 to FormCitra.Image.Picture.Height-1 do
      begin
        PC := FormCitra.Image.Picture.Bitmap.Scanline[i];
        PH := FormHasil.Image.Picture.Bitmap.Scanline[i];
        for j:= 0 to FormCitra.Image.Picture.Width-1 do
          begin
            gray := Round((PC[3*j]+PC[3*j+1]+PC[3*j+2])/3);
            if (gray < Thresholding) then
              begin
                PH[3*j] := 0;
                PH[3*j+1] := 0;
                PH[3*j+2] := 0;
              end
            else
              begin
                PH[3*j] := 255;
                PH[3*j+1] := 255;
                PH[3*j+2] := 255;
              end
          end;
      end;
end;

procedure TFormThresholding.bprosesClick(Sender: TObject);
begin
  Thresholding;
  FormHasil.Image.Repaint;
  if (FormUtama.cekhistogram.Checked) then
  FormUtama.TampilHistogram;
end;

procedure TFormThresholding.otoproses;
begin
  if cekotoproses.Checked then
  bprosesClick(Self);
end;

end.
