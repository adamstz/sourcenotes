using Microsoft.AspNetCore.Http.Extensions;
using Microsoft.EntityFrameworkCore;
using SourceNotes.Data;

namespace SourceNotes.Data
{
    public class LabBookServices
    {
        private readonly SourceNotesContext _context;


        public List<Note> getNotes()
        {
            return _context.Note.ToList();
        }

        public List<AspNetUsers> getUsers()
        {
            return _context.AspNetUsers.ToList();
        }


        public List<Project> getProjects()
        {
            return _context.Project.ToList();

        }


        public LabBookServices(SourceNotesContext context)
        {
            _context = context;
        }

        public List<LbEntry> getLbEntries()
        {
            return _context.LbEntry.ToList();
        }
        public List<LbEntry> getLbEntryId()
        {
            return _context.LbEntry.ToList();
        }
        public List<LbEntry> getLbEntryLabBookId()
        {
            return _context.LbEntry.ToList();
        }
        public List<LbEntry> getLbEntryUser()
        {
            return _context.LbEntry.ToList();
        }
        public List<LbEntry> getLbEntryDateTime()
        {
            return _context.LbEntry.ToList();
        }
        public List<LbEntry> getLbEntryText()
        {
            return _context.LbEntry.ToList();
        }




        public List<Note> getNotes(int projectId)
        {
            return _context.Note.Where(n => n.NoteProjectId == projectId).ToList();
        }

        public List<Note> getNotes(int projectId, string selectedContent)
        {
            return _context.Note.Where(n => n.NoteProjectId == projectId)
                .Where(n => n.NoteText.ToUpper().Contains((selectedContent + "").ToUpper()))
                .ToList();
        }



        public void addLbEntry(LbEntry l)
        {
            if (_context.LbEntry.Contains(l))
            {
                _context.LbEntry.Update(l);
            }
            else
            {
                _context.LbEntry.Add(l);
            }
            _context.SaveChanges();
        }
        public void DeleteEntry(LbEntry l)
        {

            _context.LbEntry.Remove(l);
            _context.SaveChanges();

        }

        public List<LbEntry> getLbEntry(int projectId)
        {
            return _context.LbEntry.Where(n => n.LabBookProjectId == projectId).ToList();
        }



    }
}