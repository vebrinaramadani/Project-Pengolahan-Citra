object FormNoise: TFormNoise
  Left = 561
  Top = 372
  BorderStyle = bsSingle
  Caption = 'Noise'
  ClientHeight = 203
  ClientWidth = 233
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
    Left = 96
    Top = 8
    Width = 51
    Height = 23
    Caption = 'Noise'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Book Antiqua'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 24
    Top = 40
    Width = 193
    Height = 105
    Caption = 'Input Nilai :'
    TabOrder = 0
    object RadioButtonNoiseGaussian: TRadioButton
      Left = 8
      Top = 32
      Width = 97
      Height = 17
      Caption = 'Gaussian'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object RadioButtonNoiseSaltPepper: TRadioButton
      Left = 8
      Top = 56
      Width = 97
      Height = 17
      Caption = 'Salt and Pepper'
      TabOrder = 1
    end
    object EditNoise: TEdit
      Left = 128
      Top = 40
      Width = 57
      Height = 21
      TabOrder = 2
      Text = '0,1'
    end
  end
  object bproses: TButton
    Left = 80
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Proses'
    TabOrder = 1
    OnClick = bprosesClick
  end
end
