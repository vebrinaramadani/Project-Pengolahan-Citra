object FormThresholdingDouble: TFormThresholdingDouble
  Left = 560
  Top = 375
  BorderStyle = bsSingle
  Caption = 'FormThresholdingDouble'
  ClientHeight = 188
  ClientWidth = 237
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
    Left = 24
    Top = 8
    Width = 192
    Height = 23
    Caption = 'Thresholding Double'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Book Antiqua'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 0
    Top = 64
    Width = 35
    Height = 13
    Caption = 'T. Atas'
  end
  object Label3: TLabel
    Left = 0
    Top = 104
    Width = 45
    Height = 13
    Caption = 'T. Bawah'
  end
  object Label4: TLabel
    Left = 0
    Top = 40
    Width = 52
    Height = 13
    Caption = 'Input Nilai:'
  end
  object ScrollTAtas: TScrollBar
    Left = 112
    Top = 64
    Width = 121
    Height = 17
    Max = 255
    PageSize = 0
    Position = 128
    TabOrder = 0
    OnChange = ScrollTAtasChange
  end
  object ScrollTBawah: TScrollBar
    Left = 112
    Top = 104
    Width = 121
    Height = 17
    Max = 255
    PageSize = 0
    Position = 128
    TabOrder = 1
    OnChange = ScrollTBawahChange
  end
  object EditTAtas: TEdit
    Left = 56
    Top = 64
    Width = 49
    Height = 21
    TabOrder = 2
    Text = '128'
  end
  object EditTBawah: TEdit
    Left = 56
    Top = 104
    Width = 49
    Height = 21
    TabOrder = 3
    Text = '128'
  end
  object bproses: TButton
    Left = 80
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Proses'
    TabOrder = 4
    OnClick = bprosesClick
  end
  object cekotoproses: TCheckBox
    Left = 48
    Top = 168
    Width = 153
    Height = 17
    Caption = 'Otomatis Proses Perubahan'
    TabOrder = 5
  end
end
