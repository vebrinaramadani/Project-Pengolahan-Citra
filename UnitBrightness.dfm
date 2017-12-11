object FormBrightness: TFormBrightness
  Left = 560
  Top = 374
  BorderStyle = bsSingle
  Caption = 'Brightness'
  ClientHeight = 255
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
    Width = 93
    Height = 23
    Caption = 'Brightness'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlack
    Font.Height = -19
    Font.Name = 'Book Antiqua'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 40
    Width = 193
    Height = 137
    Caption = 'Input nilai :'
    TabOrder = 0
    object Label2: TLabel
      Left = 32
      Top = 24
      Width = 19
      Height = 13
      Caption = 'Red'
    end
    object Label3: TLabel
      Left = 32
      Top = 56
      Width = 29
      Height = 13
      Caption = 'Green'
    end
    object Label4: TLabel
      Left = 32
      Top = 88
      Width = 20
      Height = 13
      Caption = 'Blue'
    end
    object SpinEditBrightnessC: TSpinEdit
      Left = 88
      Top = 16
      Width = 65
      Height = 22
      MaxValue = 255
      MinValue = -255
      TabOrder = 0
      Value = 0
      OnChange = SpinEditBrightnessCChange
    end
    object SpinEditBrightnessCG: TSpinEdit
      Left = 88
      Top = 48
      Width = 65
      Height = 22
      MaxValue = 255
      MinValue = -255
      TabOrder = 1
      Value = 0
      OnChange = SpinEditBrightnessCGChange
    end
    object SpinEditBrightnessCB: TSpinEdit
      Left = 88
      Top = 80
      Width = 65
      Height = 22
      MaxValue = 255
      MinValue = -255
      TabOrder = 2
      Value = 0
      OnChange = SpinEditBrightnessCBChange
    end
    object CheckBoxBrightness: TCheckBox
      Left = 24
      Top = 112
      Width = 153
      Height = 17
      Caption = 'Ubah Secara Bersamaan'
      TabOrder = 3
    end
  end
  object bproses: TButton
    Left = 72
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Proses'
    TabOrder = 1
    OnClick = bprosesClick
  end
  object cekotoproses: TCheckBox
    Left = 32
    Top = 224
    Width = 161
    Height = 17
    Caption = 'Otomatis Proses Perubahan'
    TabOrder = 2
  end
end
