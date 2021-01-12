SELECT
    BEN_NIR_PSA,
    EXE_SOI_DTD, 
    EXE_SOI_DTF,

    CAM_PRS_IDE,

    ER_PRS_F.PFS_EXE_NUM,
	PFS_PRA_SPE
	
FROM ER_CAM_F

--Prestation
INNER JOIN ER_PRS_F ON
    ER_CAM_F.DCT_ORD_NUM = ER_PRS_F.DCT_ORD_NUM AND
	ER_CAM_F.FLX_DIS_DTD = ER_PRS_F.FLX_DIS_DTD AND
	ER_CAM_F.FLX_EMT_NUM = ER_PRS_F.FLX_EMT_NUM AND
	ER_CAM_F.FLX_EMT_ORD = ER_PRS_F.FLX_EMT_ORD AND
	ER_CAM_F.FLX_EMT_TYP = ER_PRS_F.FLX_EMT_TYP AND
	ER_CAM_F.FLX_TRT_DTD = ER_PRS_F.FLX_TRT_DTD AND
	ER_CAM_F.PRS_ORD_NUM = ER_PRS_F.PRS_ORD_NUM AND
	ER_CAM_F.REM_TYP_AFF = ER_PRS_F.REM_TYP_AFF

--executant
LEFT JOIN DA_PRA_R ON
	ER_PRS_F.PFS_EXE_NUM = DA_PRA_R.PFS_PFS_NUM

LIMIT 100