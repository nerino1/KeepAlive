$signature = @'
[DllImport("user32.dll")]
public static extern bool ShowWindowAsync(IntPtr hWnd, int nCmdShow);
[DllImport("kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
[DllImport("user32.dll")]
public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);
'@

Add-Type -MemberDefinition $signature -Name "WinAPI" -Namespace "Interop"

$consoleHandle = [Interop.WinAPI]::GetConsoleWindow()
[void][Interop.WinAPI]::ShowWindowAsync($consoleHandle, 2) # 2 represents SW_SHOWMINIMIZED

$width = 40
$height = 15
$left = 0
$top = 0
$null = [Interop.WinAPI]::SetWindowPos($consoleHandle, [IntPtr]::Zero, $left, $top, $width, $height, 0x0004) # 0x0004 represents SWP_SHOWWINDOW

$ErrorActionPreference = "SilentlyContinue" # Suppress any error messages

Echo "-=Keep Alive=-"
Echo " "

$WShell = New-Object -ComObject "Wscript.shell"
while ($true) {
    $WShell.SendKeys("{SCROLLLOCK}")
    Start-Sleep -Milliseconds 200
    Echo "Keep Alive... 1"
    $WShell.SendKeys("{SCROLLLOCK}")
    Start-Sleep -Seconds 350
    Echo "Keep Alive... 2"
}
