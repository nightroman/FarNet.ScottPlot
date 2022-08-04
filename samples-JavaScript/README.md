# JavaScript samples

Recommended order:

- [Scatter.js](Scatter.js)
- [Processes.js](Processes.js)
- [ProcessesLive1.js](ProcessesLive1.js)
- [ProcessesLive2.js](ProcessesLive2.js)
- [ProcessesLive3.js](ProcessesLive3.js)

## Run in Far Manager

In Far Manager with `FarNet.JavaScriptFar` and `FarNet.ScottPlot` installed, run scripts as:

```
js: @ Scatter.js
js: @ Processes.js
```

## Live plots, walkthrough

### ProcessesLive1.js

It is just `Processes.js` with the added loop.
It may be run by the similar command:

```
js: @ ProcessesLive1.js
```

This works, the plot is live, but it blocks Far Manager.
To avoid blocking, we may run it as task:

```
js: @task: ProcessesLive1.js
```

Far Manager is not blocked now. But we cannot run anything else in this
session while the plot is shown. E.g. the same command kind of does nothing.
But in fact it waits for the first to finish. When we close the first plot
then the second appears. This is not good.

### ProcessesLive2.js

It is the slight variation of `ProcessesLive1.js`. Instead of telling the
engine to run it as a task (`task:`) we do this right in the script. Thus,
we may use this command to run and not block Far Manager:

```
js: @ ProcessesLive2.js
```

But the problem of other scripts blocked in this session still stays.

### ProcessesLive3.js

This script implements and demonstrates the proper async scenario. This simple
command may be invoked several times and we get several live plots updating
simultaneously in the same session. Far Manager is not blocked, too:

```
js: @ ProcessesLive3.js
```
