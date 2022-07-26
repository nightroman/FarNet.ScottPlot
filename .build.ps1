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
$ModuleHome = "$FarHome\FarNet\Lib\$ModuleName"
$Description = 'FarNet friendly ScottPlot extension for PowerShell, F#, JavaScript.'

task build meta, {
	Set-Location src
	exec { dotnet build -c $Configuration }
}

task publish {
	Set-Location src
	exec { dotnet publish -c $Configuration -o $ModuleHome --no-build }

	Remove-Item "$ModuleHome\$ModuleName.deps.json"
	Copy-Item "$ModuleName.ini" $ModuleHome

	$xml = [xml](Get-Content "$ModuleName.csproj")
	$node = $xml.SelectSingleNode('Project/ItemGroup/PackageReference[@Include="ScottPlot"]')
	Copy-Item "$HOME\.nuget\packages\ScottPlot\$($node.Version)\lib\net5.0\ScottPlot.xml" $ModuleHome
}

task clean {
	remove src\bin, src\obj, README.htm, *.nupkg, z
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
		'--self-contained', "--css=$env:MarkdownCss"
		'--standalone', "--metadata=pagetitle=$ModuleName $Version"
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

	exec { robocopy $ModuleHome $toModule /s /xf *.pdb } (0..2)
	equals 6 (Get-ChildItem $toModule -Recurse -File).Count

	Copy-Item -Destination $toModule @(
		"README.htm"
		"LICENSE"
	)
}

task nuget package, version, {
	($dllVersion = (Get-Item "$ModuleHome\$ModuleName.dll").VersionInfo.FileVersion.ToString())
	equals $dllVersion $Version

	$text = @"
$Description

---

To install FarNet packages, follow these steps:

https://github.com/nightroman/FarNet#readme

---
"@

	Set-Content z\Package.nuspec @"
<?xml version="1.0"?>
<package xmlns="http://schemas.microsoft.com/packaging/2010/07/nuspec.xsd">
	<metadata>
		<id>$ModuleName</id>
		<version>$Version</version>
		<authors>Roman Kuzmin</authors>
		<owners>Roman Kuzmin</owners>
		<projectUrl>https://github.com/nightroman/$ModuleName</projectUrl>
		<license type="expression">MIT</license>
		<summary>$text</summary>
		<description>$text</description>
		<releaseNotes>https://github.com/nightroman/$ModuleName/blob/master/Release-Notes.md</releaseNotes>
		<tags>FarManager FarNet Chart Plot</tags>
	</metadata>
</package>
"@

	exec { NuGet.exe pack z\Package.nuspec }
}

task . build, clean
