﻿// <auto-generated> This file has been auto generated by EF Core Power Tools. </auto-generated>
#nullable disable
using System;
using System.Collections.Generic;

namespace SourceNotes.Data
{
    public partial class NotesToPerson
    {
        public int NotesToPersonId { get; set; }
        public int NotesId { get; set; }
        public int PersonId { get; set; }

        public virtual Note Notes { get; set; }
        public virtual People Person { get; set; }
    }
}