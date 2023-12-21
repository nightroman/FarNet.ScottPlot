# PowerShell samples

Recommended order:

- [Scatter.far.ps1](Scatter.far.ps1)
- [Processes.far.ps1](Processes.far.ps1)
- [ProcessesLive.far.ps1](ProcessesLive.far.ps1)
- [PanelFilesLive.far.ps1](PanelFilesLive.far.ps1)
- [Histogram.far.ps1](Histogram.far.ps1)

## Run in Far Manager

In Far Manager with `FarNet.PowerShellFar` and `FarNet.ScottPlot` installed, run scripts as:

```
ps: .\Scatter.far.ps1
```

## Run by pwsh

With `pwsh` installed and `FarNet.ScottPlot` available locally, adjust this script line:

```
Add-Type -Path $env:FARHOME\FarNet\Lib\FarNet.ScottPlot\FarNet.ScottPlot.dll
```

or ensure the environment variable `FARHOME` and path, and run scripts by pwsh as:

```
pwsh Scatter.far.ps1 -Wait
```

or leaving the console open:

```
pwsh -NoExit Scatter.far.ps1
```

or in pwsh interactively:

```
PS> .\Scatter.far.ps1
```
