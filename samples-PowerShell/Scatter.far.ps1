[CmdletBinding()]
param(
	[switch]$Wait
)

$ErrorActionPreference = 'Stop'
Add-Type -Path $env:FARHOME\FarNet\Lib\FarNet.ScottPlot\FarNet.ScottPlot.dll

[double[]] $dataX = 1, 2, 3, 4, 5
[double[]] $dataY = 1, 4, 9, 16, 25

$plot = [FarNet.ScottPlot.FormPlot]::new('Scatter')
$set1 = $plot.AddScatter($dataX, $dataY)
$plot.Show()

if ($Wait) {
	$null = $plot.CancellationToken.WaitHandle.WaitOne()
}
