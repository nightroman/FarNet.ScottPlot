param($N = 20)

$ErrorActionPreference = 'Stop'
Add-Type -Path $env:FARHOME\FarNet\Lib\FarNet.ScottPlot\FarNet.ScottPlot.dll

$processes = @(Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First $N)

[double[]] $values = $processes.foreach{ $_.WorkingSet64 / 1mb }
[string[]] $labels = $processes.foreach{ $_.Name.Substring(0, [Math]::Min($_.Name.Length, 25)) }

$plot = [FarNet.ScottPlot.FormPlot]::new('Processes')
$set1 = $plot.AddBar($values, $null)
$plot.XTicks($labels)
$plot.XAxis.TickLabelStyle($null, $null, $null, $null, 60)
$plot.YLabel('WorkingSet64')
$plot.Show()
