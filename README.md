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

## How to use

Instead of the original `ScottPlot.Plot` use the derived `FarNet.ScottPlot.FormPlot`.
It provides additional form properties and the method `Show()` which shows the form.
For example:

- `FormTitle` specifies the form title.
- `FormWait` tells to to wait for the form exit.
- `Show()` shows the form, modeless (default) or modal depending on `FormWait`.

## Sample scripts

- [FSharp](samples-FSharp)
- [JavaScript](samples-JavaScript)
- [PowerShell](samples-PowerShell)
