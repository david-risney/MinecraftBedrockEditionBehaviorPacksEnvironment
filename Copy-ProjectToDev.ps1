param($ProjectName)

$userPath = (gi ~).FullName;
$projectBehaviorPackDevPath = "$userPath\AppData\Local\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang\development_behavior_packs\$ProjectName-behavior-pack";
$projectResourcePackDevPath = "$userPath\AppData\Local\Packages\Microsoft.MinecraftUWP_8wekyb3d8bbwe\LocalState\games\com.mojang\development_resource_packs\$ProjectName-resource-pack";

if (Test-Path $projectBehaviorPackDevPath) {
    del -rec -fo $projectBehaviorPackDevPath;
}
if (Test-Path $projectResourcePackDevPath) {
    del -rec -fo $projectResourcePackDevPath;
}
copy -fo -rec $ProjectName\behavior-pack $projectBehaviorPackDevPath;
copy -fo -rec $ProjectName\resource-pack $projectResourcePackDevPath;