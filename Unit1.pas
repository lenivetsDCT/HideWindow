unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  PFindWindowStruct = ^TFindWindowStruct;

  TFindWindowStruct = record
    Caption: string;
    ClassName: string;
    WindowHandle: THandle;
  end;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ComboBox1: TComboBox;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure getwindows;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function EnumWindowsProc(hWindow: hWnd; lParam: LongInt): Bool; stdcall;
var
  lpBuffer: PChar;
  WindowCaptionFound: Bool;
  ClassNameFound: Bool;
begin
  GetMem(lpBuffer, 255);
  Result := True;
  WindowCaptionFound := False;
  ClassNameFound := False;
  try
    if GetWindowText(hWindow, lpBuffer, 255) > 0 then
      if Pos(PFindWindowStruct(lParam).Caption, StrPas(lpBuffer)) > 0 then
        WindowCaptionFound := True;
    if PFindWindowStruct(lParam).ClassName = '' then
      ClassNameFound := True
    else if GetClassName(hWindow, lpBuffer, 255) > 0 then
      if Pos(PFindWindowStruct(lParam).ClassName, StrPas(lpBuffer)) > 0 then
        ClassNameFound := True;
    if (WindowCaptionFound and ClassNameFound) then
    begin
      PFindWindowStruct(lParam).WindowHandle := hWindow;
      Result := False;
    end;
  finally
    FreeMem(lpBuffer, sizeof(lpBuffer^));
  end;
end;

function FindAWindow(Caption: string; ClassName: string): THandle;
var
  WindowInfo: TFindWindowStruct;
begin
  WindowInfo.Caption := Caption;
  WindowInfo.ClassName := ClassName;
  WindowInfo.WindowHandle := 0;
  EnumWindows(@EnumWindowsProc, LongInt(@WindowInfo));
  FindAWindow := WindowInfo.WindowHandle;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  TheWindowHandle: THandle;
begin
  TheWindowHandle := FindAWindow(ComboBox1.Text, '');
  if TheWindowHandle <> 0 then
    Showwindow(TheWindowHandle, SW_MINIMIZE);
end;

procedure TForm1.getwindows;
var
  wnd: hWnd;
  buff: array [0 .. 127] of char;
begin
  ComboBox1.clear;
  wnd := getwindow(handle, gw_hwndfirst);
  while wnd <> 0 do
  begin // Не показываем:
    if (wnd <> application.handle) // Собственное окно
      and iswindowvisible(wnd) // Невидимые окна
      and (getwindow(wnd, gw_owner) = 0) // Дочерние окна
      and (GetWindowText(wnd, buff, sizeof(buff)) <> 0) then
    begin
      GetWindowText(wnd, buff, sizeof(buff));
      ComboBox1.Items.Add(StrPas(buff));
    end;
    wnd := getwindow(wnd, gw_hwndnext);
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  getwindows;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
GetWindows;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
GetWindows;
end;

end.
