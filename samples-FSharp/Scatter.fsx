open ScottPlot

let xs = [| 1.; 2.; 3.; 4.; 5. |]
let ys = [| 1.; 4.; 9.; 16.; 25. |]

let plot = new FarPlot "Scatter"
let set1 = plot.Add.Scatter(xs, ys)
plot.Show(if fsi.CommandLineArgs[0].EndsWith(".fsx") then -1 else 0)
