[NuGet]: https://www.nuget.org/packages/FarNet.ScottPlot
[GitHub]: https://github.com/nightroman/FarNet.ScottPlot
[ScottPlot]: https://github.com/ScottPlot/ScottPlot

# FarNet.ScottPlot

FarNet friendly [ScottPlot] extension for .NET modules and scripts in PowerShell, F#, JavaScript.

## Package

The package is designed for [FarNet](https://github.com/nightroman/FarNet/wiki).
To install FarNet and FarNet.ScottPlot, follow [these steps](https://github.com/nightroman/FarNet#readme).

The NuGet package [FarNet.ScottPlot](https://www.nuget.org/packages/FarNet.ScottPlot)
is installed to `%FARHOME%\FarNet\Lib\FarNet.ScottPlot`.

## Samples

- [FSharp](samples-FSharp)
- [JavaScript](samples-JavaScript)
- [PowerShell](samples-PowerShell)

## How to use

Use `FarNet.ScottPlot.FormPlot` which inherits the original `ScottPlot.Plot`.
Setup the plot using the original members and call `Show()` to show the form.

For live plots, update and show in a loop until the plot is cancelled.
Check for `IsCancellationRequested` or use the `CancellationToken`.
Use `ShowAsync(int)` or `Show(int)` for intervals between updates.

Note that `Show()` shows the form and immediately returns. This is the desired
behaviour for scripts in Far Manager or interactive `pwsh` and `fsx` consoles.
Use `Show(-1)` in order to block the current thread and avoid immediate console
exits on running scripts by non-interactive `pwsh` or `fsx`, see samples.

## See also

- [Release Notes](https://github.com/nightroman/FarNet.ScottPlot/blob/main/Release-Notes.md)
