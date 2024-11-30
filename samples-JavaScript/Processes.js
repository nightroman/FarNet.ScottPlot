import { toArray } from './Abc.js'

const lib = host.lib(
    clr.System.Environment.ExpandEnvironmentVariables('%FARHOME%/FarNet/Lib/FarNet.ScottPlot/FarNet.ScottPlot.dll'),
    clr.System.Environment.ExpandEnvironmentVariables('%FARHOME%/FarNet/Lib/FarNet.ScottPlot/ScottPlot.dll'))

const N = 20
let processes = Array.from(clr.System.Diagnostics.Process.GetProcesses())
    .sort((a, b) => a.WorkingSet64 < b.WorkingSet64 ? 1 : -1)
    .slice(0, N)

let values = toArray(System.Double, processes.map(x => x.WorkingSet64 / 1048576))
let labels = toArray(System.String, processes.map(x => x.ProcessName.substring(0, Math.min(25, x.ProcessName.length))))

let plot = new lib.ScottPlot.FarPlot('Processes')
plot.YLabel('WorkingSet64')
let style = new lib.ScottPlot.LabelStyle()
style.Rotation = -60
style.Alignment = lib.ScottPlot.Alignment.MiddleRight
plot.Axes.Bottom.TickLabelStyle = style
plot.Axes.Bottom.MinimumSize = 150

let set1 = plot.Add.Bars(values)
plot.Axes.Bottom.SetTicks(lib.ScottPlot.Generate.Consecutive(N), labels)

plot.Show()
