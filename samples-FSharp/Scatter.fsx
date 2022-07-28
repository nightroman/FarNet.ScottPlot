open FarNet.ScottPlot

let dataX = [| 1.; 2.; 3.; 4.; 5. |]
let dataY = [| 1.; 4.; 9.; 16.; 25. |]

let plot = FormPlot("Scatter")
let set1 = plot.AddScatter(dataX, dataY)
plot.Show(if fsi.CommandLineArgs[0].EndsWith(".fsx") then -1 else 0)
