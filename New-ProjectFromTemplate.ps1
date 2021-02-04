param(
    [Parameter(Mandatory=$true)] $ProjectName,
    [Parameter(Mandatory=$true)] $ProjectDescription);

$templateValues = @{
    "{ProjectName}" = $ProjectName;
    "{ProjectDescription}" = $ProjectDescription;
    "{ProjectBehaviorPackGuid}" = (new-guid).guid;
    "{ProjectBehaviorPackModuleGuid}" = (new-guid).guid;
    "{ProjectResourcePackGuid}" = (new-guid).guid;
    "{ProjectResourcePackModuleGuid}" = (new-guid).guid;
};

function FillTemplateValues {
    param($FilePath);
    $replacedContent = (Get-Content $FilePath | %{
        $line = $_;
        @($templateValues.GetEnumerator()) | %{
            $templateValue = $_;
            $line = $line.Replace($templateValue.Name, $templateValue.Value);
        }
        $line;
    });
    Set-Content -Path $FilePath $replacedContent;
}

$ProjectPath = (MkDir $ProjectName).FullName;
Copy -Rec new-project-template\* $ProjectPath
Pushd $ProjectPath;
FillTemplateValues behavior-pack\manifest.json
FillTemplateValues resource-pack\manifest.json
Popd;
