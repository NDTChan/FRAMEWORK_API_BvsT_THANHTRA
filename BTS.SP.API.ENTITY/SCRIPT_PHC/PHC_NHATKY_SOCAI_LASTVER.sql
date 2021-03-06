﻿create or replace PROCEDURE PHC_PRC_NHATKY_SOCAI (P_CONGTHUC IN VARCHAR2,P_TUNGAY_HL IN DATE, P_DENNGAY_HL IN DATE,P_USER_NAME IN VARCHAR2, CUR_RESULT OUT SYS_REFCURSOR) AS 
    QUERY_STR  VARCHAR2(32767); 
    P_SQL_INSERT VARCHAR2(32767);
    P_WHERE VARCHAR2(32767);
    P_CT VARCHAR2(32767);
    QUERY_SELECT VARCHAR2(500); 
    QUERY_INSERT VARCHAR2(32767); 
    QUERY_UPDATE VARCHAR2(5000); 
    QUERY_INITIALIZE VARCHAR2(32767);
    QUERY_TRUNCATE VARCHAR2(32767);
    QUERRY_UPDATE_TON VARCHAR2(3000);
BEGIN
            QUERY_INSERT := '';
            QUERY_TRUNCATE := 'DELETE PHC_TEMP_NHATKY_SOCAI WHERE USER_NAME = '''||P_USER_NAME||'''';
            EXECUTE IMMEDIATE QUERY_TRUNCATE;
            IF(P_CONGTHUC IS NULL) THEN P_CT:= '1=1 AND ';
            ELSE P_CT := P_CONGTHUC;
            END IF;
            P_WHERE:= P_CT || ' NGAY_HT >= TO_DATE ('''||to_char(P_TUNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')' ||  ' AND NGAY_HT <= TO_DATE ('''||to_char(P_DENNGAY_HL,'ddMMyyyy')||''', ''ddMMyyyy'')'; 
            QUERY_INSERT := 'INSERT INTO PHC_TEMP_NHATKY_SOCAI(THANG,NGAY_HT,NGAY_CT,SO_CHUNGTU,MA_CHUNGTU,SO_CHUNGTU_DETAIL,DIENGIAI,SODU_DAUKY_NO,SODU_DAUKY_CO,SO_PHATSINH_NO,SO_PHATSINH_CO,SODU_CUOIKY_NO,SODU_CUOIKY_CO,LUYKE_NO,LUYKE_CO,USER_NAME)
            SELECT (SELECT TO_CHAR(TO_DATE(a.NGAY_HT, ''DD-MM-YYYY''), ''MM'') FROM DUAL) AS THANG,a.NGAY_HT,a.NGAY_CT,a.SO_CHUNGTU,a.MA_CHUNGTU,
            a.SO_CHUNGTU_DETAIL,a.DIENGIAI,0 AS SODU_DAUKY_NO,0 AS SODU_DAUKY_CO,0 AS SO_PHATSINH_NO,0 AS SO_PHATSINH_CO,0 AS SODU_CUOIKY_NO,0 AS SODU_CUOIKY_CO,0 AS LUYKE_NO,0 AS LUYKE_CO,'''||P_USER_NAME||''' AS USER_NAME
            FROM V_PHC_TH_CHUNGTU a WHERE '||P_WHERE||'
            GROUP BY a.NGAY_HT,a.NGAY_CT,a.SO_CHUNGTU,a.MA_CHUNGTU,a.SO_CHUNGTU_DETAIL,a.DIENGIAI
            ORDER BY a.NGAY_HT,a.SO_CHUNGTU';
            EXECUTE IMMEDIATE QUERY_INSERT;
            QUERY_UPDATE := 'UPDATE PHC_TEMP_NHATKY_SOCAI b SET b.TAIKHOAN_NO = (SELECT a.TAIKHOAN FROM V_PHC_TH_CHUNGTU a WHERE a.LOAI = ''N'' AND TO_DATE(a.NGAY_HT,''DD-MM-YY'') = TO_DATE(b.NGAY_HT,''DD-MM-YY'') AND a.SO_CHUNGTU = b.SO_CHUNGTU AND a.SO_CHUNGTU_DETAIL = b.SO_CHUNGTU_DETAIL),
                                                                b.TAIKHOAN_CO = (SELECT a.TAIKHOAN FROM V_PHC_TH_CHUNGTU a WHERE a.LOAI = ''C'' AND TO_DATE(a.NGAY_HT,''DD-MM-YY'') = TO_DATE(b.NGAY_HT,''DD-MM-YY'') AND a.SO_CHUNGTU = b.SO_CHUNGTU AND a.SO_CHUNGTU_DETAIL = b.SO_CHUNGTU_DETAIL),
                                                                b.SOTIEN_NO =  (SELECT a.SOTIEN FROM V_PHC_TH_CHUNGTU a WHERE a.LOAI = ''N'' AND TO_DATE(a.NGAY_HT,''DD-MM-YY'') = TO_DATE(b.NGAY_HT,''DD-MM-YY'') AND a.SO_CHUNGTU = b.SO_CHUNGTU AND a.SO_CHUNGTU_DETAIL = b.SO_CHUNGTU_DETAIL),
                                                                b.SOTIEN_CO =  (SELECT a.SOTIEN FROM V_PHC_TH_CHUNGTU a WHERE a.LOAI = ''C'' AND TO_DATE(a.NGAY_HT,''DD-MM-YY'') = TO_DATE(b.NGAY_HT,''DD-MM-YY'') AND a.SO_CHUNGTU = b.SO_CHUNGTU AND a.SO_CHUNGTU_DETAIL = b.SO_CHUNGTU_DETAIL)';                              
            EXECUTE IMMEDIATE QUERY_UPDATE;
            BEGIN                         
--                DECLARE
--                    CURSOR_TEMP_SODU   SYS_REFCURSOR;
--                    R_DATA PHC_TEMP_SODU%ROWTYPE;
--                BEGIN
--                    FOR TEMP IN (SELECT TAIKHOAN_NO,TAIKHOAN_CO,THANG FROM PHC_TEMP_NHATKY_SOCAI GROUP BY TAIKHOAN_NO,TAIKHOAN_CO,THANG)
--                    LOOP
--                         IF TEMP.TAIKHOAN_NO IS NOT NULL OR TEMP.TAIKHOAN_NO <> '' THEN
--                            CURSOR_TEMP_SODU := FCN_GENERAL_SODU_CUOITHANG(''||TEMP.TAIKHOAN_NO||'',TEMP.THANG,''||P_USER_NAME||'');
--                             FETCH CURSOR_TEMP_SODU INTO R_DATA;
--                                EXIT WHEN CURSOR_TEMP_SODU%NOTFOUND;
--                                    QUERRY_UPDATE_TON := 'UPDATE PHC_TEMP_NHATKY_SOCAI SET SODU_DAUKY_NO = '||R_DATA.SODU_DAUKY_NO||',SO_PHATSINH_NO = '||R_DATA.SO_PHATSINH_NO||',
--                                    SODU_CUOIKY_NO = '||R_DATA.SODU_CUOIKY_NO||',LUYKE_NO = '||R_DATA.LUYKE_NO||'
--                                    WHERE THANG = '||TEMP.THANG||' AND USER_NAME = '''||P_USER_NAME||''' AND TAIKHOAN_NO = '''||TEMP.TAIKHOAN_NO||''' AND TAIKHOAN_CO = '''||TEMP.TAIKHOAN_CO||'''  AND ROWNUM = 1' ;
--                                    EXECUTE IMMEDIATE QUERRY_UPDATE_TON;
--                                DBMS_OUTPUT.put_line ('QUERRY_UPDATE_TON:' || QUERRY_UPDATE_TON);
--                        END IF;
--                    END LOOP;
--                    CLOSE CURSOR_TEMP_SODU;
--                END;

                --DISITINCT ACCOUNT
                --SELECT TAIKHOAN_NO FROM PHC_TEMP_NHATKY_SOCAI WHERE TAIKHOAN_NO IS NOT NULL GROUP BY TAIKHOAN_NO UNION ALL SELECT TAIKHOAN_CO  FROM PHC_TEMP_NHATKY_SOCAI WHERE TAIKHOAN_CO IS NOT NULL GROUP BY TAIKHOAN_CO;

                QUERY_SELECT := 'SELECT * FROM PHC_TEMP_NHATKY_SOCAI WHERE USER_NAME = '''||P_USER_NAME||'''   ';
                DBMS_OUTPUT.put_line ('QUERY_SELECT:' || QUERY_SELECT);
                OPEN CUR_RESULT FOR QUERY_SELECT;
                EXCEPTION
                   WHEN NO_DATA_FOUND
                   THEN
                      DBMS_OUTPUT.put_line ('<your message>' || SQLERRM);
                   WHEN OTHERS
                   THEN
                      DBMS_OUTPUT.put_line ('ERROR'  || SQLERRM);    
            END;
END PHC_PRC_NHATKY_SOCAI;