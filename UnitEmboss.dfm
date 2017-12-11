object FormEmboss: TFormEmboss
  Left = 561
  Top = 373
  BorderStyle = bsSingle
  Caption = 'Emboss'
  ClientHeight = 181
  ClientWidth = 232
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
    Left = 88
    Top = 8
    Width = 68
    Height = 23
    Caption = 'Emboss'
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
    Width = 217
    Height = 97
    Caption = 'Input Nilai:'
    TabOrder = 0
    object Label2: TLabel
      Left = 120
      Top = 32
      Width = 26
      Height = 13
      Caption = 'Beta:'
    end
    object RadioButtonEmbossKiri: TRadioButton
      Left = 8
      Top = 32
      Width = 105
      Height = 17
      Caption = 'Kiri'
      Checked = True
      TabOrder = 0
      TabStop = True
    end
    object RadioButtonEmbossKananAtas: TRadioButton
      Left = 8
      Top = 56
      Width = 105
      Height = 17
      Caption = 'Kanan Atas'
      TabOrder = 1
    end
    object EditEmboss: TEdit
      Left = 120
      Top = 48
      Width = 81
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
