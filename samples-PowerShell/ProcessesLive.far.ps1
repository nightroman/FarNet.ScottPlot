param($N = 20)

Start-FarTask -N $N {
	param($N)
	Import-Module "$env:FARHOME\FarNet\Lib\FarNet.ScottPlot"

	$plot = [ScottPlot.FarPlot]::new('Processes')
	$plot.YLabel('WorkingSet64')

	$style = [ScottPlot.LabelStyle]::new()
	$style.Rotation = -60
	$style.Alignment = 'MiddleRight'
	$plot.Axes.Bottom.TickLabelStyle = $style
	$plot.Axes.Bottom.MinimumSize = 150

	while(!$plot.IsCancellationRequested) {
		$processes = @(Get-Process | Sort-Object WorkingSet64 -Descending | Select-Object -First $N)

		[double[]]$values = $processes.foreach{ $_.WorkingSet64 / 1mb }
		[string[]]$labels = $processes.foreach{ $_.Name.Substring(0, [Math]::Min($_.Name.Length, 25)) }

		$plot.FormTitle = "Processes $(Get-Date)"
		$plot.Clear()
		$set1 = $plot.Add.Bars($values)
		$plot.Axes.Bottom.SetTicks((0 .. ($N - 1)), $labels)

		$plot.Show(3000)
	}
}
