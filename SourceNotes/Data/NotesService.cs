using Microsoft.EntityFrameworkCore;
using System.Linq;
using Microsoft.Data.SqlClient;
namespace SourceNotes.Data
{
    public class NotesService
    {
        //session
        private readonly SourceNotesContext _context;

        public NotesService(SourceNotesContext context)
        {
            _context = context;
        }
        public List<Note> GetNotesByProjectIdsAsync(List<int> projectIds, string email)
        {
            return _context.Note.Where(n => projectIds.Contains(n.NoteProjectId) && n.NoteUserAuthor == email).ToList();
        }
        public List<Note> GetNotesByEmail( string email)
        {
            return _context.Note.Where(n => n.NoteUserAuthor == email).ToList();
        }
        public List<Note> GetNotesByEmail(string email, int projectId) {
            return _context.Note.Where(n => n.NoteUserAuthor == email)
                .Where(n => n.NoteProjectId == projectId)
                .ToList();
        }

        public Sources getSource(Note n) {
            return _context.Sources.Where(x => x.SourceSourceId == n.NoteSourceId).First();
        }
        public Project getProject(Note n) {
            return _context.Project.Where(x => x.ProjectId == n.NoteProjectId).First();
        }
    }
}