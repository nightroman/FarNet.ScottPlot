
. ./About.ps1

task Signal {
	Start-Far @Testing "js: @ ..\samples-JavaScript\Signal.js"
}

task Scatter {
	Start-Far @Testing "js: @ ..\samples-JavaScript\Scatter.js"
}

task Processes {
	Start-Far @Testing "js: @ ..\samples-JavaScript\Processes.js"
}

task ProcessesLive {
	Start-Far @Testing "js: @ ..\samples-JavaScript\ProcessesLive.js"
}
