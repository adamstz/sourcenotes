using Microsoft.EntityFrameworkCore;
using SourceNotes.Data;

namespace SourceNotes.Data
{
    public class NoteServices
    {
        private readonly SourceNotesContext _context;
        
        public NoteServices(SourceNotesContext context)
        {
            _context = context;
        }
        public List<Note> getNotes()
        {
            return _context.Note.ToList();

        }
    }
}
