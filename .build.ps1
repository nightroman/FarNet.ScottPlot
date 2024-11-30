<#
.Synopsis
	Build script, https://github.com/nightroman/Invoke-Build
#>

param(
	$Configuration = (property Configuration Release),
	$FarHome = (property FarHome C:\Bin\Far\x64)
)

Set-StrictMode -Version 3
$ModuleName = 'FarNet.ScottPlot'
$ModuleRoot = "$FarHome\FarNet\Lib\$ModuleName"
$Description = 'FarNet friendly ScottPlot extension for PowerShell, F#, JavaScript.'

task build meta, {
	Set-Location src
	exec { dotnet build -c $Configuration }
}

task publish {
	Set-Location src
	exec { dotnet publish -c $Configuration -o $ModuleRoot --no-build }

	remove "$ModuleRoot\$ModuleName.*.json"
	Copy-Item "$ModuleName.ini" $ModuleRoot

	Copy-Item $ModuleRoot\runtimes\win-x64\native\libSkiaSharp.dll $ModuleRoot

	$xml = [xml](Get-Content "$ModuleName.csproj")
	$node = $xml.SelectSingleNode('Project/ItemGroup/PackageReference[@Include="ScottPlot"]')
	Copy-Item "$HOME\.nuget\packages\ScottPlot\$($node.Version)\lib\net8.0\ScottPlot.xml" $ModuleRoot

	Set-Location "$ModuleRoot\runtimes"
	remove linux-*, osx, win-arm64
}

task clean {
	remove src\bin, src\obj, README.htm, *.nupkg, z
}

task remove_module {
	remove $ModuleRoot
}

task version {
	($script:Version = switch -Regex -File Release-Notes.md {'##\s+v(\d+\.\d+\.\d+)' {$Matches[1]; break} })
}

task markdown version, {
	assert (Test-Path $env:MarkdownCss)
	exec { pandoc.exe @(
		'README.md'
		'--output=README.htm'
		'--from=gfm'
		'--embed-resources'
		'--standalone'
		"--css=$env:MarkdownCss"
		"--metadata=pagetitle=$ModuleName $Version"
	)}
}

task meta -Inputs .build.ps1, Release-Notes.md -Outputs src\Directory.Build.props -Jobs version, {
	Set-Content src\Directory.Build.props @"
<Project>
	<PropertyGroup>
		<Company>https://github.com/nightroman/$ModuleName</Company>
		<Copyright>Copyright (c) Roman Kuzmin</Copyright>
		<Description>$Description</Description>
		<Product>$ModuleName</Product>
		<Version>$Version</Version>
		<FileVersion>$Version</FileVersion>
		<AssemblyVersion>$Version</AssemblyVersion>
	</PropertyGroup>
</Project>
"@
}

task package markdown, {
	remove z
	$toModule = mkdir "z\tools\FarHome\FarNet\Lib\$ModuleName"

	exec { robocopy $ModuleRoot $toModule /s /xf *.pdb } (0..2)

	Copy-Item -Destination z @(
		'README.md'
	)

	Copy-Item -Destination $toModule @(
		"README.htm"
		"LICENSE"
	)

	$result = Get-ChildItem $toModule -Recurse -File -Name | Out-String
	$sample = @'
FarNet.ScottPlot.dll
FarNet.ScottPlot.ini
FarNet.ScottPlot.xml
HarfBuzzSharp.dll
libSkiaSharp.dll
LICENSE
OpenTK.dll
OpenTK.GLControl.dll
README.htm
ScottPlot.dll
ScottPlot.WinForms.dll
ScottPlot.xml
SkiaSharp.dll
SkiaSharp.HarfBuzz.dll
SkiaSharp.Views.Desktop.Common.dll
SkiaSharp.Views.WindowsForms.dll
runtimes\win-x64\native\libHarfBuzzSharp.dll
runtimes\win-x64\native\libSkiaSharp.dll
runtimes\win-x86\native\libHarfBuzzSharp.dll
runtimes\win-x86\native\libSkiaSharp.dll
'@
	Assert-SameFile.ps1 -Text $sample $result $env:MERGE
}

task nuget package, version, {
	($dllVersion = (Get-Item "$ModuleRoot\$ModuleName.dll").VersionInfo.FileVersion.ToString())
	equals $dllVersion $Version

	Set-Content z\Package.nuspec @"
<?xml version="1.0"?>
<package xmlns="http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd">
	<metadata>
		<id>$ModuleName</id>
		<version>$Version</version>
		<authors>Roman Kuzmin</authors>
		<owners>Roman Kuzmin</owners>
		<license type="expression">MIT</license>
		<readme>README.md</readme>
		<projectUrl>https://github.com/nightroman/$ModuleName</projectUrl>
		<description>$Description</description>
		<releaseNotes>https://github.com/nightroman/$ModuleName/blob/main/Release-Notes.md</releaseNotes>
		<tags>FarManager FarNet Chart Plot</tags>
	</metadata>
</package>
"@

	exec { NuGet.exe pack z\Package.nuspec }
}

task test {
	Invoke-Build ** test
}

task . build, clean
