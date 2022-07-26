# PowerShell samples

## Run in Far Manager

In Far Manager with `FarNet.PowerShellFar` and `FarNet.ScottPlot` installed, run scripts as:

```
ps: .\Scatter.far.ps1
```

## Run in PowerShell

With `FarNet.ScottPlot` available somewhere locally, adjust this script line:

```
Add-Type -Path <FarNet.ScottPlot path>\FarNet.ScottPlot.dll
```

and run scripts by pwsh as:

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
