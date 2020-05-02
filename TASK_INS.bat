@echo off
mode con:cols=150 lines=40
	SET PATHS=G:\vbs_demand_extend
	SET NEWLN=^& echo. 
	SET "TASK=%PATHS% RUN TASK RECEIVEIN OF %DATE% %TIME% %NEWLN% %NEWLN%
	
	ECHO  ************************* INPUT DATA ON IBM TO MYSQL BY OOR CHICKEN FOR MAINTENANCE *****************************
	
	REM cscript %PATHS%\prod_fa_query_export.vbs >nul
	
	REM cscript %PATHS%\demand_stock.vbs >nul
	REM cscript %PATHS%\demand_data.vbs       >nul
	cscript %PATHS%\demand_convert_1.vbs  >nul
	REM 
	REM ECHO  Export...
	REM cscript %PATHS%\EXPORT.vbs  >nul
	REM 
	REM ECHO  Send mail...
	REM cscript %PATHS%\SENDMAIL.vbs  >nul
	
	
	timeout /t 5 >nul	
	pause 
	
 	
REM	CLS
 