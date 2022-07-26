$ErrorActionPreference = 'Stop'
Add-Type -Path $env:FARHOME\FarNet\Lib\FarNet.ScottPlot\FarNet.ScottPlot.dll

$processes = @(Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First 20)

$positions = 0 .. ($processes.Count - 1)
$values = $processes.foreach{ $_.WorkingSet64 / 1mb }
$labels = $processes.foreach{ $_.Name.Substring(0, [Math]::Min($_.Name.Length, 20)) }

$plot = [FarNet.ScottPlot.FormPlot]::new()
$bar = $plot.AddBar($values, $positions, $null)
$bar.ErrorLineWidth = 0
$plot.XTicks($positions, $labels)
$plot.XAxis.TickLabelStyle($null, $null, $null, $null, 45)
$plot.YLabel('WorkingSet64')

$plot.FormTitle = 'Processes'
$plot.Show()
