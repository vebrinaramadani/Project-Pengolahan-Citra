unit UnitContrast;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TFormContrast = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    SpinEditContrast: TSpinEdit;
    EditContrast: TEdit;
    bproses: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Contrast;
    procedure bprosesClick(Sender: TObject);
    procedure SpinEditContrastChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormContrast: TFormContrast;

implementation

uses UnitHasil, UnitUtama, UnitCitra;

{$R *.dfm}

procedure TFormContrast.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Free;
end;

procedure TFormContrast.Contrast;
var
  i, j, P, temp: integer;
  G: real;
  PC, PH: PByteArray;
begin
  if (FormCitra.Image.Picture.Bitmap.PixelFormat = pf8bit)
  then
    begin
    try
      P := SpinEditContrast.Value;
      G := StrToFloat(EditContrast.Text);
    except
      P := 1;
      G := 1;
    end;
      for i:= 0 to FormCitra.Image.Picture.Height-1 do
        begin
          PC := FormCitra.Image.Picture.Bitmap.Scanline[i];
          PH := FormHasil.Image.Picture.Bitmap.Scanline[i];
          for j:= 0 to FormCitra.Image.Picture.Width-1 do
            begin
              temp := Round(G*(PC[j]-P)+P);
              if (temp > 255) then
                temp := 255;
              if (temp < 0) then
                temp := 0;
              PH[j] := temp;
            end;
        end;
    end;
  if (FormCitra.Image.Picture.Bitmap.PixelFormat = pf24bit)
  then
    begin
    try
      P := SpinEditContrast.Value;
      G := StrToFloat(EditContrast.Text);
    except
      P := 1;
      G := 1;
    end;
      for i:= 0 to FormCitra.Image.Picture.Height-1 do
        begin
          PC := FormCitra.Image.Picture.Bitmap.Scanline[i];
          PH := FormHasil.Image.Picture.Bitmap.Scanline[i];
          for j:= 0 to FormCitra.Image.Picture.Width-1 do
            begin
              temp := Round(G*(PC[3*j]-P)+P);
              if (temp > 255) then
                temp := 255;
              if (temp < 0) then
                temp := 0;
              PH[3*j] := temp;
              temp := Round(G*(PC[3*j+1]-P)+P);
              if (temp > 255) then
                temp := 255;
              if (temp < 0) then
                temp := 0;
              PH[3*j+1] := temp;
              temp := Round(G*(PC[3*j+2]-P)+P);
              if (temp > 255) then
                temp := 255;
              if (temp < 0) then
                temp := 0;
              PH[3*j+2] := temp;
            end;
        end;
    end;
end;

procedure TFormContrast.bprosesClick(Sender: TObject);
begin
  Contrast;
  FormHasil.Image.Repaint;
  if (FormUtama.cekhistogram.Checked) then
  FormUtama.TampilHistogram;
end;

procedure TFormContrast.SpinEditContrastChange(Sender: TObject);
begin
bprosesClick(Self);
end;

end.
