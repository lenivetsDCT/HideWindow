object Form1: TForm1
  Left = 294
  Top = 92
  Caption = 'Form1'
  ClientHeight = 41
  ClientWidth = 258
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 208
    Top = 8
    Width = 42
    Height = 25
    Caption = 'Hide'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ComboBox1: TComboBox
    Left = 39
    Top = 8
    Width = 161
    Height = 21
    TabOrder = 1
    Text = 'ComboBox1'
  end
  object Button2: TButton
    Left = 0
    Top = 8
    Width = 33
    Height = 25
    Caption = 'Get'
    TabOrder = 2
    OnClick = Button2Click
  end
end
