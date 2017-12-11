unit UnitEdgeDetection;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFormEdgeDetection = class(TForm)
    Label1: TLabel;
    ComboBoxEdgeDetection: TComboBox;
    CheckBoxEdgeDetection: TCheckBox;
    GroupBox1: TGroupBox;
    bproses: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure bprosesClick(Sender: TObject);
    procedure EdgeDetection;
    procedure ComboBoxEdgeDetectionChange(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

  Mask3x3 = array [-1..1,-1..1] of real;

var
  FormEdgeDetection: TFormEdgeDetection;
  MaskEdgeDetection: Mask3x3;

const
  MaskEdgeDetectionRobert1: Mask3x3 =
    (( 0, 0, 0),
     ( 0, 1, 0),
     ( 0, 0,-1));
  MaskEdgeDetectionRobert2: Mask3x3 =
    (( 0, 0, 0),
     ( 0, 0, 1),
     ( 0,-1, 0));
  MaskEdgeDetectionPrewittHorizontal: Mask3x3 =
    ((-1, 0, 1),
     (-1, 0, 1),
     (-1, 0, 1));
  MaskEdgeDetectionPrewittVertikal: Mask3x3 =
    ((-1,-1,-1),
     ( 0, 0, 0),
     ( 1, 1, 1));
  MaskEdgeDetectionSobelHorizontal: Mask3x3 =
    ((-1, 0, 1),
     (-2, 0, 2),
     (-1, 0, 1));
  MaskEdgeDetectionSobelVertikal: Mask3x3 =
    ((-1,-2,-1),
     ( 0, 0, 0),
     ( 1, 2, 1));
  MaskEdgeDetectionIsotropikHorizontal: Mask3x3 =
    ((-1, 0, 1),
     (-1.41421, 0, 1.41421),
     (-1, 0, 1));
  MaskEdgeDetectionIsotropikVertikal: Mask3x3 =
    ((-1,-1.41421,-1),
     ( 0, 0, 0),
     ( 1, 1.41421, 1));
  MaskEdgeDetectionLaplacian5: Mask3x3 =
    (( 0,-1, 0),
     (-1, 4,-1),
     ( 0,-1, 0));
  MaskEdgeDetectionLaplacian91: Mask3x3 =
    ((-1,-1,-1),
     (-1, 8,-1),
     (-1,-1,-1));
  MaskEdgeDetectionLaplacian92: Mask3x3 =
    (( 1,-2, 1),
     (-2, 4,-2),
     ( 1,-2, 1));


implementation

uses UnitCitra, UnitHasil, UnitUtama;

{$R *.dfm}

procedure TFormEdgeDetection.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
Free;
end;

procedure TFormEdgeDetection.EdgeDetection;
var
  x, y, w, h, u, v: integer;
  PC, PH: PByteArray;
  Ki, Ri, Gi, Bi, Ko, Ro, Go, Bo: array of array of byte;
  jumlah: real;
begin
  if (ComboBoxEdgeDetection.Text = 'Robert') then
    begin
      MaskEdgeDetection := MaskEdgeDetectionRobert1;
      MaskEdgeDetection := MaskEdgeDetectionRobert2;
    end;
  if (ComboBoxEdgeDetection.Text = 'Prewitt') then
    begin
      MaskEdgeDetection := MaskEdgeDetectionPrewittHorizontal;
      MaskEdgeDetection := MaskEdgeDetectionPrewittVertikal;
    end;
  if (ComboBoxEdgeDetection.Text = 'Sobel') then
    begin
      MaskEdgeDetection := MaskEdgeDetectionSobelHorizontal;
      MaskEdgeDetection := MaskEdgeDetectionSobelVertikal;
    end;
  if (ComboBoxEdgeDetection.Text = 'Isotropik') then
    begin
      MaskEdgeDetection := MaskEdgeDetectionIsotropikHorizontal;
      MaskEdgeDetection := MaskEdgeDetectionIsotropikVertikal;
    end;
  if (ComboBoxEdgeDetection.Text = 'Laplacian 5 titik') then
    begin
      MaskEdgeDetection := MaskEdgeDetectionLaplacian5
    end;
  if (ComboBoxEdgeDetection.Text = 'Laplacian 9 titik 1') then
    begin
      MaskEdgeDetection := MaskEdgeDetectionLaplacian91
    end;
  if (ComboBoxEdgeDetection.Text = 'Laplacian 9 titik 2') then
    begin
      MaskEdgeDetection := MaskEdgeDetectionLaplacian92;
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
                jumlah := jumlah+MaskEdgeDetection[u,v]*Ki[x-u,y-v];
            if (Abs(jumlah)<255) then
              Ko[x,y] := Round(Abs(jumlah))
            else
              Ko[x,y] := 255;
            if (CheckBoxEdgeDetection.Checked) then
              Ko[x,y] := 255-Ko[x,y];
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
                jumlah := jumlah+MaskEdgeDetection[u,v]*Ri[x-u,y-v];
            if (Abs(jumlah)<255) then
              Ro[x,y] := Round(Abs(jumlah))
            else
              Ro[x,y] := 255;
            if (CheckBoxEdgeDetection.Checked) then
              Ro[x,y] := 255-Ro[x,y];
            jumlah := 0;
            for u := -1 to 1 do
              for v := -1 to 1 do
                jumlah := jumlah+MaskEdgeDetection[u,v]*Gi[x-u,y-v];
            if (Abs(jumlah)<255) then
              Go[x,y] := Round(Abs(jumlah))
            else
              Go[x,y] := 255;
            if (CheckBoxEdgeDetection.Checked) then
              Go[x,y] := 255-Go[x,y];
            jumlah := 0;
            for u := -1 to 1 do
              for v := -1 to 1 do
                jumlah := jumlah+MaskEdgeDetection[u,v]*Bi[x-u,y-v];
            if (Abs(jumlah)<255) then
              Bo[x,y] := Round(Abs(jumlah))
            else
              Bo[x,y] := 255;
            if (CheckBoxEdgeDetection.Checked) then
              Bo[x,y] := 255-Bo[x,y];
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


procedure TFormEdgeDetection.bprosesClick(Sender: TObject);
begin
  EdgeDetection;
  FormHasil.Image.Repaint;
  if (FormUtama.cekhistogram.Checked) then
  FormUtama.TampilHistogram;
end;

procedure TFormEdgeDetection.ComboBoxEdgeDetectionChange(Sender: TObject);
begin
bprosesClick(Self);
end;

end.
