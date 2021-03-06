﻿create or replace PROCEDURE PHA_BM68_TT343 (P_MA_DBHC IN NVARCHAR2,P_LOAI_BAOCAO IN VARCHAR2, P_CONGTHUC VARCHAR2, TUNGAY_KS IN DATE, DENNGAY_KS IN DATE, TUNGAY_HL IN DATE, DENNGAY_HL IN DATE, P_CAP VARCHAR2, DONVI_TIEN number, cur OUT SYS_REFCURSOR) as
   QUERY_STR  CLOB;
   QUERY_STR1  CLOB; 
   QUERY_STR2  CLOB;
   INSERT_STR  CLOB; 
   INSERT_STR1  CLOB;
   QUERY_STR_CHI CLOB;
   QUERY_STR_DUTOAN CLOB;
   P_CT VARCHAR2(32767);   
   P_SQL_INSERT VARCHAR2(32767); 
   TEMP VARCHAR2(32767);
   P_SQL_CREATE_TABLE_TH  VARCHAR2(32767);  
    N_COUNT NUMBER(17,4):=0;
    P_SELECT_DBHC VARCHAR2(32767);

   --CHI DAU TU PHAT TRIEN
   CT_CDT_QP VARCHAR2(32767);   CT_CDT_AN VARCHAR2(32767);   CT_CDT_GDDT VARCHAR2(32767);   CT_CDT_KHCN VARCHAR2(32767);
   CT_CDT_YT VARCHAR2(32767);   CT_CDT_VHTT VARCHAR2(32767);   CT_CDT_PTTH VARCHAR2(32767);   CT_CDT_TDTT VARCHAR2(32767);
   CT_CDT_BVMT VARCHAR2(32767);   CT_CDT_KT VARCHAR2(32767);   CT_CDT_QLNN VARCHAR2(32767);   CT_CDT_BDXH VARCHAR2(32767);
   CT_CDT_KHAC VARCHAR2(32767);  

   CT_DT_CDT_QP VARCHAR2(32767);   CT_DT_CDT_AN VARCHAR2(32767);   CT_DT_CDT_GDDT VARCHAR2(32767);   CT_DT_CDT_KHCN VARCHAR2(32767);
   CT_DT_CDT_YT VARCHAR2(32767);   CT_DT_CDT_VHTT VARCHAR2(32767);   CT_DT_CDT_PTTH VARCHAR2(32767);   CT_DT_CDT_TDTT VARCHAR2(32767);
   CT_DT_CDT_BVMT VARCHAR2(32767);   CT_DT_CDT_KT VARCHAR2(32767);   CT_DT_CDT_QLNN VARCHAR2(32767);   CT_DT_CDT_BDXH VARCHAR2(32767);
   CT_DT_CDT_KHAC VARCHAR2(32767);  

   --CHI THUONG XUYEN
   CT_CTX_QP VARCHAR2(32767);   CT_CTX_AN VARCHAR2(32767);   CT_CTX_GDDT VARCHAR2(32767);   CT_CTX_KHCN VARCHAR2(32767);
   CT_CTX_YT VARCHAR2(32767);   CT_CTX_VHTT VARCHAR2(32767);   CT_CTX_PTTH VARCHAR2(32767);   CT_CTX_TDTT VARCHAR2(32767);
   CT_CTX_BVMT VARCHAR2(32767);   CT_CTX_KT VARCHAR2(32767);   CT_CTX_QLNN VARCHAR2(32767);   CT_CTX_BDXH VARCHAR2(32767);
   CT_CTX_KHAC VARCHAR2(32767);  

   CT_DT_CTX_QP VARCHAR2(32767);   CT_DT_CTX_AN VARCHAR2(32767);   CT_DT_CTX_GDDT VARCHAR2(32767);   CT_DT_CTX_KHCN VARCHAR2(32767);
   CT_DT_CTX_YT VARCHAR2(32767);   CT_DT_CTX_VHTT VARCHAR2(32767);   CT_DT_CTX_PTTH VARCHAR2(32767);   CT_DT_CTX_TDTT VARCHAR2(32767);
   CT_DT_CTX_BVMT VARCHAR2(32767);   CT_DT_CTX_KT VARCHAR2(32767);   CT_DT_CTX_QLNN VARCHAR2(32767);   CT_DT_CTX_BDXH VARCHAR2(32767);
   CT_DT_CTX_KHAC VARCHAR2(32767); 
   --KHAC
   CT_CTMTCDT VARCHAR2(32767);   CT_CTMTCTX VARCHAR2(32767);  

   BEGIN
    IF TRIM(P_CONGTHUC) IS NOT NULL THEN 
        select STC_PA_SYS.FNC_CONVERT_FORMULA_HCSN(P_CONGTHUC) INTO P_CT from dual;       
        P_CT:= ' AND ' || P_CT;
    END IF;

    --Gán công thức
    IF(UPPER(P_LOAI_BAOCAO) = 'DH') THEN 
        -------Chi đầu tư
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_QP from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_30110_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_AN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_30120_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_GDDT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_30130_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_KHCN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_30140_MT ';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_YT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_30150_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_VHTT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_30160_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_PTTH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_30170_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_TDTT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_30180_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_BVMT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_30190_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_KT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_30200_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_QLNN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_30210_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_BDXH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_30220_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CDT_KHAC from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_30230_MT';


         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CDT_QP from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='30110_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CDT_AN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='30120_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CDT_GDDT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='30130_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CDT_KHCN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='30140_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CDT_YT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='30150_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CDT_VHTT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='30160_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CDT_PTTH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='30170_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CDT_TDTT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='30180_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CDT_BVMT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='30190_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CDT_KT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='30200_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CDT_QLNN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='30210_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CDT_BDXH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='30220_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CDT_KHAC from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='30230_MT';



        -------Chi thường xuyên
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_QP from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_34020_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_AN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_34030_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_GDDT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_34040_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_KHCN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_34080_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_YT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_34090_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_VHTT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_34300_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_PTTH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_34400_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_TDTT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_34500_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_BVMT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_34600_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_KT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_34700_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_QLNN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_34800_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_BDXH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_34900_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTX_KHAC from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='QT_35020_MT';


         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CTX_QP from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='34020_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CTX_AN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='34030_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CTX_GDDT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='34040_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CTX_KHCN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='34080_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CTX_YT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='34090_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CTX_VHTT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='34300_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CTX_PTTH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='34400_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CTX_TDTT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='34500_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CTX_BVMT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='34600_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CTX_KT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='34700_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CTX_QLNN from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='34800_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CTX_BDXH from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='34900_MT';
         select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_DT_CTX_KHAC from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='35020_MT';

    END IF;
    -------KHAC
     
     select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTMTCDT from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='45100_DT';
     select REPLACE(CONGTHUC_DH_WHERE, '''', '''') INTO CT_CTMTCTX from DM_CHITIEU_BAOCAO_COL WHERE MA_BAOCAO='BM66_TT343' AND MA_COT='45100_TX';


     P_SQL_CREATE_TABLE_TH := 'CREATE TABLE BM68_TT343(
        LOAI_CHITIEU NUMBER,MA_TKTN NVARCHAR2(100), MA_DIABAN NVARCHAR2(100),TEN_DIABAN NVARCHAR2(2000), MA_CAP NVARCHAR2(100),MA_CAPMLNS NVARCHAR2(100),MA_CHUONG NVARCHAR2(100),TEN_CHUONG NVARCHAR2(2000),MA_NGANHKT NVARCHAR2(100),MA_LOAI NVARCHAR2(100),
        MA_TIEUMUC NVARCHAR2(100), MA_MUC NVARCHAR2(100), MA_TIEUNHOM NVARCHAR2(100),MA_NHOM NVARCHAR2(100),MA_CTMTQG NVARCHAR2(100),TEN_CTMTQG NVARCHAR2(2000),MA_KBNN NVARCHAR2(100), NGAY_HIEU_LUC DATE, NGAY_KET_SO DATE,LOAI_DU_TOAN NVARCHAR2(100),
        MA_NGUON_NSNN NVARCHAR2(100),MA_DVQHNS NVARCHAR2(100), TEN_DVQHNS NVARCHAR2(2000), MA_NVC NVARCHAR2(100), GIA_TRI_HACH_TOAN NUMBER)SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  ';          

    QUERY_STR_CHI := 'SELECT 2,MA_TKTN ,MA_DIABAN, TEN_DIABAN,MA_CAP,MA_CAPMLNS,MA_CHUONG,TEN_CHUONG,MA_NGANHKT,MA_LOAI,MA_TIEUMUC,MA_MUC,MA_TIEUNHOM,MA_NHOM,MA_CTMTQG,TEN_CTMTQG,MA_KBNN,MA_NGUON_NSNN,MA_DVQHNS, TEN_DVQHNS,MA_NVC,TO_DATE(to_char(NGAY_HIEU_LUC,''ddMMyyyy''), ''ddMMyyyy''),TO_DATE (to_char(NGAY_KET_SO,''ddMMyyyy''), ''ddMMyyyy''),ATTRIBUTE8
        ,SUM (GIA_TRI_HACH_TOAN) FROM PHA_HACHTOAN_CHI VC 
         GROUP BY  MA_TKTN,MA_DIABAN, TEN_DIABAN,MA_CAP,MA_CAPMLNS,MA_CHUONG,TEN_CHUONG,MA_NGANHKT,MA_LOAI,MA_TIEUMUC,MA_MUC,MA_TIEUNHOM,MA_NHOM,MA_CTMTQG,TEN_CTMTQG,MA_KBNN,MA_NGUON_NSNN,MA_DVQHNS, TEN_DVQHNS,MA_NVC,NGAY_HIEU_LUC,NGAY_KET_SO,ATTRIBUTE8';   
        INSERT_STR := 'INSERT INTO BM68_TT343(LOAI_CHITIEU,MA_TKTN ,MA_DIABAN, TEN_DIABAN,MA_CAP,MA_CAPMLNS,MA_CHUONG,TEN_CHUONG,MA_NGANHKT,MA_LOAI, MA_TIEUMUC,MA_MUC,MA_TIEUNHOM,MA_NHOM,MA_CTMTQG,TEN_CTMTQG,MA_KBNN,MA_NGUON_NSNN,MA_DVQHNS, TEN_DVQHNS,MA_NVC,NGAY_HIEU_LUC,NGAY_KET_SO,LOAI_DU_TOAN,GIA_TRI_HACH_TOAN)('||QUERY_STR_CHI||')';

   QUERY_STR_DUTOAN := 'SELECT 3,MA_TKTN ,MA_DIABAN, TEN_DIABAN,MA_CAP,MA_CAPMLNS,MA_CHUONG,TEN_CHUONG,MA_NGANHKT,MA_LOAI,MA_TIEUMUC,MA_MUC,MA_TIEUNHOM,MA_NHOM,MA_CTMTQG,TEN_CTMTQG,MA_KBNN,MA_NGUON_NSNN,MA_DVQHNS, TEN_DVQHNS,MA_NVC,TO_DATE(to_char(NGAY_HIEU_LUC,''ddMMyyyy''), ''ddMMyyyy''),TO_DATE (to_char(NGAY_KET_SO,''ddMMyyyy''), ''ddMMyyyy''),ATTRIBUTE8
        ,SUM (GIA_TRI_HACH_TOAN) FROM PHA_DUTOAN VC 
         GROUP BY  MA_TKTN,MA_DIABAN, TEN_DIABAN,MA_CAP,MA_CAPMLNS,MA_CHUONG,TEN_CHUONG,MA_NGANHKT,MA_LOAI,MA_TIEUMUC,MA_MUC,MA_TIEUNHOM,MA_NHOM,MA_CTMTQG,TEN_CTMTQG,MA_KBNN,MA_NGUON_NSNN,MA_DVQHNS, TEN_DVQHNS,MA_NVC,NGAY_HIEU_LUC,NGAY_KET_SO,ATTRIBUTE8';   
        INSERT_STR1 := 'INSERT INTO BM68_TT343(LOAI_CHITIEU,MA_TKTN ,MA_DIABAN, TEN_DIABAN,MA_CAP,MA_CAPMLNS,MA_CHUONG,TEN_CHUONG,MA_NGANHKT,MA_LOAI, MA_TIEUMUC,MA_MUC,MA_TIEUNHOM,MA_NHOM,MA_CTMTQG,TEN_CTMTQG,MA_KBNN,MA_NGUON_NSNN,MA_DVQHNS, TEN_DVQHNS,MA_NVC,NGAY_HIEU_LUC,NGAY_KET_SO,LOAI_DU_TOAN,GIA_TRI_HACH_TOAN)('||QUERY_STR_DUTOAN||')';
  BEGIN
        SELECT COUNT(*)  INTO N_COUNT  FROM ALL_TAB_COLUMNS  WHERE TABLE_NAME = 'BM68_TT343';
        EXCEPTION WHEN OTHERS THEN N_COUNT:=0;
    END;
  IF(N_COUNT IS NULL OR N_COUNT<=0) THEN
    BEGIN
        EXECUTE IMMEDIATE P_SQL_CREATE_TABLE_TH;  
        EXECUTE IMMEDIATE INSERT_STR; 
        EXECUTE IMMEDIATE INSERT_STR1;   
    END;
    END IF;

        P_SELECT_DBHC:= ' AND MA_DIABAN IN (SELECT MA_DBHC FROM DM_DBHC WHERE MA_DBHC IN (SELECT MA_DBHC FROM DM_DBHC WHERE MA_DBHC = '''||P_MA_DBHC||''' OR MA_DBHC_CHA = '''||P_MA_DBHC||''') OR MA_DBHC_CHA IN (SELECT MA_DBHC FROM DM_DBHC WHERE MA_DBHC = '''||P_MA_DBHC||''' OR MA_DBHC_CHA = '''||P_MA_DBHC||'''))';

        IF(P_SELECT_DBHC IS NOT NULL) THEN
        P_CT:=P_CT || P_SELECT_DBHC;
        ELSE
        P_CT:=P_CT;
        END IF;
            
             QUERY_STR:='SELECT HT.MA_CHUONG, HT.TEN_CHUONG, HT.MA_DVQHNS, HT.TEN_DVQHNS, HT.MA_CTMTQG, HT.TEN_CTMTQG
                        , NVL(HT.CT_CDT_QP,0) as CT_CDT_QP, NVL(HT.CT_CDT_AN,0) as CT_CDT_AN, NVL(HT.CT_CDT_GDDT,0) as CT_CDT_GDDT, NVL(HT.CT_CDT_KHCN,0) as CT_CDT_KHCN, NVL(HT.CT_CDT_YT,0) as CT_CDT_YT
                        , NVL(HT.CT_CDT_VHTT,0) as CT_CDT_VHTT, NVL(HT.CT_CDT_PTTH,0) as CT_CDT_PTTH, NVL(HT.CT_CDT_TDTT,0) as CT_CDT_TDTT, NVL(HT.CT_CDT_BVMT,0) as CT_CDT_BVMT
                        , NVL(HT.CT_CDT_KT,0) as CT_CDT_KT, NVL(HT.CT_CDT_QLNN,0) as CT_CDT_QLNN, NVL(HT.CT_CDT_BDXH,0) as CT_CDT_BDXH, NVL(HT.CT_CDT_KHAC,0) as CT_CDT_KHAC
                        , NVL(HT.CT_DT_CDT_QP,0) as CT_DT_CDT_QP, NVL(HT.CT_DT_CDT_AN,0) as CT_DT_CDT_AN, NVL(HT.CT_DT_CDT_GDDT,0) as CT_DT_CDT_GDDT, NVL(HT.CT_DT_CDT_KHCN,0) as CT_DT_CDT_KHCN, NVL(HT.CT_DT_CDT_YT,0) as CT_DT_CDT_YT
                        , NVL(HT.CT_DT_CDT_VHTT,0) as CT_DT_CDT_VHTT, NVL(HT.CT_DT_CDT_PTTH,0) as CT_DT_CDT_PTTH, NVL(HT.CT_DT_CDT_TDTT,0) as CT_DT_CDT_TDTT, NVL(HT.CT_DT_CDT_BVMT,0) as CT_DT_CDT_BVMT
                        , NVL(HT.CT_DT_CDT_KT,0) as CT_DT_CDT_KT, NVL(HT.CT_DT_CDT_QLNN,0) as CT_DT_CDT_QLNN, NVL(HT.CT_DT_CDT_BDXH,0) as CT_DT_CDT_BDXH, NVL(HT.CT_DT_CDT_KHAC,0) as CT_DT_CDT_KHAC 
                        , NVL(HT.CT_CTX_QP,0) as CT_CTX_QP, NVL(HT.CT_CTX_AN,0) as  CT_CTX_AN, NVL(HT.CT_CTX_GDDT,0) as  CT_CTX_GDDT, NVL(HT.CT_CTX_KHCN,0) as  CT_CTX_KHCN, NVL(HT.CT_CTX_YT,0) as CT_CTX_YT, NVL(HT.CT_CTX_VHTT,0) as CT_CTX_VHTT
                        , NVL(HT.CT_CTX_PTTH,0) as CT_CTX_PTTH, NVL(HT.CT_CTX_TDTT,0) as CT_CTX_TDTT, NVL(HT.CT_CTX_BVMT,0) as CT_CTX_BVMT, NVL(HT.CT_CTX_KT,0) as CT_CTX_KT
                        , NVL(HT.CT_CTX_QLNN,0) as CT_CTX_QLNN, NVL(HT.CT_CTX_BDXH,0) as CT_CTX_BDXH, NVL(HT.CT_CTX_KHAC,0) as CT_CTX_KHAC
                        , NVL(HT.CT_DT_CTX_QP,0) as  CT_DT_CTX_QP, NVL(HT.CT_DT_CTX_AN,0) as  CT_DT_CTX_AN, NVL(HT.CT_DT_CTX_GDDT,0) as CT_DT_CTX_GDDT, NVL(HT.CT_DT_CTX_KHCN,0) as CT_DT_CTX_KHCN, NVL(HT.CT_DT_CTX_YT,0) as CT_DT_CTX_YT
                        , NVL(HT.CT_DT_CTX_VHTT,0) as CT_DT_CTX_VHTT, NVL(HT.CT_DT_CTX_PTTH,0) as CT_DT_CTX_PTTH, NVL(HT.CT_DT_CTX_TDTT,0) as CT_DT_CTX_TDTT, NVL(HT.CT_DT_CTX_BVMT,0) as CT_DT_CTX_BVMT
                        , NVL(HT.CT_DT_CTX_KT,0) as CT_DT_CTX_KT, NVL(HT.CT_DT_CTX_QLNN,0) as CT_DT_CTX_QLNN, NVL(HT.CT_DT_CTX_BDXH,0) as CT_DT_CTX_BDXH, NVL(HT.CT_DT_CTX_KHAC,0) as CT_DT_CTX_KHAC
                        , NVL(HT.CT_CTMTCDT,0) as CT_CTMTCDT
                        , NVL(HT.CT_CTMTCTX,0) as CT_CTMTCTX, NVL(HT.CT_DT_CTMTCDT,0) as CT_DT_CTMTCDT
                        , NVL(HT.CT_DT_CTMTCTX,0) as CT_DT_CTMTCTX, NVL(HT.QT_VTT_DT,0) as QT_VTT_DT
                        , NVL(HT.QT_VNN_DT,0) as QT_VNN_DT, NVL(HT.QT_VTT_TX,0) as QT_VTT_TX , NVL(HT.QT_VNN_TX,0) as QT_VNN_TX

                        FROM
                        (
                        SELECT A.MA_CHUONG AS MA_CHUONG, A.TEN_CHUONG, A.MA_DVQHNS, A.TEN_DVQHNS, A.MA_CTMTQG, A.TEN_CTMTQG
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_QP ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CDT_QP
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_AN ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CDT_AN
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_GDDT ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CDT_GDDT
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_KHCN ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CDT_KHCN
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_YT ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CDT_YT
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_VHTT ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CDT_VHTT
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_PTTH ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CDT_PTTH
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_TDTT ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CDT_TDTT
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_BVMT ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CDT_BVMT
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_KT ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CDT_KT
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_QLNN ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CDT_QLNN
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_BDXH ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CDT_BDXH
                        ,NVL(SUM (CASE WHEN ('|| CT_CDT_KHAC ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CDT_KHAC

                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CDT_QP ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CDT_QP
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CDT_AN ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CDT_AN
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CDT_GDDT ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CDT_GDDT
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CDT_KHCN ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CDT_KHCN
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CDT_YT ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CDT_YT
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CDT_VHTT ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CDT_VHTT
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CDT_PTTH ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CDT_PTTH
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CDT_TDTT ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CDT_TDTT
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CDT_BVMT ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CDT_BVMT
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CDT_KT ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CDT_KT
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CDT_QLNN ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CDT_QLNN
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CDT_BDXH ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CDT_BDXH
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CDT_KHAC ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CDT_KHAC

                        ,NVL(SUM (CASE WHEN ('|| CT_CTX_QP ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CTX_QP
                        ,NVL(SUM (CASE WHEN ('|| CT_CTX_AN ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CTX_AN
                        ,NVL(SUM (CASE WHEN ('|| CT_CTX_GDDT ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CTX_GDDT
                        ,NVL(SUM (CASE WHEN ('|| CT_CTX_KHCN ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CTX_KHCN
                        ,NVL(SUM (CASE WHEN ('|| CT_CTX_YT ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CTX_YT
                        ,NVL(SUM (CASE WHEN ('|| CT_CTX_VHTT ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CTX_VHTT
                        ,NVL(SUM (CASE WHEN ('|| CT_CTX_PTTH ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CTX_PTTH
                        ,NVL(SUM (CASE WHEN ('|| CT_CTX_TDTT ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CTX_TDTT
                        ,NVL(SUM (CASE WHEN ('|| CT_CTX_BVMT ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CTX_BVMT
                        ,NVL(SUM (CASE WHEN ('|| CT_CTX_KT ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CTX_KT
                        ,NVL(SUM (CASE WHEN ('|| CT_CTX_QLNN ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CTX_QLNN
                        ,NVL(SUM (CASE WHEN ('|| CT_CTX_BDXH ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CTX_BDXH
                        ,NVL(SUM (CASE WHEN ('|| CT_CTX_KHAC ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CTX_KHAC

                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CTX_QP ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CTX_QP
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CTX_AN ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CTX_AN
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CTX_GDDT ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CTX_GDDT
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CTX_KHCN ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CTX_KHCN
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CTX_YT ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CTX_YT
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CTX_VHTT ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CTX_VHTT
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CTX_PTTH ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CTX_PTTH
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CTX_TDTT ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CTX_TDTT
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CTX_BVMT ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CTX_BVMT
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CTX_KT ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CTX_KT
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CTX_QLNN ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CTX_QLNN
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CTX_BDXH ||')   THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CTX_BDXH
                        ,NVL(SUM (CASE WHEN ('|| CT_DT_CTX_KHAC ||')     THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_DT_CTX_KHAC

                        ,NVL(SUM (CASE WHEN ('|| CT_CTMTCDT ||')    THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CTMTCDT
                        ,NVL(SUM (CASE WHEN ('|| CT_CTMTCTX ||')        THEN A.GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END),0) AS CT_CTMTCTX
                        ,sum(0) AS CT_DT_CTMTCDT
                        ,sum(0) AS CT_DT_CTMTCTX
                        ,sum(0) AS QT_VTT_DT
                        ,sum(0) AS QT_VNN_DT
                        ,sum(0) AS QT_VTT_TX
                        ,sum(0) AS QT_VNN_TX
                        FROM BM68_TT343 A
                        WHERE A.NGAY_HIEU_LUC >= TO_DATE ('''||to_char(TUNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')
                        AND A.NGAY_HIEU_LUC <= TO_DATE ('''||to_char(DENNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')     
                        and A.NGAY_KET_SO <=TO_DATE ('''||to_char(DENNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')
                        and A.NGAY_KET_SO >=TO_DATE ('''||to_char(TUNGAY_KS,'ddMMyyyy')||''', ''ddMMyyyy'')
                            AND NOT A.MA_CAP like ''1'' AND NOT A.MA_CHUONG LIKE ''000'' AND NOT A.MA_CTMTQG LIKE ''00000'' AND NOT A.MA_CTMTQG LIKE ''050%'' AND NOT A.MA_CTMTQG LIKE ''0027%'''
                            || TEMP
                            || P_CT
                        || ' GROUP BY A.MA_CHUONG,A.TEN_CHUONG, A.MA_DVQHNS, A.TEN_DVQHNS, A.MA_CTMTQG, A.TEN_CTMTQG
                        ) HT 

                        WHERE 1=1 ORDER BY HT.MA_CHUONG';
           


--DBMS_OUTPUT.put_line(QUERY_STR); 

BEGIN
EXECUTE IMMEDIATE QUERY_STR;

OPEN cur FOR QUERY_STR;
EXCEPTION
  WHEN NO_DATA_FOUND
  THEN
     DBMS_OUTPUT.put_line ('<your message>' || SQLERRM);
   WHEN OTHERS
   THEN
--    DBMS_OUTPUT.ENABLE(200000);
    DBMS_OUTPUT.ENABLE (buffer_size => NULL);
   DBMS_OUTPUT.put_line ('<your message>'  || SQLERRM); 
     --DBMS_OUTPUT.put_line (QUERY_STR  || SQLERRM); 

END;   
END PHA_BM68_TT343;