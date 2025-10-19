# Deep Mode: Full recursive scan with caching
function Measure-DirectoryDeep {
    param(
        [string]$Path
    )
    
    $script:Statistics.ScanStartTime = Get-Date
    $script:Statistics.ScanMethod = "Deep Mode (Full Scan)"
    
    try {
        Write-Host ""
        Write-Host "  [INFO] Deep Mode: Starting full recursive scan..." -ForegroundColor Cyan
        Write-Host "  [INFO] This will scan all subdirectories and may take longer" -ForegroundColor Yellow
        Write-Host ""
        
        $directories = @{}
        $filesList = [System.Collections.Generic.List[object]]::new()
        
        $fileCount = 0
        $totalSize = 0
        $lastUpdate = Get-Date
        $startTime = Get-Date
        
        # Full recursive scan
        Get-ChildItem -Path $Path -Recurse -Force -ErrorAction SilentlyContinue | ForEach-Object {
            if (-not $_.PSIsContainer) {
                $fileCount++
                $size = $_.Length
                $totalSize += $size
                
                # Track directory sizes
                $dir = $_.DirectoryName
                if (-not $directories.ContainsKey($dir)) {
                    $directories[$dir] = 0
                }
                $directories[$dir] += $size
                
                # Store file info
                $filesList.Add([PSCustomObject]@{
                    Name      = $_.Name
                    FullPath  = $_.FullName
                    Size      = $size
                    Extension = $_.Extension
                    Directory = $dir
                })
                
                # Update progress
                if ($fileCount % 1000 -eq 0) {
                    $now = Get-Date
                    if (($now - $lastUpdate).TotalMilliseconds -gt 300) {
                        $elapsed = ($now - $startTime).TotalSeconds
                        $rate = [math]::Round($fileCount / [math]::Max(1, $elapsed))
                        $sizeMB = [math]::Round($totalSize / 1MB, 1)
                        
                        Write-Host "`r" -NoNewline
                        Write-Host "  " -NoNewline
                        Write-Host (" " * 80) -NoNewline -BackgroundColor Black
                        Write-Host "`r" -NoNewline
                        Write-Host "  Deep Scan: $fileCount files | $sizeMB MB | $rate files/sec          " -NoNewline -ForegroundColor White -BackgroundColor Red
                        
                        $lastUpdate = $now
                    }
                }
            }
        }
        
        # Final update
        Write-Host "`r" -NoNewline
        Write-Host "  " -NoNewline
        Write-Host (" " * 80) -NoNewline -BackgroundColor Black
        Write-Host "`r" -NoNewline
        Write-Host "  Deep Scan Complete: $fileCount files indexed                                   " -ForegroundColor White -BackgroundColor Red
        Write-Host ""
        Write-Host ""
        
        # Store all data in global cache
        $script:DeepScanCache = @{
            Directories = $directories
            Files       = $filesList.ToArray()
            TotalSize   = $totalSize
            RootPath    = $Path
        }
        
        $script:Statistics.TotalFilesScanned = $fileCount
        $script:Statistics.TotalDirsScanned = $directories.Count
        $script:Statistics.TotalSize = $totalSize
        $script:Statistics.ScanEndTime = Get-Date
        
        Write-Host "  [OK] Deep scan complete! All data cached for instant navigation." -ForegroundColor Green
        Write-Host ""
        
        return $true
    }
    catch {
        Write-Host "  [ERROR] Deep scan failed: $($_.Exception.Message)" -ForegroundColor Red
        return $false
    }
}

