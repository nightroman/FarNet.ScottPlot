open FarNet.ScottPlot
open System.Diagnostics

let N = 20
let values, labels =
    Process.GetProcesses()
    |> Array.sortByDescending (fun x -> x.WorkingSet64)
    |> Array.take N
    |> Array.map (fun x -> float (x.WorkingSet64 / 1048576L), x.ProcessName.Substring(0, min 25 x.ProcessName.Length))
    |> Array.unzip

let plot = FormPlot "Processes"
let set1 = plot.AddBar(values)
plot.XTicks(labels)
plot.XAxis.TickLabelStyle(rotation=60f)
plot.YLabel("WorkingSet64")
plot.Show()
