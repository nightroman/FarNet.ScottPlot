open FarNet.ScottPlot
open System.Diagnostics

task {
    let N = 20
    let values = Array.zeroCreate N
    let labels = Array.zeroCreate N

    let plot = FormPlot("Processes")
    let set1 = plot.AddBar(values)
    plot.XTicks(labels)
    plot.XAxis.TickLabelStyle(rotation=60f)
    plot.YLabel("WorkingSet64")

    while not plot.IsCancellationRequested do
        Process.GetProcesses()
        |> Array.sortByDescending (fun x -> x.WorkingSet64)
        |> Array.take N
        |> Array.iteri (fun i x ->
            values[i] <- float (x.WorkingSet64 / 1048576L)
            labels[i] <- x.ProcessName.Substring(0, min 25 x.ProcessName.Length)
        )
        do! plot.ShowAsync(3000)
}
