param($N = 20)

Start-FarTask -Data N {
	Add-Type -Path $env:FARHOME\FarNet\Lib\FarNet.ScottPlot\FarNet.ScottPlot.dll

	$N = $Data.N
	$values = [double[]]::new($N)
	$labels = [string[]]::new($N)

	$plot = [FarNet.ScottPlot.FormPlot]::new('Processes')
	$set1 = $plot.AddBar($values, $null)
	$plot.XTicks($labels)
	$plot.XAxis.TickLabelStyle($null, $null, $null, $null, 60)
	$plot.YLabel('WorkingSet64')

	while(!$plot.IsCancellationRequested) {
		$processes = Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First $N
		for($i = $N; --$i -ge 0) {
			$_ = $processes[$i]
			$values[$i] = $_.WorkingSet64 / 1mb
			$labels[$i] = $_.Name.Substring(0, [Math]::Min($_.Name.Length, 25))
		}
		$plot.Show()
		Start-Sleep 3
	}
}
