@echo off

:NoUpdate
:: Start Server
START "" /high "%StartDir%\%arma3exe%.exe" -server -ip=45.121.211.229 -port=2302 "-config=%StartDir%\config\config_AltisLife.cfg" "-cfg=%StartDir%\config\basic_AltisLife.cfg" "-profiles=%StartDir%\OzzyLife" -name=OzzyLife "-serverMod=@extDB2_lifeLive;@life_server_altis" "-bepath=%StartDir%\battleye_AltisLife" -nosplash -nopause -maxMem=2047 -loadMissionFileToMemory -autoinit
::START "" /high "%StartDir%\%arma3exe%.exe" -server -ip=45.121.211.229 -port=2302 "-config=%StartDir%\config\config_AltisLife.cfg" "-cfg=%StartDir%\config\basic_AltisLife.cfg" "-profiles=%StartDir%\OzzyLife" -name=OzzyLife "-serverMod=@extDB2_lifeLive;@life_server_altis" "-bepath=%StartDir%\battleye_AltisLife" -nosplash -nopause -cpuCount=8 -maxMem=4096 -exThreads=1 -loadMissionFileToMemory -autoinit
timeout 5