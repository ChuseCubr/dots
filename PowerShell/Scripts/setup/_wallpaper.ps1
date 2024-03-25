function Set-Wallpaper {
  param (
    [Parameter(ValueFromPipeline=$true)]
    [string] $WallpaperPath
  )

  Add-Type -TypeDefinition @'
using System;
using System.IO;
using System.Linq;
using System.Runtime.InteropServices;
public class Wallpaper {
    public const uint SPI_SETDESKWALLPAPER = 0x0014;
    public const uint SPIF_UPDATEINIFILE = 0x01;
    public const uint SPIF_SENDWININICHANGE = 0x02;
    private static string[] ValidExtensions = { ".bmp", ".jpg", ".png" };
    [DllImport("user32.dll", SetLastError = true, CharSet = CharSet.Auto)]
    private static extern int SystemParametersInfo(uint uiAction, uint uiParam, string lpvParam, uint fuWinIni);
    public static void SetWallpaper(string path) {
        if (!File.Exists(path)) {
          throw new Exception("File does not exist");
        }

        if (!ValidExtensions.Contains(Path.GetExtension(path))) {
          throw new Exception("Invalid file type");
        }

        SystemParametersInfo(SPI_SETDESKWALLPAPER, 0, path, SPIF_UPDATEINIFILE | SPIF_SENDWININICHANGE);
    }
}
'@

  if ($WallpaperPath -eq "") {
    $WallpaperPath = fd -t f -e jpg -e png -e bmp --search-path $HOME/Pictures/Wallpapers | fzf
    if ($WallpaperPath -ne "") {
      [Wallpaper]::SetWallpaper($WallpaperPath)
    }
  } else {
    [Wallpaper]::SetWallpaper($WallpaperPath)
  }
}
