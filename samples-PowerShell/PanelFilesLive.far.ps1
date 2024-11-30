param($N = 10)

Start-FarTask -Data N {
	$N = $Data.N
	Add-Type -Path $env:FARHOME\FarNet\Lib\FarNet.ScottPlot\FarNet.ScottPlot.dll

	$plot = [ScottPlot.FarPlot]::new("$N lagest panel files")
	$style = [ScottPlot.LabelStyle]::new()
	$style.Rotation = -60
	$style.Alignment = 'MiddleRight'
	$plot.Axes.Bottom.TickLabelStyle = $style
	$plot.Axes.Bottom.MinimumSize = 150
	$plot.YLabel('Length')

	while(!$plot.IsCancellationRequested) {
		$files = job {
			$Far.Panel.Files | Sort-Object Length -Descending | Select-Object -First $Data.N
		}
		$values = [double[]]::new($N)
		$labels = [string[]]::new($N)
		$$ = -1
		foreach($_ in $files) {
			++$$
			$values[$$] = $_.Length
			$labels[$$] = $_.Name.Substring(0, [Math]::Min($_.Name.Length, 25))
		}

		$plot.Clear()
		$set1 = $plot.Add.Bars($values)
		$plot.Axes.Bottom.SetTicks((0 .. ($N - 1)), $labels)
		$plot.Axes.SetLimitsY(0, ($values | Measure-Object -Maximum).Maximum * 1.05)

		$plot.Show(3000)
	}
}
