open System.Diagnostics
open ScottPlot

let N = 20
let values, labels =
    Process.GetProcesses()
    |> Array.sortByDescending (fun x -> x.WorkingSet64)
    |> Array.take N
    |> Array.map (fun x -> float (x.WorkingSet64 / 1048576L), x.ProcessName.Substring(0, min 25 x.ProcessName.Length))
    |> Array.unzip

let plot = new FarPlot "Processes"
plot.YLabel("WorkingSet64")
plot.Axes.Bottom.MinimumSize <- 150f
plot.Axes.Bottom.TickLabelStyle <- LabelStyle(Rotation = -60f, Alignment = Alignment.MiddleRight)

let set1 = plot.Add.Bars(values)
plot.Axes.Bottom.SetTicks(Generate.Consecutive(N), labels)

plot.Show()
