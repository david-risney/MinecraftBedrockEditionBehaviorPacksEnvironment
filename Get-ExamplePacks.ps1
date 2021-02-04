$rootPath = Split-Path $SCRIPT:MyInvocation.MyCommand.Path -Parent;
$examplePath = Join-Path $rootPath "examples";

# Using the .NET zip APIs in PowerShell
# https://stackoverflow.com/questions/27768303/how-to-unzip-a-file-in-powershell
Add-Type -AssemblyName System.IO.Compression.FileSystem;
function Unzip {
    param([string]$zipfile, [string]$outpath);
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipfile, $outpath);
}

function UnzipUriToFolder {
    param([string] $uri, [string] $folderName);

    $zipPath = Join-Path $examplePath "$folderName.zip";
    $extractedPath = Join-Path $examplePath $folderName;

    Write-Host "Downloading $folderName zip...";
    # Invoke-WebRequest is slow because of the progress bar.
    # https://stackoverflow.com/questions/28682642/powershell-why-is-using-invoke-webrequest-much-slower-than-a-browser-download
    $ProgressPreference = 'SilentlyContinue'
    Invoke-WebRequest -Uri $uri -OutFile $zipPath;
    $ProgressPreference = 'Continue'

    Write-Host "Extracting $folderName zip... (this may take a few minutes)";
    Unzip $zipPath $extractedPath;

    Write-Host "Removing $folderName zip...";
    Remove-Item $zipPath;
}

Write-Host "Removing old examples folder...";
Remove-Item $examplePath -Force -Recurse -ErrorAction Ignore;
[void](MkDir $examplePath);

UnzipUriToFolder "https://aka.ms/behaviorpacktemplate" "vanilla_behavior_pack";
UnzipUriToFolder "https://aka.ms/resourcepacktemplate" "vanilla_resource_pack";
UnzipUriToFolder "https://www.minecraft.net/content/dam/minecraft/addons/alien-invasion.mcworld" "alien_invasion";
UnzipUriToFolder "https://www.minecraft.net/content/dam/minecraft/addons/castle-siege.mcworld" "castle_siege";
UnzipUriToFolder "https://meedownloads.blob.core.windows.net/worlds/Mob%20Arena%20Demo.zip" "mob_arena_demo";
UnzipUriToFolder "https://meedownloads.blob.core.windows.net/worlds/Turn-Based%20Game%20Demo.zip" "turn_based_game_demo";

Write-Host "Done";