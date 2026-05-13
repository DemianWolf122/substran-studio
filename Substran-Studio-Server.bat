@echo off
REM Substran Studio - mini servidor local para que Chrome/Edge permitan
REM "Install as app". Sirve el HTML en http://localhost:8765 y abre el
REM browser ahi. Cerrar esta ventana = parar el servidor.

cd /d "%~dp0"

REM Powershell HTTP listener (no necesita Python ni nada externo)
start "" powershell -NoExit -ExecutionPolicy Bypass -Command ^
  "$listener = New-Object System.Net.HttpListener;" ^
  "$listener.Prefixes.Add('http://localhost:8765/');" ^
  "$listener.Start();" ^
  "Write-Host 'Substran Studio sirviendo en http://localhost:8765/Substran-Studio.html' -ForegroundColor Green;" ^
  "Write-Host 'Dejá esta ventana abierta. Cerrala = parar el server.' -ForegroundColor Yellow;" ^
  "$dir = Get-Location;" ^
  "while ($listener.IsListening) {" ^
  "  $ctx = $listener.GetContext();" ^
  "  $path = $ctx.Request.Url.AbsolutePath.TrimStart('/');" ^
  "  if ([string]::IsNullOrEmpty($path)) { $path = 'Substran-Studio.html' }" ^
  "  $file = Join-Path $dir $path;" ^
  "  if (Test-Path $file) {" ^
  "    $bytes = [IO.File]::ReadAllBytes($file);" ^
  "    $ext = [IO.Path]::GetExtension($file).ToLower();" ^
  "    switch ($ext) {" ^
  "      '.html' { $ctx.Response.ContentType = 'text/html; charset=utf-8' }" ^
  "      '.js'   { $ctx.Response.ContentType = 'application/javascript' }" ^
  "      '.css'  { $ctx.Response.ContentType = 'text/css' }" ^
  "      '.ico'  { $ctx.Response.ContentType = 'image/x-icon' }" ^
  "      '.svg'  { $ctx.Response.ContentType = 'image/svg+xml' }" ^
  "      default { $ctx.Response.ContentType = 'application/octet-stream' }" ^
  "    }" ^
  "    $ctx.Response.ContentLength64 = $bytes.Length;" ^
  "    $ctx.Response.OutputStream.Write($bytes, 0, $bytes.Length);" ^
  "  } else { $ctx.Response.StatusCode = 404 }" ^
  "  $ctx.Response.Close();" ^
  "}"

REM Esperar 2 segundos a que el server arranque, despues abrir browser
timeout /t 2 /nobreak >nul
start "" "msedge.exe" "http://localhost:8765/Substran-Studio.html"

exit
