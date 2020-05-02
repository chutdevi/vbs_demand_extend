		SELECT
		  VC.PARENT_SEC_CD AS PD
		, DF.VEND_CD AS VEND_CD
		, MV.VEND_ANAME AS VEND_ANAME
		, DF.WS_CD AS LINE
		, VD.SEC_NM AS LINE_NAME
		, DF.ITEM_CD AS ITEM_CD
		, MI.ITEM_NAME AS ITEM_NAME
		, MP.MODEL 
		, DF.DEFECT_FACTOR_CD  AS DF_CD
		, MC.CLASS_NAME AS DF_NAME
		, ABS( SUM( DF.QTY ) ) AS QTY

, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+0,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY1
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+1,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY2
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+2,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY3
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+3,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY4
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+4,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY5
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+5,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY6
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+6,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY7
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+7,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY8
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+8,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY9
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+9,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY10
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+10,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY11
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+11,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY12
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+12,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY13
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+13,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY14
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+14,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY15
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+15,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY16
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+16,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY17
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+17,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY18
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+18,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY19
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+19,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY20
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+20,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY21
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+21,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY22
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+22,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY23
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+23,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY24
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+24,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY25
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+25,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY26
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+26,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY27
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+27,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY28
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+28,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY29
, ABS(NVL(SUM(CASE WHEN DF.RSLT_DATE = TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')+29,'YYYY/MM/DD') THEN DF.QTY END),0)) QTY_DAY30

		FROM
		  UT_DEFECT_DISPOSAL DF
		, M_CLASS MC
		, M_VEND_CTRL MV
		, M_PLANT_ITEM MP
		, VM_DEPARTMENT VD
		, VM_DEPARTMENT_CLASS VC
		, M_ITEM MI
		WHERE
			DF.WS_CD = VC.COMP_SEC_CD(+)
		AND DF.WS_CD = VD.SEC_CD(+)
		AND DF.ITEM_CD = MI.ITEM_CD(+)
		AND DF.DEFECT_FACTOR_CD = MC.CLASS_CD3(+)
		AND DF.VEND_CD = MV.VEND_CD(+)
		AND DF.PLANT_CD = MP.PLANT_CD
		AND DF.ITEM_CD = MP.ITEM_CD(+)
		AND	DF.DEL_FLG = 0
		AND MP.MODEL IS NOT NULL
 		AND DF.RSLT_DATE >= TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM'),'YYYY/MM/DD') AND DF.RSLT_DATE <= TO_CHAR(LAST_DAY(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM')),'YYYY/MM/DD')
		GROUP BY
 		  DF.VEND_CD 
		, MV.VEND_ANAME
 		, DF.WS_CD
 		, DF.ITEM_CD
		, VC.PARENT_SEC_CD 
		, MP.MODEL 
		, VD.SEC_NM 
		, MI.ITEM_NAME
		, DF.DEFECT_FACTOR_CD 
		, MC.CLASS_NAME
	ORDER BY VC.PARENT_SEC_CD, DF.WS_CD, DF.ITEM_CD ASC