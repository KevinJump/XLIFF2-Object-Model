param ($version, $suffix='', $env='release', [switch]$push=$false)

$fullVersion = $version
if (![String]::IsNullOrWhiteSpace($suffix)) {
 $fullVersion = -join($version, '-', $suffix)
}
$outFolder = ".\dist\$fullVersion"

dotnet pack .\Xliff.OM\Xliff.OM.csproj -c $env -o $outFolder /p:ContinuousIntegrationBuild=true,version=$fullVersion 

if ($push) {
    .\nuget.exe push "$outFolder\*.nupkg" -ApiKey AzureDevOps -src https://pkgs.dev.azure.com/jumoo/Public/_packaging/nightly/nuget/v3/index.json
}