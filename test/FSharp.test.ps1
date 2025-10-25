
. ./About.ps1

task Signal {
	Start-Far @Testing "fs:exec file=..\samples-FSharp\Signal.fsx"
}

task Scatter {
	Start-Far @Testing "fs:exec file=..\samples-FSharp\Scatter.fsx"
}

task Processes {
	Start-Far @Testing "fs:exec file=..\samples-FSharp\Processes.fsx"
}

task ProcessesLive {
	Start-Far @Testing "fs:exec file=..\samples-FSharp\ProcessesLive.fsx"
}

task PanelFilesLive {
	Start-Far @Testing "fs:exec file=..\samples-FSharp\PanelFilesLive.fsx"
}
