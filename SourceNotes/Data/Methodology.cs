﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace SourceNotes.Data
{
    public partial class Methodology
    {
        public int MethodologyId { get; set; }
        public string MethodologyText { get; set; }
        public DateTime MethodologyUpdate { get; set; }
        public int MethodologyProjectId { get; set; }
        public byte[] SsmaTimeStamp { get; set; }

        public virtual Project MethodologyProject { get; set; }
    }
}