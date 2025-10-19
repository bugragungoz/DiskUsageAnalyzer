# Disk Usage Analyzer

**Note:** This project is currently under active development.

Ultra-fast disk space analyzer with MFT support for Windows, providing WizTree-level performance through lazy loading and optimized scanning algorithms.

## Features

- **Dual Scan Modes** - Choose between Fast Mode (lazy loading) or Deep Mode (full scan)
- **Fast Mode** - Lazy loading architecture for quick starts (5-10 seconds)
- **Deep Mode** - Full recursive scan with MFT support for instant navigation
- **Mixed View** - Shows folders and files together, sorted by size
- **Interactive Navigation** - Drill down into directories, explore file distribution
- **Visual Progress Bars** - Real-time scan progress with file count and speed metrics
- **File Analysis** - Find largest files and analyze file type distribution
- **Read-Only Operations** - Safe scanning with no file modifications
- **Export Reports** - Generate detailed analysis reports

## System Requirements

- Windows 10/11 or Windows Server 2016+
- PowerShell 5.1 or higher
- Administrator privileges (recommended for MFT access)
- NTFS file system (for MFT scanning)

## Installation

1. Download `DiskAnalyzer.ps1`
2. Right-click and select "Run with PowerShell" (as Administrator)

Or via command line:
```powershell
powershell -ExecutionPolicy Bypass -File .\DiskAnalyzer.ps1
```

## Usage

1. Launch the script as Administrator
2. Accept the legal disclaimer
3. Read the script information
4. **Select scan mode:**
   - **Fast Mode (Recommended)**: Lazy loading for quick starts
   - **Deep Mode**: Full scan with instant navigation
5. Enter the path to analyze (e.g., `C:\`, `D:\Users`)
6. Navigate through results using the interactive menu

### Scan Modes

**Fast Mode (Lazy Loading)**
- Scans only the current directory level
- Loads subdirectories on demand
- Quick start: 5-10 seconds
- Memory efficient
- Best for large drives (C:\, D:\)
- Rescans when navigating to subdirectories

**Deep Mode (Full Scan)**
- Scans entire directory tree at once
- Uses MFT support on NTFS drives
- Slower start: 30-60 seconds
- High memory usage
- Instant navigation after initial scan
- All data cached in memory

### Navigation

- **[DIR]** - Folder (can be explored by entering its number)
- **[FILE]** - File (shows size and location)
- **Option 1** - Explore subdirectory
- **Option 2** - Show top 100 largest files
- **Option 3** - Analyze file type distribution
- **Option 4** - Rescan current location
- **Option 5** - Go to parent directory
- **Option 6** - Change root path
- **Option 7** - Export analysis report
- **Option 8** - Help & information
- **Option 9** - Exit

## Performance

### Fast Mode
- **Initial Scan:** 5-10 seconds for first-level analysis
- **Subdirectory Navigation:** 2-5 seconds per directory
- **Memory Usage:** Low (only current directory)
- **Best For:** Large drives, quick analysis

### Deep Mode
- **Initial Scan:** 30-60 seconds for full directory tree
- **Subdirectory Navigation:** Instant (uses cache)
- **Memory Usage:** High (entire directory tree)
- **Best For:** Smaller drives, frequent navigation

## Technical Details

### Fast Mode (Lazy Loading)

- Scans only the current directory level
- Calculates subdirectory sizes recursively on demand
- Loads content as you navigate
- Significantly reduces initial scan time
- Memory efficient - stores only current view

### Deep Mode (Full Scan with MFT)

On NTFS drives in Deep Mode, the tool:
- Performs full recursive scan of entire directory tree
- Attempts to use C# MFT scanner via P/Invoke
- Accesses Master File Table directly using `FSCTL_ENUM_USN_DATA`
- Caches all file information in memory
- Provides instant navigation after initial scan
- Falls back to standard scanning if MFT access fails

### Architecture

The dual-mode approach solves the trade-off between speed and functionality:
- **Fast Mode**: Optimized for quick analysis and large drives
- **Deep Mode**: Optimized for thorough analysis and frequent navigation

## Legal Disclaimer

This tool is provided AS-IS without any warranties. The author accepts NO RESPONSIBILITY for any data loss, system issues, or damages arising from the use of this script.

- Use at your own risk
- Always backup important data before running disk analysis tools
- MFT scanning requires Administrator privileges
- The author disclaims all warranties, express or implied

BY USING THIS SCRIPT, YOU ACKNOWLEDGE AND ACCEPT FULL RESPONSIBILITY FOR YOUR ACTIONS.

## Author

- **Concept & Design:** Bugra
- **Development:** Claude 4.5 Sonnet AI
- **Testing:** Bugra
- **Version:** 1.0.0
- **Created:** 2025

## License

This project is provided for personal use. See script header for full legal disclaimer.

