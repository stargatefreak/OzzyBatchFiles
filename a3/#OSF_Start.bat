@echo off
set StartDir=%CD%
:: Remove old fpsmalloc logs

:NoUpdate
set mods=@OzzySpecialForces\@ace;@OzzySpecialForces\@ADFUncut;@OzzySpecialForces\@Ares;@OzzySpecialForces\@ASDG_JR;@OzzySpecialForces\@CBA_A3;@OzzySpecialForces\@fhq_accessories;@OzzySpecialForces\@fhq_m4_a3;@OzzySpecialForces\@JS_JC_FA18;@OzzySpecialForces\@Taskforce_Radio\Arma 3\@task_force_radio;

set servermods=
:: Start Server
START "" /normal "%StartDir%\arma3osf.exe" -server -ip=45.121.211.229 -port=2302 "-config=%StartDir%\config\config_OSF.cfg" "-cfg=%StartDir%\config\basic_OSF.cfg" "-profiles=%StartDir%\OSF" -name=OSF "-serverMod=%servermods%" "-mod=%mods%" "-bepath=%StartDir%\battleye_OSF" -nosplash -nopause -maxMem=2047 -malloc=fpsmalloc -loadMissionFileToMemory -autoinit
timeout 5
