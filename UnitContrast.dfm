object FormContrast: TFormContrast
  Left = 560
  Top = 217
  BorderStyle = bsSingle
  Caption = 'Contrast'
  ClientHeight = 118
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
    Left = 80
    Top = 8
    Width = 74
    Height = 23
    Caption = 'Contrast'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Book Antiqua'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 40
    Width = 13
    Height = 13
    Caption = 'P :'
  end
  object Label3: TLabel
    Left = 136
    Top = 40
    Width = 14
    Height = 13
    Caption = 'G :'
  end
  object SpinEditContrast: TSpinEdit
    Left = 40
    Top = 40
    Width = 65
    Height = 22
    MaxValue = 255
    MinValue = 0
    TabOrder = 0
    Value = 128
    OnChange = SpinEditContrastChange
  end
  object EditContrast: TEdit
    Left = 152
    Top = 40
    Width = 57
    Height = 21
    TabOrder = 1
    Text = '2'
  end
  object bproses: TButton
    Left = 88
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Proses'
    TabOrder = 2
    OnClick = bprosesClick
  end
end
