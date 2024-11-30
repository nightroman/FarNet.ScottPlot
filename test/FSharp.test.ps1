
. ./About.ps1

task Scatter {
	Start-Far @TestParam "fs: exec: file=..\samples-FSharp\Scatter.fsx"
}

task Processes {
	Start-Far @TestParam "fs: exec: file=..\samples-FSharp\Processes.fsx"
}

task ProcessesLive {
	Start-Far @TestParam "fs: exec: file=..\samples-FSharp\ProcessesLive.fsx"
}

task PanelFilesLive {
	Start-Far @TestParam "fs: exec: file=..\samples-FSharp\PanelFilesLive.fsx"
}
