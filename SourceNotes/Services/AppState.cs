using SourceNotes.Data;

namespace SourceNotes.Services {
    public class AppState {

        // Global variable indicating which project is selected
        public string selectedProject { get; set; }
        public int selectedProjectId { get; set; }

        // Note Service
        protected readonly SourceNotesContext _dbcontext;
        public AppState(SourceNotesContext _db) {
            _dbcontext = _db;
            selectedProjectId = _dbcontext.Project.ToList().First().ProjectId; // TODO: Change this later to be set to the user's first project
        }

        public bool Insertrec(Note n) {
            _dbcontext.Note.Add(n);
            _dbcontext.SaveChanges();
            return true;
        }
    }
}
