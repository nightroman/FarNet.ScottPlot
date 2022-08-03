# JavaScript samples

Recommended order:

- [Scatter.js](Scatter.js)
- [Processes.js](Processes.js)
- [ProcessesLive.js](ProcessesLive.js)
- [ProcessesLiveTask.js](ProcessesLiveTask.js)

## Run in Far Manager

In Far Manager with `FarNet.JavaScriptFar` and `FarNet.ScottPlot` installed, run scripts as:

```
js: @ Scatter.js
js: @ Processes.js
```

The live plot `ProcessesLive.js` may be run by the similar command but it blocks Far Manager:

```
js: @ ProcessesLive.js
```

To avoid blocking, run it as task:

```
js: @task: ProcessesLive.js
```

Or use the async version of the script:

```
js: @ ProcessesLiveTask.js
```
