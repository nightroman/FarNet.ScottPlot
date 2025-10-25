[NuGet]: https://www.nuget.org/packages/FarNet.ScottPlot
[GitHub]: https://github.com/nightroman/FarNet.ScottPlot
[ScottPlot]: https://github.com/ScottPlot/ScottPlot

# FarNet.ScottPlot

> [ScottPlot] PowerShell module and FarNet library

Packages:
- PowerShell 7.4 module, PSGallery [FarNet.ScottPlot](https://www.powershellgallery.com/packages/FarNet.ScottPlot)
- FarNet library, NuGet [FarNet.ScottPlot](https://www.nuget.org/packages/FarNet.ScottPlot)

## Samples

- [FSharp](https://github.com/nightroman/FarNet.ScottPlot/tree/main/samples-FSharp)
- [JavaScript](https://github.com/nightroman/FarNet.ScottPlot/tree/main/samples-JavaScript)
- [PowerShell](https://github.com/nightroman/FarNet.ScottPlot/tree/main/samples-PowerShell)

## PowerShell module

Install from PSGallery:

```powershell
Install-Module -Name FarNet.ScottPlot
```

Explore, see also [about_FarNet.ScottPlot.help.txt](https://github.com/nightroman/FarNet.ScottPlot/blob/main/src/Content/about_FarNet.ScottPlot.help.txt):

```powershell
# import and get module commands
Import-Module -Name FarNet.ScottPlot
Get-Command -Module FarNet.ScottPlot

# get module and commands help
help about_FarNet.ScottPlot
help Show-FarPlotHistogram
help Show-FarPlotScatter
help Show-FarPlotSignal
...
```

## FarNet library

To install as the FarNet library `FarNet.ScottPlot`, follow [these steps](https://github.com/nightroman/FarNet#readme).\
See [PowerShell FarNet modules](https://github.com/nightroman/FarNet/wiki/PowerShell-FarNet-modules) for details.

## How to use

Use the special `ScottPlot.FarPlot` which inherits and extends `ScottPlot.Plot`.
Setup the plot using the original members and call `Show()` to show the form.

For live plots, if possible, use timer with `FormInterval` and `FormUpdate`.
Alternatively, update and show in a loop until the plot is cancelled.
Check for `IsCancellationRequested` or use the `CancellationToken`.
Use `ShowAsync(int)` or `Show(int)` for intervals between updates.

Note that `Show()` shows the form and immediately returns. This is the desired
behaviour for scripts in Far Manager or interactive `pwsh` and `fsx` consoles.
Use `Show(-1)` in order to block the current thread and avoid console exits on
running scripts by non-interactive `pwsh` or `fsx`, see samples.

## See also

- [Release Notes](https://github.com/nightroman/FarNet.ScottPlot/blob/main/Release-Notes.md)
