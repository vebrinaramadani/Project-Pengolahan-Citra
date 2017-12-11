object FormEdgeDetection: TFormEdgeDetection
  Left = 563
  Top = 373
  BorderStyle = bsSingle
  Caption = 'Edge Detection'
  ClientHeight = 153
  ClientWidth = 234
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 56
    Top = 8
    Width = 135
    Height = 23
    Caption = 'Edge Detection'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Book Antiqua'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 40
    Width = 217
    Height = 65
    Caption = 'Operator'
    TabOrder = 0
    object ComboBoxEdgeDetection: TComboBox
      Left = 8
      Top = 28
      Width = 137
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = 'Pilih Operator:'
      OnChange = ComboBoxEdgeDetectionChange
      Items.Strings = (
        'Robert'
        'Prewitt'
        'Sobel'
        'Isotropik'
        'Laplacian 5 titik'
        'Laplacian 9 titik 1'
        'Laplacian 9 titik 2')
    end
    object CheckBoxEdgeDetection: TCheckBox
      Left = 152
      Top = 32
      Width = 57
      Height = 17
      Caption = 'Negatif'
      TabOrder = 1
    end
  end
  object bproses: TButton
    Left = 80
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Proses'
    TabOrder = 1
    OnClick = bprosesClick
  end
end
