object FormRotation: TFormRotation
  Left = 561
  Top = 373
  BorderStyle = bsSingle
  Caption = 'Rotation'
  ClientHeight = 172
  ClientWidth = 231
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
    Left = 80
    Top = 8
    Width = 76
    Height = 23
    Caption = 'Rotation'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Book Antiqua'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object RadioGroup1: TRadioGroup
    Left = 24
    Top = 40
    Width = 185
    Height = 81
    Caption = 'Pilihan Perputaran:'
    TabOrder = 0
  end
  object RadioButtonRotation1: TRadioButton
    Left = 40
    Top = 64
    Width = 113
    Height = 17
    Caption = '1/4 putaran'
    Checked = True
    TabOrder = 1
    TabStop = True
  end
  object RadioButtonRotation2: TRadioButton
    Left = 40
    Top = 88
    Width = 113
    Height = 17
    Caption = '1/2 putaran'
    TabOrder = 2
  end
  object bproses: TButton
    Left = 80
    Top = 136
    Width = 75
    Height = 25
    Caption = 'Proses'
    TabOrder = 3
    OnClick = bprosesClick
  end
end
