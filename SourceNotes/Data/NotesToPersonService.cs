using Microsoft.EntityFrameworkCore;
using SourceNotes.Data;

namespace SourceNotes.Data
{
    public class NotesToPersonService
    {
        private readonly SourceNotesContext _context;

        public NotesToPersonService(SourceNotesContext context)
        {
            _context = context;
        }
        public List<NotesToPerson> getNotesToPerson()
        {
            return _context.NotesToPerson.ToList();

        }
    }
}