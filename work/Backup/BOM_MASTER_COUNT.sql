
SELECT 
 COUNT(MB.PARENT_ITEM_CD) MC
FROM
	
(
  SELECT 
  
    MM.PRODUCT_TYP
  , MP.PARENT_ITEM_CD
  , MI.ITEM_NAME
  , MM.MODEL
    ,TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') CREATE_DATE
  ,TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') UPDATE_DATE
  FROM 
   M_PLANT_PS MP 
  ,M_PLANT_ITEM MM 
  ,M_ITEM MI

  
  WHERE 
      MP.PARENT_ITEM_CD = MM.ITEM_CD(+)
  AND MP.PARENT_ITEM_CD = MI.ITEM_CD(+)
  AND MM.REMARK1 = 'EXPIRED'
  GROUP BY
    MM.PRODUCT_TYP
  , MP.PARENT_ITEM_CD
  , MI.ITEM_NAME
  , MM.MODEL
  
  ORDER BY 1
) MB