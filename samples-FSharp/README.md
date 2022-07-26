# FSharp samples

Recommended order:

- [Scatter.fsx](Scatter.fsx)
- [Processes.fsx](Processes.fsx)
- [ProcessesLive.fsx](ProcessesLive.fsx)
- [PanelFilesLive.fsx](PanelFilesLive.fsx)

## Run in Far Manager

In Far Manager with `FarNet.FSharpFar` and `FarNet.ScottPlot` installed, run scripts as:

```
fs: //exec file=Scatter.fsx
```

## Run in fsx

With `fsx.exe`, the part of `FarNet.FSharpFar`, run scripts as:

```
fsx Scatter.fsx
```

In `fsx` interactive sessions, run scripts as:

```
> #load "Scatter.fsx";;
```

> `fsx.exe` is a console app on its own, it runs outside Far Manager. But the
configuration `samples.fs.ini` uses the environment variable `FARHOME`. So
either run `fsx` from Far Manager or set `FARHOME` before running `fsx`.
