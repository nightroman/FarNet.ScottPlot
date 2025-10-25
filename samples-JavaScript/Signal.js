import { toArray } from './Abc.js'

const lib = host.lib(clr.System.Environment.ExpandEnvironmentVariables('%FARHOME%/FarNet/Lib/FarNet.ScottPlot/FarNet.ScottPlot.dll'))

lib.ScottPlot.FarShow.Signal(toArray(System.Double, [1, 4, 9, 16, 25]))
