unit UnitUtama;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtDlgs, StdCtrls, ComCtrls, ExtCtrls, Buttons;

type
  TFormUtama = class(TForm)
    PanelAtas: TPanel;
    StatusBar: TStatusBar;
    OpenPictureDialog: TOpenPictureDialog;
    combomenu: TComboBox;
    cekhistogram: TCheckBox;
    SavePictureDialog1: TSavePictureDialog;
    bbuka: TBitBtn;
    bsimpan: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    procedure bbukaClick(Sender: TObject);
    procedure combomenuChange(Sender: TObject);
    procedure bsalinClick(Sender: TObject);
    procedure cekhistogramClick(Sender: TObject);
    procedure TampilHistogram;
    procedure bsimpanClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormUtama: TFormUtama;

implementation

uses
  UnitCitra, UnitThresholding, UnitHasil, UnitThresholdingDouble,
  UnitHistAwal, UnitHistHasil, UnitSmoothing, UnitConvolution,
  UnitEqualization, UnitBrightness, UnitNoise, UnitEdgeDetection,
  UnitEmboss, UnitContrast, UnitSharpening, UnitMirroring, UnitRotation,
  UnitNegative;

{$R *.dfm}

procedure TFormUtama.bbukaClick(Sender: TObject);
var
  fc: string;
begin
  if (OpenPictureDialog.Execute) then
  begin
    if (FormCitra = nil) then
    Application.CreateForm(TFormCitra, FormCitra);
    FormCitra.Image.Picture.LoadFromFile(OpenPictureDialog.FileName);
    FormCitra.ClientHeight:=FormCitra.Image.Picture.Height;
    FormCitra.ClientWidth:=FormCitra.Image.Picture.Width;
    FormCitra.ClientHeight:=FormCitra.Image.Picture.Height;
    FormCitra.Show;

    if (FormHasil = nil) then
    Application.CreateForm(TFormHasil, FormHasil);
    FormHasil.Top := FormCitra.Top;
    FormHasil.Left := FormCitra.Left+FormCitra.Width;
    FormHasil.Image.Picture.LoadFromFile(OpenPictureDialog.FileName);
    FormHasil.ClientHeight:=FormHasil.Image.Picture.Height;
    FormHasil.ClientWidth:=FormHasil.Image.Picture.Width;
    FormHasil.ClientHeight:=FormHasil.Image.Picture.Height;
    FormHasil.Show;

    case (FormCitra.Image.Picture.Bitmap.PixelFormat) of
    pf1bit : fc := 'biner';
    pf8bit : fc := 'keabuan';
    pf24bit : fc := 'true color';
    end;
    StatusBar.SimpleText:=OpenPictureDialog.FileName+' ('+
    IntToStr(FormCitra.Image.Picture.Width)+'x'+
    IntToStr(FormCitra.Image.Picture.Height)+', '+fc+')';

    if (cekhistogram.Checked) then
      TampilHistogram;
  end;
end;


procedure TFormUtama.combomenuChange(Sender: TObject);
begin
  case combomenu.ItemIndex of
      0:  begin
            Application.CreateForm(TFormThresholding, FormThresholding);
          end;
      1:  begin
            Application.CreateForm(TFormThresholdingDouble, FormThresholdingDouble);
          end;
      2:  begin
            Application.CreateForm(TFormNoise, FormNoise);
          end;
      3:  begin
            Application.CreateForm(TFormEdgeDetection, FormEdgeDetection);
          end;
      4:  begin
            Application.CreateForm(TFormEqualization, FormEqualization);
          end;
      5:  begin
            Application.CreateForm(TFormEmboss, FormEmboss);
          end;
      6:  begin
            Application.CreateForm(TFormBrightness, FormBrightness);
          end;
      7:  begin
            Application.CreateForm(TFormContrast, FormContrast);
          end;
      8:  begin
            Application.CreateForm(TFormConvolution, FormConvolution);
          end;
      9: begin
            Application.CreateForm(TFormNegative, FormNegative);
          end;
      10: begin
            Application.CreateForm(TFormSharpening, FormSharpening);
          end;
      11: begin
            Application.CreateForm(TFormMirroring, FormMirroring);
          end;
      12: begin
            Application.CreateForm(TFormRotation, FormRotation);
          end;
      13: begin
            Application.CreateForm(TFormSmoothing, FormSmoothing);
          end;
    end;
end;

procedure TFormUtama.bsalinClick(Sender: TObject);
begin
FormCitra.Image.Picture.Bitmap:=FormHasil.Image.Picture.Bitmap;
FormCitra.Image.Repaint;
end;

procedure TFormUtama.cekhistogramClick(Sender: TObject);
begin
  if (cekhistogram.Checked) then
  begin
   TampilHistogram;
  end
  else
  begin
    FormHistAwal.Free;
    FormHistHasil.Free;
  end;
end;

procedure TFormUtama.TampilHistogram;
begin
  if (FormHistAwal = nil) then
  Application.CreateForm (TFormHistAwal, FormHistAwal);
   FormHistAwal.Top := FormCitra.Top+FormCitra.Height;
   FormHistAwal.Left := FormCitra.Left;
   FormHistAwal.Picture := FormCitra.Image.Picture;
   FormHistAwal.MenghitungHistogram(0);
   FormHistAwal.Repaint;

   if (FormHistHasil = nil) then
  Application.CreateForm (TFormHistHasil, FormHistHasil);
   FormHistHasil.Top := FormHasil.Top+FormHasil.Height;
   FormHistHasil.Left := FormHasil.Left;
   FormHistHasil.Picture := FormHasil.Image.Picture;
   FormHistHasil.MenghitungHistogram(0);
   FormHistHasil.Repaint;

end;

procedure TFormUtama.bsimpanClick(Sender: TObject);
begin
  if SavePictureDialog1.Execute then
  begin
    if SavePictureDialog1.FilterIndex = 1 then
      begin
        FormHasil.Image.Picture.SaveToFile(SavePictureDialog1.FileName + '.bmp');
      end
  end;
end;

end.
