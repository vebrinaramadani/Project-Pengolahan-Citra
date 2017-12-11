object FormSmoothing: TFormSmoothing
  Left = 561
  Top = 373
  Width = 193
  Height = 183
  AutoSize = True
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'Smoothing'
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
    Left = 48
    Top = 0
    Width = 98
    Height = 23
    Caption = 'Smoothing'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Book Antiqua'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object RadioGroup1: TRadioGroup
    Left = 0
    Top = 24
    Width = 177
    Height = 89
    Caption = 'Input nilai'
    TabOrder = 0
  end
  object RadioButtonSmoothing5: TRadioButton
    Left = 48
    Top = 40
    Width = 81
    Height = 17
    Caption = '5 Titik'
    TabOrder = 1
  end
  object RadioButtonSmoothing9: TRadioButton
    Left = 48
    Top = 56
    Width = 81
    Height = 17
    Caption = '9 Titik'
    TabOrder = 2
  end
  object RadioButtonSmoothing25: TRadioButton
    Left = 48
    Top = 72
    Width = 81
    Height = 17
    Caption = '25 Titik'
    TabOrder = 3
  end
  object RadioButtonSmoothing49: TRadioButton
    Left = 48
    Top = 88
    Width = 81
    Height = 17
    Caption = '49 Titik'
    TabOrder = 4
  end
  object bproses: TButton
    Left = 56
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Proses'
    TabOrder = 5
    OnClick = bprosesClick
  end
end
