create or replace procedure PHA_HCSN_MAU_02(P_CONGTHUC VARCHAR2, NAM_HL VARCHAR2, DONVI_TIEN number, cur OUT SYS_REFCURSOR) as
   QUERY_STR  VARCHAR2(32767); 
   P_CT VARCHAR2(32767);   
   P_SQL_INSERT VARCHAR2(32767);
   
   MA_TKTN_TUCHU VARCHAR2(50);
   MA_TKTN_KHONG_TUCHU VARCHAR2(50);
   MA_TKTN_PHANBO VARCHAR2(50);
   MA_CAPMLNS_PHANBO VARCHAR2(50);
   MA_LDT VARCHAR2(50);
   MA_CTMTQG VARCHAR2(50);
   
   ATTRIBUTE8_1 VARCHAR2(50);
   ATTRIBUTE8_2 VARCHAR2(50);
   ATTRIBUTE8_3 VARCHAR2(50);
   ATTRIBUTE8_6 VARCHAR2(50);
   
   MA_NGUON_NSNN_12 VARCHAR2(50);
   MA_NGUON_NSNN_13 VARCHAR2(50);
   MA_NGUON_NSNN_14 VARCHAR2(50);
   MA_NGUON_NSNN_16 VARCHAR2(50);
   MA_NGUON_NSNN_21 VARCHAR2(50);
   
   TUNGAY_HL  VARCHAR(10);
   DENNGAY_HL VARCHAR(10);    

    BEGIN
        MA_TKTN_TUCHU := '''9523''';
        MA_TKTN_KHONG_TUCHU := '''9527''';
        MA_CTMTQG := '''00000''';
        ATTRIBUTE8_1 := '''01''';
        ATTRIBUTE8_2 := '''02''';
        ATTRIBUTE8_3 := '''03''';
        ATTRIBUTE8_6 := '''06''';
        
        MA_NGUON_NSNN_12 := '12';
        MA_NGUON_NSNN_13 := '13';
        MA_NGUON_NSNN_14 := '14';
        MA_NGUON_NSNN_16 := '16';
        MA_NGUON_NSNN_21 := '21';
    
    IF TRIM(P_CONGTHUC) IS NOT NULL THEN 
        select STC_PA_SYS.FNC_CONVERT_FORMULA_HCSN(P_CONGTHUC) INTO P_CT from dual;
        P_SQL_INSERT:= ' '||P_SQL_INSERT ||' and '||P_CT;
        END IF;

   QUERY_STR:='select  A.MA_CHUONG AS MA_CHUONG,A.MA_DVQHNS AS MA_DVQHNS, B.TEN_DVQHNS AS TEN_DVQHNS,A.MA_NVC, A.MA_LOAI, A.MA_NGANHKT as MA_KHOAN,
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_13||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_6||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_NAMTRUOC_TC13,
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_14||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_6||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_NAMTRUOC_TC14,
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_16||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_6||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_NAMTRUOC_TC16,
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_21||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_6||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_NAMTRUOC_TC21,
            
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_KHONG_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_12||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_6||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_NAMTRUOC_KTC12,
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_KHONG_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_14||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_6||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_NAMTRUOC_KTC14,
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_KHONG_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_16||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_6||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_NAMTRUOC_KTC16,
            
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_13||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_1||' AND MA_CTMTQG LIKE '||MA_CTMTQG||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_DAUNAM_TC13,
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_14||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_1||' AND MA_CTMTQG LIKE '||MA_CTMTQG||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_DAUNAM_TC14,
            
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_KHONG_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_12||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_1||' AND MA_CTMTQG LIKE '||MA_CTMTQG||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_DAUNAM_KTC12,
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_KHONG_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_14||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_1||' AND MA_CTMTQG LIKE '||MA_CTMTQG||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_DAUNAM_KTC14,
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_KHONG_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_16||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_1||' AND MA_CTMTQG LIKE '||MA_CTMTQG||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_DAUNAM_KTC16,
            
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_KHONG_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_12||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_1||' AND NOT MA_CTMTQG LIKE '||MA_CTMTQG||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS MTQG,
            
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_13||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_2||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_BOSUNG_TC13,
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_14||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_2||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_BOSUNG_TC14,
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_16||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_2||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_BOSUNG_TC16,
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_21||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_2||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_BOSUNG_TC21,
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_KHONG_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_12||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_2||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_BOSUNG_KTC12,
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_KHONG_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_14||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_2||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_BOSUNG_KTC14,
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_KHONG_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_16||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_2||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_BOSUNG_KTC16,
            
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_13||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_3||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_DIEUCHINH_TC13,
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_14||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_3||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_DIEUCHINH_TC14,
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_16||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_3||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_DIEUCHINH_TC16,
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_21||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_3||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_DIEUCHINH_TC21,
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_KHONG_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_12||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_3||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_DIEUCHINH_KTC12,
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_KHONG_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_14||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_3||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_DIEUCHINH_KTC14,
            SUM (CASE WHEN (A.MA_TKTN='||MA_TKTN_KHONG_TUCHU||' AND A.MA_NGUON_NSNN='||MA_NGUON_NSNN_16||' AND A.ATTRIBUTE8 like '||ATTRIBUTE8_3||') THEN GIA_TRI_HACH_TOAN/NVL('|| DONVI_TIEN ||',1) ELSE 0 END) AS DT_DIEUCHINH_KTC16
            
            from PHA_DUTOAN A
            left join SYS_DVQHNS B on B.MA_DVQHNS = A.MA_DVQHNS
            where A.MA_CAPMLNS = ''2'' and A.MA_NVC is not null and A.MA_DVQHNS like ''1%''
            AND A.NGAY_HIEU_LUC >= TO_DATE ('''|| '0101' || NAM_HL  ||''', ''ddMMyyyy'')
            AND A.NGAY_HIEU_LUC <= TO_DATE ('''|| '3112' || NAM_HL  ||''', ''ddMMyyyy'')'||P_SQL_INSERT||'
            group by A.MA_CHUONG,A.MA_DVQHNS, B.TEN_DVQHNS,A.MA_NVC, A.MA_LOAI, A.MA_NGANHKT
            order by A.MA_CHUONG';

   DBMS_OUTPUT.put_line (QUERY_STR);
BEGIN
EXECUTE IMMEDIATE QUERY_STR;
OPEN cur FOR QUERY_STR;
EXCEPTION
   WHEN NO_DATA_FOUND
   THEN
      DBMS_OUTPUT.put_line ('<your message>' || SQLERRM);
   WHEN OTHERS
   THEN
      DBMS_OUTPUT.put_line (QUERY_STR  || SQLERRM); 
END;    
END PHA_HCSN_MAU_02;