@echo off
mode con:cols=150 lines=40
	SET PATHS=G:\vbs_demand
	SET NEWLN=^& echo. 
	SET "TASK=%PATHS% RUN TASK RECEIVEIN OF %DATE% %TIME% %NEWLN% %NEWLN%
	
	ECHO  ************************* INPUT DATA ON IBM TO MYSQL BY OOR CHICKEN FOR MAINTENANCE *****************************
	
	REM cscript %PATHS%\prod_fa_query_export.vbs >nul
	
	cscript %PATHS%\demand_last_month.vbs >nul
	
	
	cscript %PATHS%\demand_convert_lm.vbs >nul
	
	timeout /t 5 >nul	
REM	CLS
 pause