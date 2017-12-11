object FormSharpening: TFormSharpening
  Left = 561
  Top = 372
  BorderStyle = bsSingle
  Caption = 'Sharpening'
  ClientHeight = 187
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
    Left = 64
    Top = 8
    Width = 104
    Height = 23
    Caption = 'Sharpening'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Book Antiqua'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 32
    Width = 209
    Height = 97
    Caption = 'Input Nilai:'
    TabOrder = 0
    object Label2: TLabel
      Left = 112
      Top = 32
      Width = 31
      Height = 13
      Caption = 'Alpha:'
    end
    object RadioButtonSharpening5: TRadioButton
      Left = 24
      Top = 32
      Width = 73
      Height = 17
      Caption = '5 Titik'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object RadioButtonSharpening9: TRadioButton
      Left = 24
      Top = 56
      Width = 73
      Height = 17
      Caption = '9 Titik'
      TabOrder = 1
    end
    object EditSharpening: TEdit
      Left = 112
      Top = 48
      Width = 65
      Height = 21
      TabOrder = 2
      Text = '1'
    end
  end
  object bproses: TButton
    Left = 80
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Proses'
    TabOrder = 1
    OnClick = bprosesClick
  end
end
