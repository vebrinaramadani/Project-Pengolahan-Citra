object FormConvolution: TFormConvolution
  Left = 561
  Top = 374
  BorderStyle = bsSingle
  Caption = 'Convolution'
  ClientHeight = 88
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
  object Label1: TLabel
    Left = 64
    Top = 8
    Width = 112
    Height = 23
    Caption = 'Convolution'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Book Antiqua'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object bproses: TButton
    Left = 80
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Proses'
    TabOrder = 0
    OnClick = bprosesClick
  end
end
