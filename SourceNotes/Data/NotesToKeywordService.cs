using Microsoft.EntityFrameworkCore;
using SourceNotes.Data;

namespace SourceNotes.Data
{
    public class NotesToKeywordService
    {
        private readonly SourceNotesContext _context;

        public NotesToKeywordService(SourceNotesContext context)
        {
            _context = context;
        }
        public List<NotesToKeyword> getNotesToKeywords()
        {
            return _context.NotesToKeyword.ToList();

        }
    }
}