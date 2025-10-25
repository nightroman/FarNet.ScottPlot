$ErrorActionPreference=1
Import-Module "$env:FARHOME\FarNet\Lib\FarNet.ScottPlot"

Show-FarPlotSignal @(1, 4, 9, 16, 25)
