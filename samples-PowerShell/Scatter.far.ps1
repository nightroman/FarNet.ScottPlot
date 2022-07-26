[CmdletBinding()]
param(
	[switch]$Wait
)

$ErrorActionPreference = 'Stop'
Add-Type -Path $env:FARHOME\FarNet\Lib\FarNet.ScottPlot\FarNet.ScottPlot.dll

$dataX = @(1, 2, 3, 4, 5)
$dataY = @(1, 4, 9, 16, 25)

$plot = [FarNet.ScottPlot.FormPlot]::new()
$null = $plot.AddScatter($dataX, $dataY)

$plot.FormTitle = 'Scatter'
$plot.FormWait = $Wait
$plot.Show()
