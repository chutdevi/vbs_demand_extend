'On Error Resume Next

dim ej, cn, path, log, filename, namelog, arrSvl
Dim Chr_str(2)
Dim StdOut : Set StdOut = CreateObject("Scripting.FileSystemObject").GetStandardStream(2) 
    path = "G:\vbs_demand_extend"
	filename = "demand_convert"
	namelog = "Clog_" & Year(date) & WhatEver(Month(date)) & WhatEver(Day(date))
	table = "TEMP_DEMAND_CONVERT"
	data_file =   "demand_convert"
	insert_file = "demand_convert_ins"
	
set ej = CreateObject("ADODB.Connection")
set cn = CreateObject("ADODB.Connection")
ej.connectionstring = "Driver={MySQL ODBC 8.0 Driver}; Data Source=DBEJ; User=monty; Password=some_pass;"
ej.open

cn.connectionstring = "Provider=OraOLEDB.Oracle;Data Source=EXPK;User ID=EXPK;Password=EXPK"
cn.open
Set fso = CreateObject("Scripting.FileSystemObject")

	ej.Execute("TRUNCATE " & table)

	If Not fso.FileExists( path & "\log\Log.log" ) Then	
		Set objFSO=CreateObject("Scripting.FileSystemObject")					
			outFile= path & "\log\Log.log"
		Set objFile= fso.CreateTextFile(outFile,True)
			objFile.WriteLine "[ LOG FOR TASK AUTOMATIC DEMAND REPORT ]"
			objFile.Close
	END IF

   Dim x, n
   n = 0 
		'if n = 0 then
	 	  Stdout.Write " INPUT DATA" & Chr(32)
		  
		  WScript.Sleep 200
		  
		  Stdout.Write Chr(254)
		  n = 1  
		'end if
	 
		Set file = fso.OpenTextFile( path & "\work\" & data_file & ".sql", 1)
		content = file.ReadAll	 	 

		Set sql_sv = ej.Execute(content)

		If sql_sv.eof = False Then 
			arrSvl = sql_sv.GetRows
			count_sql = uBound(arrSvl,2)

			sql_sv.MoveFirst	
			Set file = fso.OpenTextFile( path & "\work\" & insert_file & ".sql", 1 )
			content = file.ReadAll

			count_pro = count_sql
			GH = CInt(count_pro) + 1	
			Step_p = 1
			Ind = 0	
			Digit = 49 \ GH		
			If  GH >= 49  Then
				Step_p = Cint(GH \ 49)	
				Digit = 1
				Chr_str(0) =  CInt( Digit )
				Chr_str(1) =  0		
			Else
				Chr_str(0) =  CInt( Digit )
				if 49 MOD GH = 0 Then
					Chr_str(1) =  0
				Else
					Chr_str(1) =  49 - ( ( GH * CInt( Chr_str(0) ) ) MOD 49 )	
				End If			
			End If				
			
			itt = 0
			
			For intC = 0 To uBound(arrSvl,2)		
				itt = itt + 1						
				IF (itt MOD Step_p) = 0 AND Ind < 49 Then
					Ind = Ind + 1	
					Stdout.Write String(Chr_str(0),Chr(254))
				END if
					 options = content
					 For intF = 0 To uBound(arrSvl,1)
						options = options & Put_Sq( arrSvl( intF , intC) ) & ","
					 Next									
						
				
					options = Mid(options,1,Len(options)-1)
					options = options & "," & "SYSDATE()" & " );"
					call Write_File(options, path & "\log\" & namelog & ".sql")	
				ej.Execute(options)
			'sql_sv.MoveNext
			 Next			
				Stdout.Write String(Chr_str(1),Chr(254))
				PROGRESS = 100
				Stdout.Write Chr(32) & "Convert" & " Complete " & Chr(33) & Chr(32) & "Record data " & FormatNumber(itt,0) &  String( 6 - Len( FormatNumber(itt,0) ) ," ") & " record " & vbLf 
				n = 0
			
	Else
		WScript.Sleep 500
		Stdout.WriteLine " No Data '_' "		
	End IF  
		Stdout.WriteLine " END   TASK" & Chr(32) & 	Date() & " " & FormatDateTime(Now(),vbLongTime)	
	   
	cn.close
	ej.close
    Set cn = Nothing
	set ej = Nothing
	Myfile = path & "\log\" & "Log.log"
	If Err.Number <> 0 Then
			Set fso = CreateObject("Scripting.FileSystemObject")
			Set file = fso.OpenTextFile(Myfile, 1)
				conten = file.ReadAll
				file.Close	
			log = Now & " [ " & WeekdayName(DatePart("w", Date())) &" ]" & "[ " & Err.Description & " ] " & "[ " & filename & " ] "
			'MsgBox log
			call Write_File(conten & log, Myfile)
			Myfile = path & "\temp\" & filename & "_error.log"
			call Write_File(conten & log, Myfile)
			Wscript.Quit
	Else
			Set fso = CreateObject("Scripting.FileSystemObject")
			Set file = fso.OpenTextFile(Myfile, 1)
				conten = file.ReadAll
				file.Close	
			log = Now & " [ " & WeekdayName(DatePart("w", Date())) &" ]" & "[ " & " Complete! " & " ] " & "[ " & filename & " ] "
			'MsgBox log
			call Write_File(conten & log, Myfile)
			Wscript.Quit
	End If



'======================================== Function =================================================

Function myDateFormat(myDate,opr)
    d = WhatEver(Day(myDate))
    m = WhatEver(Month(myDate))    
    y = Year(myDate)
    myDateFormat= y & opr & m & opr & d
End Function

Function myTimeFormat(myTime,opr)
    h = WhatEver(Hour(myTime))
    m = WhatEver(Minute(myTime))    
    s = WhatEver(Second(myTime))
    myTimeFormat= h & opr & m & opr & s
End Function

Function WhatEver(num)
    If(Len(num)=1) Then
        WhatEver="0"&num
    Else
        WhatEver=num
    End If
End Function

Function Put_Sq(mydata)	
	Put_Sq = "'" & mydata & "'"
End Function

Sub Echo(myStr)
		MsgBox myStr
		Wscript.Quit
End Sub

Function Read_File(myStr, myFname )
		Set file = fso.OpenTextFile( myStr & myFname, 1)
		Read_File = file.ReadAll 		
End Function

Sub Write_File(myStr, myFname)
	Set objFSO = CreateObject("Scripting.FileSystemObject")
        outFile = myFname
	Set	objFile = objFSO.CreateTextFile(outFile,True)
		objFile.WriteLine myStr
		objFile.Close
End Sub