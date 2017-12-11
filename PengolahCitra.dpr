program PengolahCitra;

uses
  Forms,
  UnitUtama in 'UnitUtama.pas' {FormUtama},
  UnitCitra in 'UnitCitra.pas' {FormCitra},
  UnitHasil in 'UnitHasil.pas' {FormHasil},
  UnitThresholding in 'UnitThresholding.pas' {FormThresholding},
  UnitThresholdingDouble in 'UnitThresholdingDouble.pas' {FormThresholdingDouble},
  UnitHistAwal in 'UnitHistAwal.pas' {FormHistAwal},
  UnitHistHasil in 'UnitHistHasil.pas' {FormHistHasil},
  UnitSmoothing in 'UnitSmoothing.pas' {FormSmoothing},
  UnitConvolution in 'UnitConvolution.pas' {FormConvolution},
  UnitEqualization in 'UnitEqualization.pas' {FormEqualization},
  UnitBrightness in 'UnitBrightness.pas' {FormBrightness},
  UnitNoise in 'UnitNoise.pas' {FormNoise},
  UnitEdgeDetection in 'UnitEdgeDetection.pas' {FormEdgeDetection},
  UnitEmboss in 'UnitEmboss.pas' {FormEmboss},
  UnitContrast in 'UnitContrast.pas' {FormContrast},
  UnitSharpening in 'UnitSharpening.pas' {FormSharpening},
  UnitMirroring in 'UnitMirroring.pas' {FormMirroring},
  UnitRotation in 'UnitRotation.pas' {FormRotation},
  UnitNegative in 'UnitNegative.pas' {FormNegative};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormUtama, FormUtama);
  Application.Run;
end.
