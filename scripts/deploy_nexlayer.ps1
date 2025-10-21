param(
  [string]$TokenEnvName = "NEXLAYER_TOKEN"
)

if (-not (Get-Item env:$TokenEnvName -ErrorAction SilentlyContinue)) {
  Write-Error "$TokenEnvName environment variable not found. Set it and retry."
  exit 1
}

$token = (Get-Item env:$TokenEnvName).Value

Write-Output "Packaging site..."
if (Test-Path site.zip) { Remove-Item site.zip }
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::CreateFromDirectory((Get-Location).Path, "site.zip")

Write-Output "Uploading to Nexlayer..."
$uri = 'https://api.nexlayer.io/v1/deploy'

$boundary = [System.Guid]::NewGuid().ToString()
$LF = "`r`n"

$bodyLines = @()
$bodyLines += "--$boundary"
$bodyLines += "Content-Disposition: form-data; name=`"file`"; filename=`"site.zip`""
$bodyLines += "Content-Type: application/zip" + $LF
$bodyLines += [System.IO.File]::ReadAllBytes("site.zip")
$bodyLines += "--$boundary`r`nContent-Disposition: form-data; name=`"name`"`r`n`r`n" + "nexlayer2-static-site"
$bodyLines += "--$boundary--"

[byte[]]$bodyBytes = [System.Text.Encoding]::ASCII.GetBytes(($bodyLines -join $LF))

$wc = New-Object System.Net.WebClient
$wc.Headers.Add("Authorization", "Bearer $token")
$wc.Headers.Add("Content-Type", "multipart/form-data; boundary=$boundary")

try {
  $response = $wc.UploadData($uri, $bodyBytes)
  $text = [System.Text.Encoding]::UTF8.GetString($response)
  Write-Output $text
} catch {
  Write-Error "Upload failed: $_"
  exit 2
}

Write-Output "Deployment finished."
