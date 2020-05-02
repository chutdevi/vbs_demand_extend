SELECT
 DT.PLANT_CD
,DT.PARENT_SEC_CD
,DT.SOURCE_CD
,DT.SOURCE_NAME
,DT.ITEM_CD
,DT.ITEM_NAME
,DT.MODEL
,DT.SNP
,IFNULL(SUM( DT.DM_01 ),0)  DM_01
,IFNULL(SUM( DT.PL_01 ),0)  PL_01
,IFNULL(SUM( DT.AC_01 ),0)  AC_01

FROM
(
SELECT

 DT.PLANT_CD
,DT.PARENT_SEC_CD
,DT.SOURCE_CD
,DT.SOURCE_NAME
,DT.ITEM_CD
,DT.ITEM_NAME
,DT.MODEL
,DT.SNP

,IFNULL(SUM(  CASE WHEN DT.DM_TYP = 1 THEN DT.QTY END ),0)  DM_01

,IFNULL(SUM(  CASE WHEN DT.DM_TYP = 2 THEN DT.QTY END ),0)  PL_01

,IFNULL(SUM(  CASE WHEN DT.DM_TYP = 3 THEN DT.QTY END ),0)  AC_01

FROM 

DEMAND_DATA DT

GROUP BY 
 DT.PLANT_CD
,DT.PARENT_SEC_CD
,DT.SOURCE_CD
,DT.SOURCE_NAME
,DT.ITEM_CD
,DT.ITEM_NAME
,DT.DM_TYP
,DT.SNP
) DT

GROUP BY 
 DT.PLANT_CD
,DT.PARENT_SEC_CD
,DT.SOURCE_CD
,DT.SOURCE_NAME
,DT.ITEM_CD
,DT.ITEM_NAME
,DT.SNP