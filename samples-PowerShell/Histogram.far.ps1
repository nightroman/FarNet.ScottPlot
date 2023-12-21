param($N = 50)

$ErrorActionPreference = 1

Add-Type -Path @(
	"$env:FARHOME\FarNet\Lib\FarNet.ScottPlot\FarNet.ScottPlot.dll"
	"$env:FARHOME\FarNet\Lib\FarNet.ScottPlot\ScottPlot.dll"
)

$title = 'Process memory'
[double[]] $values = (Get-Process).ForEach{$_.WS}
$stat = $values | Measure-Object -Minimum -Maximum
$min = $stat.Minimum
$max = $stat.Maximum

$hist = [ScottPlot.Statistics.Histogram]::new($min, $max, $N)
$hist.AddRange($values)

$plot = [FarNet.ScottPlot.FormPlot]::new($title)
$set1 = $plot.AddBar($hist.Counts, $hist.Bins)
$set1.BarWidth = ($max - $min) / $N
$set2 = $plot.AddFunction($hist.GetProbabilityCurve($values), 'Green', 2, 'Dash')
$set2.YAxisIndex = 1
$null = $plot.YAxis.Label('Count')
$null = $plot.YAxis2.Label('Probability')
$plot.YAxis2.Ticks($true)
$plot.SetAxisLimits($null, $null, 0.0, $null, 0, 0)
$plot.SetAxisLimits($null, $null, 0.0, 1.1, 0, 1)
$plot.Show()
