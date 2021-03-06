SELECT 
   1 DM_TYP
  ,TD.PLANT_CD
  ,VC.PARENT_SEC_CD
  ,TD.SOURCE_CD
  ,VD.SEC_NM SOURCE_NAME
  ,TD.ITEM_CD
  ,MI.item_name
  ,MP.MODEL
  ,MP.PKG_UNIT_QTY SNP
  ,PO.ADATE
  ,TD.ITEM_CD PARENT_ITEM_CD
  ,PO.QTY QTY
FROM 
   T_OD TD
 , M_ITEM MI
 , M_PLANT_ITEM MP
 , VM_DEPARTMENT_CLASS VC
 , VM_DEPARTMENT VD
 , (
      SELECT
        TR.ITEM_CD AS ITEM_CD
       ,SUM(TR.QTY) AS QTY
       ,TR.SHIP_PLAN_DATE ADATE
      FROM
       T_UNITE_ODR_WORK TR
      WHERE
          TO_CHAR(TR.SHIP_PLAN_DATE, 'YYYY-MM-DD') BETWEEN TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM'), 'YYYY-MM-DD') AND  TO_CHAR(LAST_DAY(ADD_MONTHS(SYSDATE,-1)), 'YYYY-MM-DD')
      AND TR.QTY > 0
      --AND TR.item_cd = '1300A033'
      GROUP BY 
        TR.ITEM_CD 
       ,TR.SHIP_PLAN_DATE
        UNION ALL
          SELECT
           TR.ITEM_CD AS ITEM_CD          
          ,SUM(TR.ODR_QTY) AS QTY
          ,TR.SHIP_PLAN_DATE AS ADATE
          FROM
           T_ODR TR
          WHERE
               TO_CHAR(TR.SHIP_PLAN_DATE, 'YYYY-MM-DD') BETWEEN TO_CHAR(TRUNC(ADD_MONTHS(SYSDATE,-1),'MM'), 'YYYY-MM-DD') AND  TO_CHAR(LAST_DAY(ADD_MONTHS(SYSDATE,-1)), 'YYYY-MM-DD')
          AND TR.DEL_FLG = 0
          AND TR.ODR_CMPLT_FLG = 1
          --AND TR.item_cd = '1300A033'
          
          GROUP BY TR.ITEM_CD, SHIP_PLAN_DATE     
    ) PO
WHERE 
    TD.SOURCE_CD = VC.COMP_SEC_CD(+)
AND TD.SOURCE_CD  = VD.SEC_CD(+)
AND TD.ITEM_CD  = MI.ITEM_CD(+)
AND TD.PLANT_CD = MP.PLANT_CD
AND TD.ITEM_CD  = MP.ITEM_CD(+)
AND TD.ITEM_CD  = PO.ITEM_CD(+)
AND VC.PARENT_SEC_CD = 'K1PD03'
AND TD.OUTSIDE_TYP = 1 AND NOT (TD.ODR_STS_TYP = 9 AND TD.TOTAL_RCV_QTY = 0)
AND TO_CHAR( TD.ACPT_PLAN_DATE,'YYYY-MM-DD' ) BETWEEN TO_CHAR( TRUNC( ADD_MONTHS(SYSDATE,-1),'MM'),'YYYY-MM-DD' ) AND TO_CHAR( LAST_DAY( ADD_MONTHS(SYSDATE,-1) ),'YYYY-MM-DD')
AND PO.ADATE IS NOT NULL
GROUP BY 
   TD.PLANT_CD
  ,VC.PARENT_SEC_CD
  ,TD.SOURCE_CD
  ,TD.ITEM_CD
  ,MI.item_name
  ,MP.MODEL
  ,PO.ADATE
  ,PO.QTY
  ,VD.SEC_NM
  ,MP.PKG_UNIT_QTY
--ORDER BY 3,4

UNION ALL

SELECT 
  1 DM_TYP
  ,TD.PLANT_CD
  ,VC.PARENT_SEC_CD
  ,TD.SOURCE_CD
  ,VD.SEC_NM SOURCE_NAME
  ,TD.ITEM_CD
  ,MI.item_name
  ,MP.MODEL
  ,MP.PKG_UNIT_QTY SNP  
  ,PO.ADATE
  ,PS.PARENT_ITEM_CD
  ,PO.QTY QTY
FROM 
   T_OD TD
 , M_ITEM MI
 , M_PLANT_ITEM MP
 , vm_department_class VC
 , VM_DEPARTMENT VD
 , M_PLANT_PS PS
 , (
      SELECT  
        ITEM_CD
       ,SUM(ODR_QTY) QTY
       ,ACPT_PLAN_DATE ADATE
      FROM 
        T_OD 
      WHERE 
        TO_CHAR( ACPT_PLAN_DATE,'YYYY-MM-DD' ) BETWEEN TO_CHAR( TRUNC( ADD_MONTHS(SYSDATE,-1),'MM'),'YYYY-MM-DD' ) AND TO_CHAR( LAST_DAY( ADD_MONTHS(SYSDATE,-1) ),'YYYY-MM-DD')  
      GROUP BY
        ITEM_CD
       ,ACPT_PLAN_DATE  
    ) PO
WHERE 
    TD.SOURCE_CD = VC.COMP_SEC_CD(+)
AND TD.ITEM_CD  = MI.ITEM_CD(+)
AND TD.SOURCE_CD  = VD.SEC_CD(+)
AND TD.PLANT_CD = MP.PLANT_CD
AND TD.ITEM_CD  = MP.ITEM_CD(+)
AND TD.ITEM_CD  = PS.COMP_ITEM_CD(+)
AND PS.PARENT_ITEM_CD  = PO.ITEM_CD(+)
AND VC.PARENT_SEC_CD = 'K1PD03'
AND TD.OUTSIDE_TYP = 1 AND NOT (TD.ODR_STS_TYP = 9 AND TD.TOTAL_RCV_QTY = 0)
AND TO_CHAR( TD.ACPT_PLAN_DATE,'YYYY-MM-DD' ) BETWEEN TO_CHAR( TRUNC( ADD_MONTHS(SYSDATE,-1),'MM'),'YYYY-MM-DD' ) AND TO_CHAR( LAST_DAY( ADD_MONTHS(SYSDATE,-1) ),'YYYY-MM-DD')
AND PO.ADATE IS NOT NULL
GROUP BY 
   TD.PLANT_CD
  ,VC.PARENT_SEC_CD
  ,TD.SOURCE_CD
  ,TD.ITEM_CD
  ,MI.item_name
  ,MP.MODEL
  ,PS.PARENT_ITEM_CD
  ,PO.ADATE
  ,PO.QTY
  ,VD.SEC_NM
  ,MP.PKG_UNIT_QTY  
UNION ALL

SELECT 
  2 DM_TYP
  ,TD.PLANT_CD
  ,VC.PARENT_SEC_CD
  ,TD.SOURCE_CD
  ,VD.SEC_NM SOURCE_NAME
  ,TD.ITEM_CD
  ,MI.item_name
  ,MP.MODEL
  ,MP.PKG_UNIT_QTY SNP  
  ,TD.ACPT_PLAN_DATE ADATE
  ,TD.ITEM_CD PARENT_ITEM_CD
  ,SUM(TD.ODR_QTY) QTY
FROM 
   T_OD TD
 , M_ITEM MI
 , M_PLANT_ITEM MP
 , vm_department_class VC
 , VM_DEPARTMENT VD
WHERE 
    TD.SOURCE_CD = VC.COMP_SEC_CD(+)
AND TD.ITEM_CD  = MI.ITEM_CD(+)
AND TD.PLANT_CD = MP.PLANT_CD
AND TD.ITEM_CD  = MP.ITEM_CD(+)
AND TD.SOURCE_CD  = VD.SEC_CD(+)

AND VC.PARENT_SEC_CD = 'K1PD03'
AND TD.OUTSIDE_TYP = 1 AND NOT (TD.ODR_STS_TYP = 9 AND TD.TOTAL_RCV_QTY = 0)
AND TO_CHAR( TD.ACPT_PLAN_DATE,'YYYY-MM-DD' ) BETWEEN TO_CHAR( TRUNC( ADD_MONTHS(SYSDATE,-1),'MM'),'YYYY-MM-DD' ) AND TO_CHAR( LAST_DAY( ADD_MONTHS(SYSDATE,-1) ),'YYYY-MM-DD')

GROUP BY 
   TD.PLANT_CD
  ,VC.PARENT_SEC_CD
  ,TD.SOURCE_CD
  ,TD.ITEM_CD
  ,MI.item_name
  ,MP.MODEL
  ,TD.ACPT_PLAN_DATE
  ,VD.SEC_NM
  ,MP.PKG_UNIT_QTY
UNION ALL

SELECT
 3 AS DM_TYP
,TR.PLANT_CD AS PLANT
,VC.PARENT_SEC_CD
,TR.WS_CD AS SOURCE_CD
,VD.SEC_NM AS SOURCE_NAME
,TR.ITEM_CD AS ITEM_CD
,MI.ITEM_NAME AS ITEM_NAME
,MP.MODEL
,MP.PKG_UNIT_QTY SNP
,TR.OPR_DATE AS ADATE
,TR.ITEM_CD AS PARENT_ITEM_CD
,SUM(TR.ACPT_QTY) AS QTY
FROM
 T_OPR_RSLT TR
,M_ITEM MI
,vm_department_class VC
,VM_DEPARTMENT VD
,M_PLANT_ITEM MP
WHERE
    TR.ITEM_CD = MI.ITEM_CD(+)
AND TR.WS_CD = VC.COMP_SEC_CD(+)
AND TR.WS_CD = VD.SEC_CD(+)
AND TR.PLANT_CD = MP.PLANT_CD
AND TR.ITEM_CD = MP.ITEM_CD(+)
AND VC.PARENT_SEC_CD = 'K1PD03'
AND TO_CHAR( TR.OPR_DATE,'YYYY-MM-DD' ) BETWEEN TO_CHAR( TRUNC( ADD_MONTHS(SYSDATE,-1),'MM'),'YYYY-MM-DD' ) AND TO_CHAR( LAST_DAY( ADD_MONTHS(SYSDATE,-1) ),'YYYY-MM-DD')
AND TR.ACPT_QTY > 0
GROUP BY
 TR.PLANT_CD
,VC.PARENT_SEC_CD
,TR.WS_CD
,VD.SEC_NM
,TR.ITEM_CD
,MI.ITEM_NAME
,MP.MODEL
,TR.OPR_DATE
,MP.PKG_UNIT_QTY
  
ORDER BY 1,4,6,9