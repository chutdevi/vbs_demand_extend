@echo off
mode con:cols=150 lines=40
	SET PATHS=G:\vbs_demand
	SET NEWLN=^& echo. 
	SET "TASK=%PATHS% RUN TASK RECEIVEIN OF %DATE% %TIME% %NEWLN% %NEWLN%
	
	ECHO  ************************* INPUT DATA ON IBM TO MYSQL BY DOG OOR CHICKEN FOR MAINTENANCE *****************************
	
	REM cscript %PATHS%\prod_fa_query_export.vbs >nul
	
	cscript %PATHS%\demand_stock.vbs >nul
	cscript %PATHS%\demand_data.vbs  >nul
	cscript %PATHS%\demand_convert.vbs  >nul
	
	ECHO  Export...
	cscript %PATHS%\EXPORT.vbs  >nul
	
	ECHO  Send mail...
	cscript %PATHS%\SENDMAIL.vbs  >nul
	
	
	timeout /t 5 >nul	
	REM pause 
	
 	
REM	CLS
 