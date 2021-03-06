create or replace PROCEDURE "PHB_BIEU10TT344_SUMREPORT" 
(
  MACHUONG IN NVARCHAR2,
  NAMBC IN NUMBER,
  KYBC IN NUMBER,
  DSDVQHNS IN NVARCHAR2,
  CUR OUT SYS_REFCURSOR
)IS
P_QUERY VARCHAR2(32767);
BEGIN
    P_QUERY:='SELECT  CT.MA_CHUONG,CT.MA_MUC,CT.MA_TIEU_MUC,CT.DIEN_GIAI,
    SUM(CT.QUYET_TOAN) as QUYET_TOAN
    FROM PHB_BIEU10TT344 TH';
    P_QUERY:=P_QUERY||' INNER JOIN SYS_DVQHNS DVQHNS ON TH.MA_QHNS=DVQHNS.MA_DVQHNS 
    INNER JOIN PHB_BIEU10TT344_DETAIL CT ON CT.PHB_BIEU10TT344_REFID = TH.REFID';
    P_QUERY:=P_QUERY||' WHERE (TH.NAM_BC=CASE '||NAMBC||' WHEN -1 THEN TH.NAM_BC ELSE '||NAMBC||' END) 
    AND (TH.KY_BC=CASE '||KYBC||' WHEN -1 THEN TH.KY_BC ELSE '||KYBC||' END)';
    P_QUERY:=P_QUERY||' AND DVQHNS.TRANG_THAI=''A''';
    IF DSDVQHNS IS NOT NULL THEN
        P_QUERY:=P_QUERY||' AND TH.MA_QHNS IN('||DSDVQHNS||')';
    END IF;
    IF MACHUONG IS NOT NULL THEN
        P_QUERY:=P_QUERY||' AND TH.MA_CHUONG='''||MACHUONG||'''';
    END IF;
    P_QUERY:=P_QUERY||' GROUP BY CT.MA_CHUONG,CT.MA_MUC,CT.MA_TIEU_MUC,CT.DIEN_GIAI';
    P_QUERY:=P_QUERY||' ORDER BY CT.MA_CHUONG,CT.MA_MUC,CT.MA_TIEU_MUC';
    OPEN cur FOR P_QUERY;
END "PHB_BIEU10TT344_SUMREPORT";