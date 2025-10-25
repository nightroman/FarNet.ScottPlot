@{
	Author = 'Roman Kuzmin'
	ModuleVersion = '0.0.0'
	Description = 'ScottPlot plots in PowerShell.'
	CompanyName = 'https://github.com/nightroman'
	Copyright = 'Copyright (c) Roman Kuzmin'

	RootModule = 'FarNet.ScottPlot.psm1'
	RequiredAssemblies = 'FarNet.ScottPlot.dll', 'ScottPlot.dll'

	PowerShellVersion = '7.4'
	GUID = '0cf20a0e-814a-4068-b770-9cd682ee49c9'

	AliasesToExport = @()
	CmdletsToExport = @()
	VariablesToExport = @()
	FunctionsToExport = @(
		'Show-FarPlotHistogram'
		'Show-FarPlotScatter'
		'Show-FarPlotSignal'
	)

	PrivateData = @{
		PSData = @{
			Tags = @('ScottPlot', 'plot', 'histogram', 'scatter', 'signal')
			ProjectUri = 'https://github.com/nightroman/FarNet.ScottPlot'
			LicenseUri = 'https://github.com/nightroman/FarNet.ScottPlot/blob/main/LICENSE'
			ReleaseNotes = 'https://github.com/nightroman/FarNet.ScottPlot/blob/main/Release-Notes.md'
		}
	}
}
