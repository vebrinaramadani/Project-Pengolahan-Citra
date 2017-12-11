unit UnitBrightness;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TFormBrightness = class(TForm)
    Label1: TLabel;
    GroupBox1: TGroupBox;
    SpinEditBrightnessC: TSpinEdit;
    SpinEditBrightnessCG: TSpinEdit;
    SpinEditBrightnessCB: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    CheckBoxBrightness: TCheckBox;
    bproses: TButton;
    cekotoproses: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bprosesClick(Sender: TObject);
    procedure Brightness;
    procedure SpinEditBrightnessCChange(Sender: TObject);
    procedure SpinEditBrightnessCGChange(Sender: TObject);
    procedure SpinEditBrightnessCBChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBrightness: TFormBrightness;
  C, CR, CG, CB : integer;

implementation

uses UnitCitra, UnitHasil, UnitUtama;

{$R *.dfm}

procedure TFormBrightness.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Free;
end;

procedure TFormBrightness.bprosesClick(Sender: TObject);
begin
Brightness;
FormHasil.Image.Repaint;
if (FormUtama.cekhistogram.Checked) then
  FormUtama.TampilHistogram;
end;

procedure TFormBrightness.Brightness;
var
  i, j, temp: integer;
  PC, PH: PByteArray;
begin
  if (FormCitra.Image.Picture.Bitmap.PixelFormat = pf8bit)
  then
    begin
      for i:= 0 to FormCitra.Image.Picture.Height-1 do
        begin
          PC := FormCitra.Image.Picture.Bitmap.Scanline[i];
          PH := FormHasil.Image.Picture.Bitmap.Scanline[i];
          for j:= 0 to FormCitra.Image.Picture.Width-1 do
            begin
              temp := PC[j]+C;
              if (temp > 255) then
                temp := 255;
              if (temp < 0) then
                temp := 0;
              PH[j] := temp;
            end;
        end;
    end;
  if (FormCitra.Image.Picture.Bitmap.PixelFormat = pf24bit) then
    begin
      for i:= 0 to FormCitra.Image.Picture.Height-1 do
        begin
          PC := FormCitra.Image.Picture.Bitmap.Scanline[i];
          PH := FormHasil.Image.Picture.Bitmap.Scanline[i];
          for j:= 0 to FormCitra.Image.Picture.Width-1 do
            begin
              temp := PC[3*j]+CB;
              if (temp > 255) then
                temp := 255;
              if (temp < 0) then
                temp := 0;
              PH[3*j] := temp;
              temp := PC[3*j+1]+CG;
              if (temp > 255) then
                temp := 255;
              if (temp < 0) then
                temp := 0;
              PH[3*j+1] := temp;
              temp := PC[3*j+2]+CR;
              if (temp > 255) then
                temp := 255;
              if (temp < 0) then
                temp := 0;
              PH[3*j+2] := temp;
            end;
        end;
    end;
end;


procedure TFormBrightness.SpinEditBrightnessCChange(Sender: TObject);
begin
  C := SpinEditBrightnessC.Value;
  CR := SpinEditBrightnessC.Value;
  if (CheckBoxBrightness.Checked) then
  begin
    SpinEditBrightnessCG.Value := CR;
    SpinEditBrightnessCB.Value := CR;
  end;
  if (cekotoproses.Checked) then
  bprosesClick(Self);
end;

procedure TFormBrightness.SpinEditBrightnessCGChange(Sender: TObject);
begin
  CG := SpinEditBrightnessCG.Value;
  if (CheckBoxBrightness.Checked) then
  begin
    SpinEditBrightnessC.Value := CG;
    SpinEditBrightnessCB.Value := CG;
  end;
  if (cekotoproses.Checked) then
  bprosesClick(Self);
end;

procedure TFormBrightness.SpinEditBrightnessCBChange(Sender: TObject);
begin
  CB := SpinEditBrightnessCB.Value;
  if (CheckBoxBrightness.Checked) then
  begin
    SpinEditBrightnessC.Value := CB;
    SpinEditBrightnessCG.Value := CB;
  end;
  if (cekotoproses.Checked) then
  bprosesClick(Self);
end;

end.
