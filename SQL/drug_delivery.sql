SELECT
    BEN_NIR_PSA,
    EXE_SOI_DTD, 
    EXE_SOI_DTF,

    PHA_ATC_C07, 
    PHA_ACT_QSN, 

	PFS_FIN_NUM
	
FROM ER_PHA_F

--Codage medicament
INNER JOIN IR_PHA_R ON
    ER_PHA_F.PHA_PRS_C13 = IR_PHA_R.PHA_CIP_C13

--Prestation
INNER JOIN ER_PRS_F ON
    ER_PHA_F.DCT_ORD_NUM = ER_PRS_F.DCT_ORD_NUM AND
	ER_PHA_F.FLX_DIS_DTD = ER_PRS_F.FLX_DIS_DTD AND
	ER_PHA_F.FLX_EMT_NUM = ER_PRS_F.FLX_EMT_NUM AND
	ER_PHA_F.FLX_EMT_ORD = ER_PRS_F.FLX_EMT_ORD AND
	ER_PHA_F.FLX_EMT_TYP = ER_PRS_F.FLX_EMT_TYP AND
	ER_PHA_F.FLX_TRT_DTD = ER_PRS_F.FLX_TRT_DTD AND
	ER_PHA_F.PRS_ORD_NUM = ER_PRS_F.PRS_ORD_NUM AND
	ER_PHA_F.REM_TYP_AFF = ER_PRS_F.REM_TYP_AFF

--executant
LEFT JOIN DA_PRA_R ON
	ER_PRS_F.PFS_EXE_NUM = DA_PRA_R.PFS_PFS_NUM