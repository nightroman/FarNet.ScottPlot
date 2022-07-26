open FarNet.ScottPlot

let dataX = [| 1.; 2.; 3.; 4.; 5. |]
let dataY = [| 1.; 4.; 9.; 16.; 25. |]

let plot = FormPlot()
plot.AddScatter(dataX, dataY) |> ignore
plot.FormTitle <- "Scatter"
plot.FormWait <- fsi.CommandLineArgs[0].EndsWith(".fsx")
plot.Show()
