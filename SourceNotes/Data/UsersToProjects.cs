﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace SourceNotes.Data
{
    public partial class UsersToProjects
    {
        public int UsersToProjectId { get; set; }
        public string UserEmail { get; set; }
        public int ProjectId { get; set; }

        public virtual Project Project { get; set; }
        public virtual AspNetUsers UserEmailNavigation { get; set; }
    }
}