param($N = 10)

Start-FarTask -Data N {
	Add-Type -Path $env:FARHOME\FarNet\Lib\FarNet.ScottPlot\FarNet.ScottPlot.dll

	$N = $Data.N
	$values = [double[]]::new($N)
	$labels = [string[]]::new($N)

	$plot = [FarNet.ScottPlot.FormPlot]::new("$N lagest panel files")
	$set1 = $plot.AddBar($values, $null)
	$plot.XTicks($labels)
	$plot.XAxis.TickLabelStyle($null, $null, $null, $null, 60)
	$plot.YLabel('Length')

	while(!$plot.IsCancellationRequested) {
		$files = job {
			$Far.Panel.ShownFiles | Sort-Object Length -Descending
		}
		for($i = $N; --$i -ge 0) {
			if ($i -lt $files.Count) {
				$_ = $files[$i]
				$values[$i] = $_.Length
				$labels[$i] = $_.Name.Substring(0, [Math]::Min($_.Name.Length, 25))
			}
			else {
				$values[$i] = 0
				$labels[$i] = ''
			}
		}

		$plot.SetAxisLimitsY(0, ($values | Measure-Object -Maximum).Maximum * 1.05)
		$plot.Show(3000)
	}
}
