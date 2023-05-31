﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace SourceNotes.Data
{
    public partial class Project
    {
        public Project()
        {
            LbEntry = new HashSet<LbEntry>();
            Methodology = new HashSet<Methodology>();
            Note = new HashSet<Note>();
            UsersToProjects = new HashSet<UsersToProjects>();
        }

        public int ProjectId { get; set; }
        public string ProjectName { get; set; }
        public string ProjectShortName { get; set; }
        public string ProjectDescription { get; set; }
        public DateTime? ProjectDate { get; set; }
        public int? ProjectPublic { get; set; }
        public byte[] SsmaTimeStamp { get; set; }

        public virtual ICollection<LbEntry> LbEntry { get; set; }
        public virtual ICollection<Methodology> Methodology { get; set; }
        public virtual ICollection<Note> Note { get; set; }
        public virtual ICollection<UsersToProjects> UsersToProjects { get; set; }
    }
}