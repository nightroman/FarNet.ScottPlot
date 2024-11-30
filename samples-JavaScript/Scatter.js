import { toArray } from './Abc.js'

const lib = host.lib(clr.System.Environment.ExpandEnvironmentVariables('%FARHOME%/FarNet/Lib/FarNet.ScottPlot/FarNet.ScottPlot.dll'))

let xs = toArray(System.Double, [1, 2, 3, 4, 5])
let ys = toArray(System.Double, [1, 4, 9, 16, 25])

let plot = new lib.ScottPlot.FarPlot('Scatter')
plot.Add.Scatter(xs, ys)
plot.Show()
