﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace SourceNotes.Data
{
    public partial class People
    {
        public People()
        {
            NotesToPerson = new HashSet<NotesToPerson>();
        }

        public int PeopleId { get; set; }
        public string PeopleName { get; set; }

        public virtual ICollection<NotesToPerson> NotesToPerson { get; set; }
    }
}