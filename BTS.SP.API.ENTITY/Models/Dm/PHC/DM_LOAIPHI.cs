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
    [Table("DM_LOAIPHI")]
    public class DM_LOAIPHI : DataInfoEntity
    {
        [Column("MA")]
        [StringLength(20)]
        [ExportExcel("Mã loại phí")]
        public string MA { get; set; }

        [Column("TEN")]
        [StringLength(500)]
        [ExportExcel("Tên loại phí")]
        public string TEN { get; set; }

        [Column("TEN_RUTGON")]
        [StringLength(250)]
        [ExportExcel("Tên rút gọn")]
        public string TEN_RUTGON { get; set; }

        [Column("NGAY_HL")]
        [ExportExcel("Ngày hiệu lực")]
        public DateTime NGAY_HL { get; set; }

        [Column("NGAY_PS")]
        public Nullable<DateTime> NGAY_PS { get; set; }

        [Column("NGAY_SD")]
        public Nullable<DateTime> NGAY_SD { get; set; }

        [Column("USER_NAME")]
        [StringLength(50)]
        public string USER_NAME { get; set; }

        [Column("TRANG_THAI")]
        [Description("Trạng thái sử dụng (A: Ðang sử dụng)")]
        [StringLength(1)]
        public string TRANG_THAI { get; set; }
    }
}