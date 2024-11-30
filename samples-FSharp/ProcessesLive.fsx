open System.Diagnostics
open ScottPlot

let N = 20
let plot = new FarPlot()
plot.YLabel("WorkingSet64")
plot.Axes.Bottom.MinimumSize <- 150f
plot.Axes.Bottom.TickLabelStyle <- LabelStyle(Rotation = -60f, Alignment = Alignment.MiddleRight)

plot.FormInterval <- 3000
plot.FormUpdate <- fun () ->
    let values, labels =
        Process.GetProcesses()
        |> Array.sortByDescending (fun x -> x.WorkingSet64)
        |> Array.take N
        |> Array.map (fun x -> float (x.WorkingSet64 / 1048576L), x.ProcessName.Substring(0, min 25 x.ProcessName.Length))
        |> Array.unzip

    plot.FormTitle <- $"Processes {System.DateTime.Now}"
    plot.Clear()
    let set1 = plot.Add.Bars(values)
    plot.Axes.Bottom.SetTicks(Generate.Consecutive(N), labels)

plot.Show()
