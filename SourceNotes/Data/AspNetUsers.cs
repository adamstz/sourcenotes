﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace SourceNotes.Data
{
    public partial class AspNetUsers
    {
        public AspNetUsers()
        {
            Comment = new HashSet<Comment>();
            LbEntry = new HashSet<LbEntry>();
            Note = new HashSet<Note>();
            UsersToProjects = new HashSet<UsersToProjects>();
        }

        public string Id { get; set; }
        public string UserName { get; set; }
        public string NormalizedUserName { get; set; }
        public string Email { get; set; }
        public string NormalizedEmail { get; set; }
        public bool EmailConfirmed { get; set; }
        public string PasswordHash { get; set; }
        public string SecurityStamp { get; set; }
        public string ConcurrencyStamp { get; set; }
        public string PhoneNumber { get; set; }
        public bool PhoneNumberConfirmed { get; set; }
        public bool TwoFactorEnabled { get; set; }
        public DateTimeOffset? LockoutEnd { get; set; }
        public bool LockoutEnabled { get; set; }
        public int AccessFailedCount { get; set; }

        public virtual ICollection<Comment> Comment { get; set; }
        public virtual ICollection<LbEntry> LbEntry { get; set; }
        public virtual ICollection<Note> Note { get; set; }
        public virtual ICollection<UsersToProjects> UsersToProjects { get; set; }
    }
}