param($N = 20)

$ErrorActionPreference = 1
Import-Module "$env:FARHOME\FarNet\Lib\FarNet.ScottPlot"

$plot = [ScottPlot.FarPlot]::new('Process memory')
$plot.XLabel('Memory')
$plot.YLabel('Count')
$plot.Axes.Right.Label.Text = 'Probability'

[double[]] $values = (Get-Process).ForEach{$_.WorkingSet64}
$stat = $values | Measure-Object -Minimum -Maximum
$min = $stat.Minimum
$max = $stat.Maximum

$hist = [ScottPlot.Statistics.Histogram]::WithBinCount($N, $values)

$set1 = $plot.Add.Bars($hist.Bins, $hist.Counts)
foreach($_ in $set1.Bars) {$_.Size = $hist.FirstBinSize * 0.8}

$pd = [ScottPlot.Statistics.ProbabilityDensity]::new($values)
[double[]]$xs = [ScottPlot.Generate]::RangeWithCount($min, $max, $N * 2);
[double[]]$ys = $pd.GetYs($xs)

$set2 = $plot.Add.ScatterLine($xs, $ys)
$set2.Axes.YAxis = $plot.Axes.Right
$set2.LineWidth = 2
$set2.LineColor = [ScottPlot.Colors]::Black
$set2.LinePattern = [ScottPlot.LinePattern]::DenselyDashed

$plot.Show()
