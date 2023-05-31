using Microsoft.EntityFrameworkCore;
using SourceNotes.Data;

namespace SourceNotes.Data
{
    public class PeopleService
    {
        private readonly SourceNotesContext _context;

        public PeopleService(SourceNotesContext context)
        {
            _context = context;
        }
        public List<People> getPeople()
        {
            return _context.People.ToList();

        }
    }
}
