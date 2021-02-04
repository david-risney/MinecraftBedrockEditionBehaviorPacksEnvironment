param($ProjectName);

$binPath = Join-Path $ProjectName "bin";
if (!(Test-Path $binPath)) {
    [void](MkDir $binPath);
}

Compress-Archive -Path $ProjectName\resource-pack (Join-Path $binPath "resource-pack.zip");
Compress-Archive -Path $ProjectName\behavior-pack (Join-Path $binPath "behavior-pack.zip");

Move-Item (Join-Path $binPath "resource-pack.zip") (Join-Path $binPath "resource-pack.mcpack");
Move-Item (Join-Path $binPath "behavior-pack.zip") (Join-Path $binPath "behavior-pack.mcpack");

Compress-Archive -LiteralPath (Join-Path $binPath "resource-pack.mcpack"),(Join-Path $binPath "behavior-pack.mcpack") -DestinationPath (Join-Path $binPath ($ProjectName + ".zip"));

Move-Item (Join-Path $binPath ($ProjectName + ".zip")) (Join-Path $binPath ($ProjectName + ".mcaddon"));
(Join-Path $binPath ($ProjectName + ".mcaddon"));
