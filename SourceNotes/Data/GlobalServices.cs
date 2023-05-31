
using Microsoft.EntityFrameworkCore;
using System.Linq;
using Microsoft.Data.SqlClient;
namespace SourceNotes.Data
{
    public class GlobalServices
    {
        //session
        private SourceNotesContext _context;
        private  KeywordService _keywordsService;
        private  NoteServices _noteServices;
        private  ProjectServices _projectServices;
        private NotesToKeywordService _notesToKeywordService;
        private NotesToPersonService _notesToPersonService;
        private PeopleService _peopleService;

        public GlobalServices(SourceNotesContext context, KeywordService keyword, NoteServices note, ProjectServices projectservices, NotesToKeywordService notestokeyword, NotesToPersonService notestoperson, PeopleService peopleservice)
        {
            _context = context;
            _keywordsService = keyword;
            _noteServices = note;
            _projectServices = projectservices;
            _notesToKeywordService = notestokeyword;
            _notesToPersonService = notestoperson;
            _peopleService = peopleservice;

        }

        public List<dynamic> GetKeywordFrequencyByProjectId(int projectId)
        {
            List<Keyword> keywords = _keywordsService.getKeywords();
            List<Note> notes = _noteServices.getNotes();
            List<Project> projects = _projectServices.getProjects();
            List<NotesToKeyword> notestokeywords = _notesToKeywordService.getNotesToKeywords();

            //int projectId = 1; // replace with the ID of the project you want to retrieve the keyword frequency for

            var results = (
                from project in projects
                join note in notes on project.ProjectId equals note.NoteProjectId
                join noteToKeyword in notestokeywords on note.NoteId equals noteToKeyword.NotesId
                join keyword in keywords on noteToKeyword.KeywordId equals keyword.KeywordId
                where project.ProjectId == projectId
                group keyword by keyword.KeywordName into keywordGroup
                select new
                {
                    Keyword = keywordGroup.Key,
                    Frequency = keywordGroup.Count()
                }
            ).ToList<dynamic>();
            
            return results;

        }

        public List<dynamic> GetPersonFrequencyByProjectId(int projectId)
        {
            List<People> people = _peopleService.getPeople();
            List<Note> notes = _noteServices.getNotes();
            List<Project> projects = _projectServices.getProjects();
            List<NotesToPerson> notestopeople = _notesToPersonService.getNotesToPerson();

           //int projectId = 1; // replace with the ID of the project you want to retrieve the keyword frequency for

            var results = (
                from project in projects
                join note in notes on project.ProjectId equals note.NoteProjectId
                join noteToPerson in notestopeople on note.NoteId equals noteToPerson.NotesId
                join person in people on noteToPerson.PersonId equals person.PeopleId
                where project.ProjectId == projectId
                group people by person.PeopleName into peopleGroup
                select new
                {
                    Person = peopleGroup.Key,
                    Frequency = peopleGroup.Count()
                }
            ).ToList<dynamic>();

            return results;

        }

    }
}