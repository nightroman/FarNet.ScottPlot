open FarNet
open FarNet.ScottPlot

async {
    let N = 10
    let values = Array.zeroCreate N
    let labels = Array.zeroCreate N

    let plot = FormPlot($"{N} lagest panel files")
    let set1 = plot.AddBar(values)
    plot.XTicks(labels)
    plot.XAxis.TickLabelStyle(rotation=60f)
    plot.YLabel("Length")

    while not plot.IsCancellationRequested do
        let! files = job {
            return far.Panel.GetFiles() |> Array.sortByDescending (fun x -> x.Length)
        }
        Array.fill values 0 N 0.
        Array.fill labels 0 N ""
        for i in 0 .. (min N files.Length) - 1 do
            let file = files[i]
            values[i] <- float file.Length
            labels[i] <- file.Name.Substring(0, min file.Name.Length 25)

        plot.SetAxisLimitsY(0, (values |> Array.max) * 1.05)
        do! plot.ShowAsync(3000) |> Async.AwaitTask
}
|> Jobs.Start
