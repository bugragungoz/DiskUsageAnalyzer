# Disk Usage Analyzer

**Note:** This project is currently under active development.

Ultra-fast disk space analyzer with MFT support for Windows, providing WizTree-level performance through lazy loading and optimized scanning algorithms.

## Features

- **Lazy Loading Architecture** - Analyzes only the current directory level, loads subdirectories on demand
- **MFT Support** - Direct Master File Table access on NTFS drives for maximum speed
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
4. Enter the path to analyze (e.g., `C:\`, `D:\Users`)
5. Navigate through results using the interactive menu

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

- **Initial Scan:** 5-10 seconds for first-level analysis
- **Subdirectory Navigation:** 2-5 seconds per directory
- **Lazy Loading:** Only scans when needed, no full disk recursion
- **Progress Tracking:** Real-time file count, size, and speed metrics

## Technical Details

### Lazy Loading Strategy

Unlike traditional disk analyzers that recursively scan entire drives, this tool:
- Scans only the current directory level
- Calculates subdirectory sizes on demand
- Loads content as you navigate
- Significantly reduces initial scan time

### MFT Scanning

On NTFS drives, the tool attempts to:
- Initialize C# MFT scanner via P/Invoke
- Access Master File Table directly using `FSCTL_ENUM_USN_DATA`
- Process millions of files in seconds
- Fallback to standard scanning if MFT access fails

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

