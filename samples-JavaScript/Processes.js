import { toArray } from './Abc.js'

const lib = host.lib(
    clr.System.Environment.ExpandEnvironmentVariables('%FARHOME%/FarNet/Lib/FarNet.ScottPlot/FarNet.ScottPlot.dll'),
    'System.Diagnostics.Process'
)

const N = 20
let processes = Array.from(lib.System.Diagnostics.Process.GetProcesses())
    .sort((a, b) => a.WorkingSet64 < b.WorkingSet64 ? 1 : -1)
    .slice(0, N)

let values = toArray(System.Double, processes.map(x => x.WorkingSet64 / 1048576))
let labels = toArray(System.String, processes.map(x => x.ProcessName.substring(0, Math.min(25, x.ProcessName.length))))

let plot = new lib.FarNet.ScottPlot.FormPlot('Processes')
let set1 = plot.AddBar(values)
plot.XTicks(labels)
plot.XAxis.TickLabelStyle(null, null, null, null, 60)
plot.YLabel('WorkingSet64')
plot.Show()
