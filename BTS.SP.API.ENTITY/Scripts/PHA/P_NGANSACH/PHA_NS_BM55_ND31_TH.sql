﻿create or replace procedure PHA_NS_BM55_ND31_TH(P_LOAI_BAOCAO IN VARCHAR2, P_CONGTHUC VARCHAR2, TUNGAY_KS IN DATE, DENNGAY_KS IN DATE, TUNGAY_HL IN DATE, DENNGAY_HL IN DATE, P_CAP VARCHAR2, DONVI_TIEN number, cur OUT SYS_REFCURSOR) as
   QUERY_STR   CLOB; 
   P_CT  VARCHAR2(32767);    
   P_SQL_INSERT  VARCHAR2(32767); 
   TEMP  VARCHAR2(32767);
   
   --CHI DAU TU PHAT TRIEN
   CT_CDT_QP VARCHAR2(32767);   CT_CDT_AN VARCHAR2(32767);   CT_CDT_KH VARCHAR2(32767);   CT_CDT_HDKT VARCHAR2(32767);
   CT_CDT_QLNN VARCHAR2(32767);   CT_CDT_BVMT VARCHAR2(32767);   CT_CDT_BDXH VARCHAR2(32767);   CT_CDT_VH VARCHAR2(32767);
   CT_CDT_KHCN VARCHAR2(32767);   CT_CDT_GD VARCHAR2(32767);   CT_CDT_YT VARCHAR2(32767);   CT_CDT_TDTT VARCHAR2(32767);
   CT_CDT_PT VARCHAR2(32767);
   
   BEGIN
    IF TRIM(P_CONGTHUC) IS NOT NULL THEN 
        select STC_PA_SYS.FNC_CONVERT_FORMULA_HCSN(P_CONGTHUC) INTO P_CT from dual;       
        P_CT:= ' AND ' || P_CT;
    END IF;
    
    --Gán công thức
    -------Chi đầu tư    
    IF(UPPER(P_LOAI_BAOCAO) = 'DH') THEN 
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_QP from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_QP';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_AN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_AN';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_KH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_KH';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_HDKT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_HDKT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_QLNN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_QLNN';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_BVMT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_BVMT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_BDXH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_BDXH';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_VH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_VH';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_KHCN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_KHCN';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_GD from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_GD';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_YT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_YT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_TDTT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_TDTT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_PT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_PT';
    END IF;
    IF(UPPER(P_LOAI_BAOCAO) = 'QT') THEN 
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_QP from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_QP';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_AN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_AN';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_KH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_KH';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_HDKT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_HDKT';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_QLNN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_QLNN';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_BVMT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_BVMT';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_BDXH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_BDXH';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_VH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_VH';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_KHCN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_KHCN';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_GD from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_GD';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_YT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_YT';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_TDTT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_TDTT';
         select REPLACE(CONGTHUC_WHERE, '''', '''') INTO CT_CDT_PT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='CHITIEU_CHI' AND MA_COT='CDT_PT';
    END IF;
    
    CASE 
        WHEN P_CAP='2' THEN TEMP:=' AND A.MA_CHUONG BETWEEN ''400'' AND ''989''';
        WHEN P_CAP='3' THEN TEMP:=' AND A.MA_CHUONG BETWEEN ''600'' AND ''989''';
        WHEN P_CAP='4' THEN TEMP:=' AND A.MA_CHUONG BETWEEN ''800'' AND ''989''';
        ELSE TEMP:='';
    END CASE;

            QUERY_STR:='SELECT HT.MA_CHUONG, HT.TEN_CHUONG
                                , NVL(HT.CDT_QP,0) as CDT_QP, NVL(HT.CDT_AN,0) as CDT_AN, NVL(HT.CDT_KH,0) as CDT_KH, NVL(HT.CDT_HDKT,0) as CDT_HDKT, NVL(HT.CDT_QLNN,0) as CDT_QLNN
                                , NVL(HT.CDT_BVMT,0) as CDT_BVMT, NVL(HT.CDT_BDXH,0) as CDT_BDXH, NVL(HT.CDT_VH,0) as CDT_VH, NVL(HT.CDT_KHCN,0) as CDT_KHCN
                                , NVL(HT.CDT_GD,0) as CDT_GD, NVL(HT.CDT_YT,0) as CDT_YT, NVL(HT.CDT_TDTT,0) as CDT_TDTT, NVL(HT.CDT_PT,0) as CDT_PT                   
                        FROM
                        (
                        SELECT A.MA_CHUONG AS MA_CHUONG, A.TEN_CHUONG
                                ,NVL(SUM (CASE WHEN ('|| CT_CDT_QP ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_QP
                                ,NVL(SUM (CASE WHEN ('|| CT_CDT_AN ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_AN
                                ,NVL(SUM (CASE WHEN ('|| CT_CDT_KH ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_KH
                                ,NVL(SUM (CASE WHEN ('|| CT_CDT_HDKT ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_HDKT
                                ,NVL(SUM (CASE WHEN ('|| CT_CDT_QLNN ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_QLNN
                                ,NVL(SUM (CASE WHEN ('|| CT_CDT_BVMT ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_BVMT
                                ,NVL(SUM (CASE WHEN ('|| CT_CDT_BDXH ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_BDXH
                                ,NVL(SUM (CASE WHEN ('|| CT_CDT_VH ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_VH
                                ,NVL(SUM (CASE WHEN ('|| CT_CDT_KHCN ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_KHCN
                                ,NVL(SUM (CASE WHEN ('|| CT_CDT_GD ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_GD
                                ,NVL(SUM (CASE WHEN ('|| CT_CDT_YT ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_YT
                                ,NVL(SUM (CASE WHEN ('|| CT_CDT_TDTT ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_TDTT
                                ,NVL(SUM (CASE WHEN ('|| CT_CDT_PT ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CDT_PT

                        FROM PHA_HACHTOAN_CHI A
                        WHERE  A.NGAY_HIEU_LUC >= TO_DATE ('''||to_char(TUNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')
                                AND A.NGAY_HIEU_LUC <= TO_DATE ('''||to_char(DENNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')     
                                and A.NGAY_KET_SO <=TO_DATE ('''||to_char(DENNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')
                                and A.NGAY_KET_SO >=TO_DATE ('''||to_char(TUNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')
                                AND NOT A.MA_CAP like ''1'' AND NOT A.MA_CHUONG LIKE ''000'' '
                                || TEMP
                                || P_CT
                                || ' GROUP BY A.MA_CHUONG,A.TEN_CHUONG
                        ) HT
                        WHERE 1=1 ORDER BY HT.MA_CHUONG';


            DBMS_OUTPUT.put_line(QUERY_STR); 

BEGIN
EXECUTE IMMEDIATE QUERY_STR;
OPEN cur FOR QUERY_STR;
EXCEPTION
  WHEN NO_DATA_FOUND
  THEN
     DBMS_OUTPUT.put_line ('<your message>' || SQLERRM);
   WHEN OTHERS
   THEN
    --DBMS_OUTPUT.ENABLE(200000);
     DBMS_OUTPUT.put_line ('<your message>'  || SQLERRM); 
END;   
END PHA_NS_BM55_ND31_TH;