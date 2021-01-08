SELECT 
	ER_PRS_F.EXE_SOI_DTD,
	ER_PRS_F.EXE_SOI_DTF,
	
	ER_CAM_F.CAM_PRS_IDE,
	
	
	PRA_EXE.PFS_PFS_NUM AS PRA_EXE_NUM,
	PRA_PRE.PFS_PFS_NUM AS PRA_PRE_NUM,
	
	PHA.PHA_PRS_IDE,
	PHA.PHA_ATC_C07,
	
	IR_BEN_R.BEN_SEX_COD,
	IR_BEN_R.BEN_NAI_MOI,
	IR_BEN_R.BEN_RES_DPT
	
FROM ER_PRS_F

--Classification acte medicaux
LEFT JOIN ER_CAM_F ON 
	ER_PRS_F.DCT_ORD_NUM = ER_CAM_F.DCT_ORD_NUM AND
	ER_PRS_F.FLX_DIS_DTD = ER_CAM_F.FLX_DIS_DTD AND
	ER_PRS_F.FLX_EMT_NUM = ER_CAM_F.FLX_EMT_NUM AND
	ER_PRS_F.FLX_EMT_ORD = ER_CAM_F.FLX_EMT_ORD AND
	ER_PRS_F.FLX_EMT_TYP = ER_CAM_F.FLX_EMT_TYP AND
	ER_PRS_F.FLX_TRT_DTD = ER_CAM_F.FLX_TRT_DTD AND
	ER_PRS_F.PRS_ORD_NUM = ER_CAM_F.PRS_ORD_NUM AND
	ER_PRS_F.REM_TYP_AFF = ER_CAM_F.REM_TYP_AFF

	
--executant
LEFT JOIN DA_PRA_R PRA_EXE ON
	ER_PRS_F.PFS_EXE_NUM = PRA_EXE.PFS_PFS_NUM
--prescripteur
LEFT JOIN DA_PRA_R PRA_PRE ON
	ER_PRS_F.PFS_PRE_NUM = PRA_PRE.PFS_PFS_NUM

--Codage pharmacie et medicament
LEFT JOIN (
	SELECT
		ER_PHA_F.DCT_ORD_NUM,
		ER_PHA_F.FLX_DIS_DTD,
		ER_PHA_F.FLX_EMT_NUM,
		ER_PHA_F.FLX_EMT_ORD,
		ER_PHA_F.FLX_EMT_TYP,
		ER_PHA_F.FLX_TRT_DTD,
		ER_PHA_F.PRS_ORD_NUM,
		ER_PHA_F.REM_TYP_AFF,
		ER_PHA_F.PHA_PRS_IDE,
		IR_PHA_R.PHA_ATC_C07
		
		FROM ER_PHA_F
		
		--Codage medicament
		INNER JOIN IR_PHA_R ON
		ER_PHA_F.PHA_PRS_C13 = IR_PHA_R.PHA_CIP_C13
) PHA ON
	ER_PRS_F.DCT_ORD_NUM = PHA.DCT_ORD_NUM AND
	ER_PRS_F.FLX_DIS_DTD = PHA.FLX_DIS_DTD AND
	ER_PRS_F.FLX_EMT_NUM = PHA.FLX_EMT_NUM AND
	ER_PRS_F.FLX_EMT_ORD = PHA.FLX_EMT_ORD AND
	ER_PRS_F.FLX_EMT_TYP = PHA.FLX_EMT_TYP AND
	ER_PRS_F.FLX_TRT_DTD = PHA.FLX_TRT_DTD AND
	ER_PRS_F.PRS_ORD_NUM = PHA.PRS_ORD_NUM AND
	ER_PRS_F.REM_TYP_AFF = PHA.REM_TYP_AFF

--Codage biologique TABLE NON DISPONIBLE
/*
LEFT JOIN ER_BIO_F ON
	ER_PRS_F.DCT_ORD_NUM = ER_BIO_F.DCT_ORD_NUM AND
	ER_PRS_F.FLX_DIS_DTD = ER_BIO_F.FLX_DIS_DTD AND
	ER_PRS_F.FLX_EMT_NUM = ER_BIO_F.FLX_EMT_NUM AND
	ER_PRS_F.FLX_EMT_ORD = ER_BIO_F.FLX_EMT_ORD AND
	ER_PRS_F.FLX_EMT_TYP = ER_BIO_F.FLX_EMT_TYP AND
	ER_PRS_F.FLX_TRT_DTD = ER_BIO_F.FLX_TRT_DTD AND
	ER_PRS_F.PRS_ORD_NUM = ER_BIO_F.PRS_ORD_NUM AND
	ER_PRS_F.REM_TYP_AFF = ER_BIO_F.REM_TYP_AFF
*/	

--Beneficiaire
INNER JOIN IR_BEN_R ON
	ER_PRS_F.ben_nir_psa = IR_BEN_R.ben_nir_psa AND
	ER_PRS_F.ben_rng_gem = IR_BEN_R.ben_rng_gem

--ALD TABLE NON DISPONIBLE
/*
LEFT JOIN IR_IMB_R ON
	IR_BEN_R.ben_nir_psa = IR_IMB_R.ben_nir_psa AND
	IR_BEN_R.ben_rng_gem = IR_IMB_R.ben_rng_gem
*/

--WHERE PHA.PHA_PRS_IDE IS NULL