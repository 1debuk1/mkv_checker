# mkv_scan.ps1
$MKVFile = "D:\temporary\[MM] Bad Newz (2024) Hindi HDRip .mkv"
$ExtractDir = "D:\MKVToolNix\ExtractedFiles"

# Create directory
if (!(Test-Path $ExtractDir)) {
    New-Item -ItemType Directory -Path $ExtractDir
}

Write-Output "Running mkvinfo..."
& "D:\MKVToolNix\mkvinfo.exe" $MKVFile

Write-Output "Extracting subtitles (may fail if track ID is wrong)..."
& "D:\MKVToolNix\mkvextract.exe" tracks "$MKVFile" 2:"$ExtractDir\subtitles.srt"

Write-Output "Scanning extracted files with Windows Defender..."
Start-Process -Wait -NoNewWindow -FilePath "C:\Program Files\Windows Defender\MpCmdRun.exe" -ArgumentList "-Scan", "-ScanType 3", "-File $ExtractDir"

Write-Output "Scan complete. Check extracted files at $ExtractDir"
