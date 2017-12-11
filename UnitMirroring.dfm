object FormMirroring: TFormMirroring
  Left = 563
  Top = 373
  BorderStyle = bsSingle
  Caption = 'Mirroring'
  ClientHeight = 181
  ClientWidth = 229
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
    Width = 86
    Height = 23
    Caption = 'Mirroring'
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
    Height = 105
    Caption = 'Pilihan Pencerminan:'
    TabOrder = 0
  end
  object RadioButtonMirroringHorizontal: TRadioButton
    Left = 32
    Top = 72
    Width = 113
    Height = 17
    Caption = 'Horizontal'
    Checked = True
    TabOrder = 1
    TabStop = True
  end
  object RadioButtonMirroringVertikal: TRadioButton
    Left = 32
    Top = 96
    Width = 113
    Height = 17
    Caption = 'Vertikal'
    TabOrder = 2
  end
  object RadioButtonMirroringKombinasi: TRadioButton
    Left = 32
    Top = 120
    Width = 153
    Height = 17
    Caption = 'Horizontal dan Vertikal'
    TabOrder = 3
  end
  object bproses: TButton
    Left = 72
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Proses'
    TabOrder = 4
    OnClick = bprosesClick
  end
end
