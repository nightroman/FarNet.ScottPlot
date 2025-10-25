$ErrorActionPreference=1

function Show-FarPlotHistogram {
	[CmdletBinding()]
	param(
		[Parameter(Position=0, Mandatory=1)]
		[double[]]$Ys
		,
		[string]$Title
		,
		[switch]$UseProbability
	)

	$a = [ScottPlot.FarHistogramArgs]::new()
	$a.Title = $Title
	$a.UseProbability = $UseProbability

	[ScottPlot.FarShow]::Histogram($Ys, $a)
}

function Show-FarPlotScatter {
	[CmdletBinding()]
	param(
		[Parameter(Position=0, Mandatory=1)]
		[double[]]$Xs
		,
		[Parameter(Position=1, Mandatory=1)]
		[double[]]$Ys
		,
		[string]$Title
		,
		[string]$XLabel
		,
		[string]$YLabel
		,
		[ScottPlot.FarScatterKind]$Kind
	)

	$a = [ScottPlot.FarScatterArgs]::new()
	$a.Title = $Title
	$a.XLabel = $XLabel
	$a.YLabel = $YLabel
	$a.Kind = $Kind

	[ScottPlot.FarShow]::Scatter($Xs, $Ys, $a)
}

function Show-FarPlotSignal {
	[CmdletBinding()]
	param(
		[Parameter(Position=0, Mandatory=1)]
		[double[]]$Ys
		,
		[string]$Title
		,
		[string]$YLabel
	)

	$a = [ScottPlot.FarSignalArgs]::new()
	$a.Title = $Title
	$a.YLabel = $YLabel

	[ScottPlot.FarShow]::Signal($Ys, $a)
}
