
. ./About.ps1

task Scatter {
	Start-Far @TestParam "ps: ..\samples-PowerShell\Scatter.far.ps1"
}

task Processes {
	Start-Far @TestParam "ps: ..\samples-PowerShell\Processes.far.ps1"
}

task ProcessesLive {
	Start-Far @TestParam "ps: ..\samples-PowerShell\ProcessesLive.far.ps1"
}

task PanelFilesLive {
	Start-Far @TestParam "ps: ..\samples-PowerShell\PanelFilesLive.far.ps1"
}

task Histogram {
	Start-Far @TestParam "ps: ..\samples-PowerShell\Histogram.far.ps1"
}
