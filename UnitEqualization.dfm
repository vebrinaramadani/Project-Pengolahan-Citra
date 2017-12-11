object FormEqualization: TFormEqualization
  Left = 302
  Top = 153
  BorderStyle = bsSingle
  Caption = 'Equalization'
  ClientHeight = 148
  ClientWidth = 178
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
    Left = 40
    Top = 0
    Width = 101
    Height = 19
    Caption = 'Equalization'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 8
    Top = 32
    Width = 51
    Height = 13
    Caption = 'Input nilai:'
  end
  object Label3: TLabel
    Left = 16
    Top = 56
    Width = 38
    Height = 13
    Caption = 'Faktor :'
  end
  object SpinEditEqualization: TSpinEdit
    Left = 56
    Top = 56
    Width = 81
    Height = 22
    MaxValue = 1000
    MinValue = 1
    TabOrder = 0
    Value = 1
    OnChange = SpinEditEqualizationChange
  end
  object bproses: TButton
    Left = 56
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Proses'
    TabOrder = 1
    OnClick = bprosesClick
  end
  object cekotoproses: TCheckBox
    Left = 16
    Top = 128
    Width = 153
    Height = 17
    Caption = 'Otomatis Proses Perubahan'
    TabOrder = 2
  end
end
