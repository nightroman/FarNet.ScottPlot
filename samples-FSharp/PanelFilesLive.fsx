open FarNet
open ScottPlot

task {
    let N = 10

    let plot = new FarPlot $"{N} lagest panel files"
    plot.YLabel("Length")
    plot.Axes.Bottom.MinimumSize <- 150f
    plot.Axes.Bottom.TickLabelStyle <- LabelStyle(Rotation = -60f, Alignment = Alignment.MiddleRight)

    while not plot.IsCancellationRequested do
        let! files = job {
            return far.Panel.GetFiles() |> Array.sortByDescending (fun x -> x.Length) |> Array.truncate N
        }
        let values = Array.zeroCreate N
        let labels = Array.zeroCreate N
        for i in 0 .. files.Length - 1 do
            let file = files[i]
            values[i] <- float file.Length
            labels[i] <- file.Name.Substring(0, min file.Name.Length 25)

        plot.Clear()
        let set1 = plot.Add.Bars(values)
        plot.Axes.Bottom.SetTicks(Generate.Consecutive(N), labels)
        plot.Axes.SetLimitsY(0, (values |> Array.max) * 1.05)

        do! plot.ShowAsync(3000)
}
