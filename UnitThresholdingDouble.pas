unit UnitThresholdingDouble;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormThresholdingDouble = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ScrollTAtas: TScrollBar;
    ScrollTBawah: TScrollBar;
    EditTAtas: TEdit;
    EditTBawah: TEdit;
    Label4: TLabel;
    bproses: TButton;
    cekotoproses: TCheckBox;
    procedure ScrollTAtasChange(Sender: TObject);
    procedure ScrollTBawahChange(Sender: TObject);
    procedure bprosesClick(Sender: TObject);
    procedure ThresholdingDouble;
    procedure otoproses;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormThresholdingDouble: TFormThresholdingDouble;

implementation

uses UnitHasil, UnitCitra, UnitUtama;

{$R *.dfm}

procedure TFormThresholdingDouble.ThresholdingDouble;
var
  i, j, ThresholdingBawah, ThresholdingAtas, gray: integer;
  PC, PH: PByteArray;
begin
  ThresholdingBawah := ScrollTBawah.Position;
  ThresholdingAtas := ScrollTAtas.Position;
  if (FormCitra.Image.Picture.Bitmap.PixelFormat = pf8bit)
  then
    for i:= 0 to FormCitra.Image.Picture.Height-1 do
      begin
        PC := FormCitra.Image.Picture.Bitmap.Scanline[i];
        PH := FormHasil.Image.Picture.Bitmap.Scanline[i];
        for j:= 0 to FormCitra.Image.Picture.Width-1 do
          begin
            if ((PC[j]>ThresholdingBawah) and (PC[j]<ThresholdingAtas))
            then
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
            if ((gray>ThresholdingBawah) and (gray<ThresholdingAtas))
            then
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


procedure TFormThresholdingDouble.ScrollTAtasChange(Sender: TObject);
begin
EditTAtas.Text := IntToStr(ScrollTAtas.Position);
otoproses;
end;

procedure TFormThresholdingDouble.ScrollTBawahChange(Sender: TObject);
begin
EditTBawah.Text := IntToStr(ScrollTBawah.Position);
otoproses;
end;

procedure TFormThresholdingDouble.bprosesClick(Sender: TObject);
begin
  ThresholdingDouble;
  FormHasil.Image.Repaint;
  if (FormUtama.cekhistogram.Checked) then
  FormUtama.TampilHistogram;
end;

procedure TFormThresholdingDouble.otoproses;
begin
  if cekotoproses.Checked then
  bprosesClick(Self);
end;

procedure TFormThresholdingDouble.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Free;
end;

end.
