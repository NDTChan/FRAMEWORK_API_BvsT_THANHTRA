﻿using BTS.SP.API.ENTITY.Helper;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BTS.SP.API.ENTITY.Models.Dm.PHC
{
    [Table("DM_TINHCHATNGUON")]
    public class DM_TINHCHATNGUON : DataInfoEntity
    {
        [Column("MA")]
        [StringLength(20)]
        [ExportExcel("Mã ")]
        public string MA { get; set; }

        [Column("TEN")]
        [StringLength(250)]
        [ExportExcel("Tên")]
        public string TEN { get; set; }

        [Column("TEN_RUTGON")]
        [StringLength(250)]
        [ExportExcel("Tên rút gọn")]
        public string TEN_RUTGON { get; set; }

        [Column("NHOM_CHA")]
        [StringLength(1)]
        public string NHOM_CHA { get; set; }

        [Column("MA_CHA")]
        [StringLength(250)]
        [ExportExcel("Mã cha")]
        public string MA_CHA { get; set; }

        [Column("BAC")]
        [ExportExcel("Bậc")]
        public Nullable<int> BAC { get; set; }

        [Column("CHITIET")]
        public Nullable<int> CHITIET { get; set; }

        [Column("NGAY_HL")]
        public DateTime NGAY_HL { get; set; }

        [Column("NGAY_PS")]
        public Nullable<DateTime> NGAY_PS { get; set; }

        [Column("NGAY_SD")]
        public Nullable<DateTime> NGAY_SD { get; set; }

        [Column("USER_NAME")]
        [StringLength(20)]
        public string USER_NAME { get; set; }

        [Column("TRANG_THAI")]
        [StringLength(1)]
        public string TRANG_THAI { get; set; }

    }
}