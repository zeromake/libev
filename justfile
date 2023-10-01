set windows-powershell := true


BUILD_COMMAND := 'xmake b -vD'
MODE := 'release'
CUP := if os() == 'windows' {'busybox '} else {''}

config:
	xmake f -m {{MODE}} -c -y -k static

ev:
	xmake b ev
