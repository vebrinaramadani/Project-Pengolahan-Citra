object FormThresholding: TFormThresholding
  Left = 563
  Top = 373
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Thresholding'
  ClientHeight = 193
  ClientWidth = 230
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
  object lbl1: TLabel
    Left = 16
    Top = 40
    Width = 52
    Height = 13
    Caption = 'Input Nilai:'
  end
  object Label1: TLabel
    Left = 56
    Top = 8
    Width = 120
    Height = 23
    Caption = 'Thresholding'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Book Antiqua'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ScrollBar1: TScrollBar
    Left = 16
    Top = 64
    Width = 193
    Height = 17
    Max = 255
    PageSize = 0
    Position = 128
    TabOrder = 0
    OnChange = ScrollBar1Change
  end
  object Edit1: TEdit
    Left = 88
    Top = 96
    Width = 49
    Height = 21
    TabOrder = 1
    Text = '128'
  end
  object bproses: TButton
    Left = 72
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Proses'
    TabOrder = 2
    OnClick = bprosesClick
  end
  object cekotoproses: TCheckBox
    Left = 32
    Top = 160
    Width = 153
    Height = 17
    Caption = 'Otomatis Proses Perubahan'
    TabOrder = 3
  end
end
