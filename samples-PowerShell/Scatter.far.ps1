[CmdletBinding()]
param(
	[switch]$Wait
)

$ErrorActionPreference = 1
Add-Type -Path $env:FARHOME\FarNet\Lib\FarNet.ScottPlot\FarNet.ScottPlot.dll

[double[]]$xs = 1, 2, 3, 4, 5
[double[]]$ys = 1, 4, 9, 16, 25

$plot = [ScottPlot.FarPlot]::new('Scatter')
$set1 = $plot.Add.Scatter($xs, $ys)
$plot.Show($Wait ? -1 : 0)
