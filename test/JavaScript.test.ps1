
. ./About.ps1

task Scatter {
	Start-Far @TestParam "js: @ ..\samples-JavaScript\Scatter.js"
}

task Processes {
	Start-Far @TestParam "js: @ ..\samples-JavaScript\Processes.js"
}

task ProcessesLive {
	Start-Far @TestParam "js: @ ..\samples-JavaScript\ProcessesLive.js"
}
