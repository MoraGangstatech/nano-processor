@ECHO OFF

if exist .\np_project\ rd /s /q .\np_project
CALL vivado -mode batch -nojournal -nolog -notrace  -source rebuild.tcl
