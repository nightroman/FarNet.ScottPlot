
. ./About.ps1

task Scatter {
	Start-Far @Testing "js: @ ..\samples-JavaScript\Scatter.js"
}

task Processes {
	Start-Far @Testing "js: @ ..\samples-JavaScript\Processes.js"
}

task ProcessesLive {
	Start-Far @Testing "js: @ ..\samples-JavaScript\ProcessesLive.js"
}
