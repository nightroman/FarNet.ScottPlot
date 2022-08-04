async function show() {
    const lib = host.lib(clr.System.Environment.ExpandEnvironmentVariables('%FARHOME%/FarNet/Lib/FarNet.ScottPlot/FarNet.ScottPlot.dll'))

    const N = 20
    let values = host.newArr(System.Double, N)
    let labels = host.newArr(System.String, N)

    let plot = new lib.FarNet.ScottPlot.FormPlot('Processes')
    let set1 = plot.AddBar(values)
    plot.XTicks(labels)
    plot.XAxis.TickLabelStyle(null, null, null, null, 60)
    plot.YLabel('WorkingSet64')

    while (!plot.IsCancellationRequested) {
        Array.from(clr.System.Diagnostics.Process.GetProcesses())
            .sort((a, b) => a.WorkingSet64 < b.WorkingSet64 ? 1 : -1)
            .slice(0, N)
            .forEach((x, i) => {
                values[i] = x.WorkingSet64 / 1048576
                labels[i] = x.ProcessName.substring(0, Math.min(25, x.ProcessName.length))
            })
        await plot.ShowAsync(3000).ToPromise()
    }
}

show()
