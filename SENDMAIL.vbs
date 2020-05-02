'On Error Resume Next
  Dim outobj, mailobj    
  Dim strFileText 
  Dim objFileToRead    
  Dim cn, expl, path, log, filename	 
  Dim Fsv
  
  Set Fsv = WScript.CreateObject("Scripting.FileSystemObject")
 
  Set outobj = CreateObject("Outlook.Application")    
  Set mailobj = outobj.CreateItem(0)  
  set expl = CreateObject("ADODB.Connection")
  expl.connectionstring = "Provider=OraOLEDB.Oracle;Data Source=EXPK;User ID=EXPK;Password=EXPK"
  expl.open
  

  Set cn = CreateObject("ADODB.Connection")
  Set rs = CreateObject("ADODB.Recordset")
  cn.connectionstring = "Driver={MySQL ODBC 8.0 ANSI Driver}; Data Source=MSAOII;"
  cn.open
  
  send_to = "SELECT email FROM SYS_MAIL WHERE ml_id = " & "20" & " and action = 'to'; "
  send_cc = "SELECT email FROM SYS_MAIL WHERE ml_id = " & Type_send & " and action = 'cc'; "
  send_bcc = "SELECT email FROM SYS_MAIL WHERE ml_id =  1  and action = 'bcc'; "
  send_bc_sec = "SELECT email FROM SYS_MAIL WHERE ml_id = 18;"
  send_bc_sup = "SELECT email FROM SYS_MAIL WHERE ml_id = 17;"
  send_bc_chf = "SELECT email FROM SYS_MAIL WHERE ml_id = 19;"
  
  path = "G:\vbs_demand_extend"
  filename = "SENDMAIL"
  dayA   = Day(Date)
  monthA = Left(MonthName(Month(Date)),3)
  yearA  = Year(Date)
  TodayA = dayA & "-" & monthA & "-" & YearA	
  
  
  Send_Bc =  myEmail(send_bcc)
  Send_To =  myEmail(send_to)
  'Send_Bc =  Send_Bc & ";" & myEmail(send_bc_sec)
  'Send_Bc =  Send_Bc & ";" & myEmail(send_bc_sup)
  'Send_Bc =  Send_Bc & ";" & myEmail(send_bc_chf)
  'call Write_File(Send_Bc, path & "\log\" & "bcc.txt")
  'Wscript.Quit
  date_name = Year(Date) & Month(Date) & Day(Date)	
  
  
  'MsgBox date_name
  
  'Wscript.Quit
  
  strFileText  =  "<html>" &_
			  	  "<body style=""font-family:Calibri Light;"">" &_
			  	  "<p><b>[ Automatic Email Report ]</b></p>"   &_
				  "<br></br>" &_
			  	  "<p>The Daily Provision List report is attached file. If you have any question, please contact PC System Team.</p>" &_
			  	  "<b>__________________________________________________________________________________________________________________</b>" &_
			  	  "<p><b>Best Regards,<br>Production Control System (PCS)</b></p>" &_
			  	  "</body>" &_
			  	  "</html>" 
                
  '				 "<p><a href=""http://192.168.82.58/tbkk_system_center"">Click the link for other info that need</a></p>" &_
 
  
  strAttachFile0  = path & "\bin\Provision_List_Report_" & date_name &".xlsx"
  'strAttachFile1  = path & "\bin\Monthly_Defect_Report_" & Left(MonthName(Month(DateAdd("m", -1, Date))),3)& Right(Year(DateAdd("m", -1, Date)),2) & ".xlsx"
  '
  'MsgBox CInt (hol_sv("HOLIDAY_FLG"))
  '"talerngsak@tbkk.co.th"	 .CC     = Send_Bc	 .BCC    = Send_Bc

  
  
  With mailobj    
    .To     =  Send_To  '"wanwisa_p@tbkk.co.th; aksarapak@tbkk.co.th; pitak@tbkk.co.th; nuttapong_p@tbkk.co.th; samart@tbkk.co.th; pimprapa_k@tbkk.co.th; jirawat_p@tbkk.co.th; siripong_n@tbkk.co.th; jannarong@tbkk.co.th; pattanasak@tbkk.co.th; orawan@tbkk.co.th" 'Send_Bc'"rachit@tbkk.co.th"'Send_Bc' thmanagers@tbkk.co.th ;
	.BCC 	=  Send_Bc
    .Subject = TodayA & " : Daily Provision List report"    
    .HtmlBody strFileText    
	.Attachments.Add strAttachFile0
    .Send
  End With  

 Fsv.MoveFile strAttachFile0 , path & "\bin\bk\Provision_List_Report_"  & date_name & Hour(Time) & Minute(Time) & Second(Time) & ".xlsx"
 
 
 'Fso.MoveFile path & "\bin\bk\Provision_List_Report_" & date_name & ".xlsx" , path & "\bin\bk\Provision_List_Report_" & date_name & Hour(Time) & Minute(Time) & Second(Time) & ".xlsx"

 Err.Clear 

	Myfile = path & "\log\" & "Log.log"
	If Err.Number <> 0 Then
				
			Set fso = CreateObject("Scripting.FileSystemObject")
			Set file = fso.OpenTextFile(Myfile, 1)
				conten = file.ReadAll
				file.Close	
			log = Now & " [ " & WeekdayName(DatePart("w", Date())) &" ]" & "[ " & Err.Description & " ] " & "[ " & filename & " ] "
			'MsgBox log
			call Write_File(conten & log, Myfile)
			Myfile = path & "\temp\" & filename & "_Error.log"
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
  'MsgBox strAttachFile
  'Clear the memory
  Set outobj = Nothing    
  Set mailobj = Nothing  
  
 '======================================== Function ================================================= 
 
	Sub Write_File(myStr, myFname)
		Set objFSO=CreateObject("Scripting.FileSystemObject")
			outFile = myFname
		Set	objFile = objFSO.CreateTextFile(outFile,True)
			objFile.WriteLine myStr
			objFile.Close
	End Sub  
	
	Function myEmail(sql)
		Set sql_sv = cn.Execute(sql)
			Send=""
			   Do Until sql_sv.eof
					For Each fld In sql_sv.Fields
						Send = Send  &  sql_sv(fld.Name).value & "; "
					Next				
				sql_sv.MoveNext
			   LOOP
		myEmail = Mid(Send,1,Len(Send)-2)  
	End Function
	
	
	Sub Write_File(myStr, myFname)
	Set objFSO = CreateObject("Scripting.FileSystemObject")
        outFile = myFname
	Set	objFile = objFSO.CreateTextFile(outFile,True)
		objFile.WriteLine myStr
		objFile.Close
	End Sub	