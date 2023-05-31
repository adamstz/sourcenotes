using Microsoft.EntityFrameworkCore;
using SourceNotes.Data;
using System.Configuration;
using static Microsoft.Extensions.Logging.EventSource.LoggingEventSource;

namespace SourceNotes.Data {
    public class ProjectServices {
        private readonly SourceNotesContext _context;

        public ProjectServices(SourceNotesContext context) {
            _context = context;
        }
        public List<Project> getProjects() {
            return _context.Project.ToList();
        }
        public List<Project> getProjects(string username) {
            return (from project in _context.Project
                    from usersToProject in _context.UsersToProjects
                    where project.ProjectId == usersToProject.ProjectId
                    where username == usersToProject.UserEmail
                    select project).ToList();
        }
        public void updateProject(Project p) {
            _context.Project.Update(p);
            _context.SaveChanges();
        }
        public List<AspNetUsers> getUsers() {
            return _context.AspNetUsers.ToList();
        }
        public List<AspNetUsers> getUsers(int projectId) {
            return (from user in _context.AspNetUsers
                    from usersToProject in _context.UsersToProjects
                    where usersToProject.ProjectId == projectId
                    where usersToProject.UserEmail == user.Email
                    select user).ToList();
        }
        public List<Note> getNotes() {
            return _context.Note.ToList();
        }

        public List<Note> getNotes(int projectId) {
            return _context.Note.Where(n => n.NoteProjectId == projectId).ToList();
        }

        public List<Note> getNotes(int projectId, string selectedContent) {
            return _context.Note.Where(n => n.NoteProjectId == projectId)
                .Where(n => n.NoteText.ToUpper().Contains((selectedContent + "").ToUpper()))
                .ToList();
        }
        public List<Note> getNotes(int projectId, string selectedContent, string selectedPerson, string selectedKeyword) {
            return getNotes(projectId, selectedContent);
        }

        public void addNote(Note n) {
            if (_context.Note.Contains(n)) {
                _context.Note.Update(n);
            } else {
                _context.Note.Add(n);
            }
            _context.SaveChanges();
        }

        public void deleteNote(Note n) {
            foreach (NotesToPerson x in _context.NotesToPerson.Where(x => x.NotesId == n.NoteId)) {
                _context.NotesToPerson.Remove(x);
            }
            foreach (NotesToKeyword x in _context.NotesToKeyword.Where(x => x.NotesId == n.NoteId)) {
                _context.NotesToKeyword.Remove(x);
            }
            foreach (Comment x in _context.Comment.Where(x => x.CommentNotesId == n.NoteId)) {
                _context.Comment.Remove(x);
            }
            _context.Note.Remove(n);
            _context.SaveChanges();
        }

        //Sources
        public List<Sources> getSources() {
            return _context.Sources.ToList();
        }

        public Sources getSource(Note n) {
            return _context.Sources.Where(x => x.SourceSourceId == n.NoteSourceId).First();
        }

        public void renameSource(Sources s, string newName) {
            s.SourceTextDetails = newName;
            _context.Sources.Update(s);
            _context.SaveChanges();
        }
        public void deleteSource(Sources s) {
            // TODO -- only allow sources to be deleted when they are not being used by any sources, i.e.
            // if (!_context.Note.Where(n => n.NoteSourceId == s.SourceSourceId).Any) {
            // I wasn't sure how I wanted this to work for the user's view when deleting multiple sources,
            // so this method is not being used yet.
            _context.Sources.Remove(s);
            _context.SaveChanges();
        }

        public int addSource(string str, Note n) {
            var s = _context.Sources.Where(x => x.SourceTextDetails == str);
            if (s.Any()) {
                return s.First().SourceSourceId;
            } else {
                Sources source = new Sources { SourceTextDetails = str };
                _context.Sources.Add(source);
                _context.SaveChanges();
                return source.SourceSourceId;
            }
        }
        public bool mergeSources(Sources mergeSource, List<Sources> otherSources) {
            foreach (Sources s in otherSources) {
                foreach (Note x in _context.Note.Where(x => x.NoteSourceId == s.SourceSourceId)) {
                    x.NoteSourceId = mergeSource.SourceSourceId;
                    _context.Note.Update(x);
                }
                _context.Sources.Remove(s);
            }
            try {
                _context.SaveChanges();
            } catch (Exception e) {
                return false;
            }
            return true;
        }
        // Keywords
        public List<Keyword> getKeywords() {
            return _context.Keyword.ToList();
        }
        public List<Keyword> getKeywords(Note n) {
            return (from keyword in _context.Keyword
                    from notesToKeyword in _context.NotesToKeyword
                    where keyword.KeywordId == notesToKeyword.KeywordId
                    where n.NoteId == notesToKeyword.NotesId
                    select keyword).ToList();
        }
        public void renameKeyword(Keyword k, string newName) {
            k.KeywordName = newName;
            _context.Keyword.Update(k);
            _context.SaveChanges();
        }
        public void deleteKeyword(Keyword k) {
            foreach (NotesToKeyword x in _context.NotesToKeyword.Where(x => x.KeywordId == k.KeywordId)) {
                _context.NotesToKeyword.Remove(x);
            }
            _context.Keyword.Remove(k);
            _context.SaveChanges();
        }
        public bool mergeKeywords(Keyword mergeKeyword, List<Keyword> otherKeywords) {
            foreach (Keyword k in otherKeywords) {
                foreach (NotesToKeyword x in _context.NotesToKeyword.Where(x => x.KeywordId == k.KeywordId)) {
                    x.KeywordId = mergeKeyword.KeywordId;
                    _context.NotesToKeyword.Update(x);
                }
                _context.Keyword.Remove(k);
            }
            try {
                _context.SaveChanges();
            } catch (Exception e) {
                return false;
            }
            return true;
        }

        // NotesToKeyword
        //public void addNotesToKeyword(Note n, Keyword k) {
        //    NotesToKeyword ntk = new NotesToKeyword { NotesId = n.NoteId, KeywordId = k.KeywordId };
        //    _context.NotesToKeyword.Add(ntk);
        //    _context.SaveChanges();
        //}
        public void addNotesToKeyword(Note n, String keywordId) {
            if (keywordId != "") {
                List<NotesToKeyword> ntkList = _context.NotesToKeyword.Where(x => x.NotesId == n.NoteId).ToList();
                // If this note has a keyword already, edit that existing keyword (this code only makes sense when notes are only allowed one keyword).
                if (ntkList.Count > 0) {
                    NotesToKeyword ntk = ntkList.First();
                    ntk.KeywordId = Int32.Parse(keywordId);
                    _context.NotesToKeyword.Update(ntk);
                } else {
                    NotesToKeyword ntk = new NotesToKeyword { NotesId = n.NoteId, KeywordId = Int32.Parse(keywordId) };
                    _context.NotesToKeyword.Add(ntk);
                }
            }
            _context.SaveChanges();
            //}
        }

        // NotesToPerson
        //public void addNotesToPerson(Note n, People p) {
        //    NotesToPerson ntp = new NotesToPerson { NotesId = n.NoteId, PersonId = p.PeopleId };
        //    _context.NotesToPerson.Add(ntp);
        //    _context.SaveChanges();
        //}
        public void addNotesToPerson(Note n, String personId) {
            if (personId != "") {
                List<NotesToPerson> ntpList = _context.NotesToPerson.Where(x => x.NotesId == n.NoteId).ToList();
                // If this note has a person already, edit that existing person (this code only makes sense when notes are only allowed one person).
                if (ntpList.Count > 0) {
                    NotesToPerson ntp = ntpList.First();
                    ntp.PersonId = Int32.Parse(personId);
                    _context.NotesToPerson.Update(ntp);
                } else {
                    if (personId != "") {
                        NotesToPerson ntp = new NotesToPerson { NotesId = n.NoteId, PersonId = Int32.Parse(personId) };
                        _context.NotesToPerson.Add(ntp);
                    }
                }
            }
            _context.SaveChanges();
            //}
        }

        // People
        public List<People> getPeople() {
            return _context.People.ToList();
        }
        public List<People> getPeople(Note n) {
            return (from person in _context.People
                    from notesToPerson in _context.NotesToPerson
                    where person.PeopleId == notesToPerson.PersonId
                    where n.NoteId == notesToPerson.NotesId
                    select person).ToList();
        }
        public void renamePerson(People p, string newName) {
            p.PeopleName = newName;
            _context.People.Update(p);
            _context.SaveChanges();
        }
        public void deletePerson(People p) {
            foreach (NotesToPerson x in _context.NotesToPerson.Where(x => x.PersonId == p.PeopleId)) {
                _context.NotesToPerson.Remove(x);
            }
            _context.People.Remove(p);
            _context.SaveChanges();
        }

        public bool mergePeople(People mergePerson, List<People> otherPeople) {
            foreach (People p in otherPeople) {
                foreach (NotesToPerson x in _context.NotesToPerson.Where(x => x.PersonId == p.PeopleId)) {
                    x.PersonId = mergePerson.PeopleId;
                    _context.NotesToPerson.Update(x);
                }
                _context.People.Remove(p);
            }
            try {
                _context.SaveChanges();
            } catch (Exception e) {
                return false;
            }
            return true;
        }

    }
}