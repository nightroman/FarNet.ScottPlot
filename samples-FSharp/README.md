# FSharp samples

Recommended order:

- [Scatter.fsx](Scatter.fsx)
- [Processes.fsx](Processes.fsx)
- [ProcessesLive.fsx](ProcessesLive.fsx)
- [PanelFilesLive.fsx](PanelFilesLive.fsx)

## Run in Far Manager

In Far Manager with `FarNet.FSharpFar` and `FarNet.ScottPlot`, run scripts as:

```
fs: //exec file=Scatter.fsx
```

## Run in fsx

With `fsx.exe` (comes with `FarNet.FSharpFar`), run scripts as:

```
fsx Scatter.fsx
```

In `fsx` interactive sessions, run scripts as:

```
> #load "Scatter.fsx";;
```

> `samples.fs.ini` uses the environment variable `FARHOME`.
So either run `fsx` from Far Manager or ensure `FARHOME`.
