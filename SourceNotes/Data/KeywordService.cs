// TODO: delete this file, since it's been combined with AppState.cs?
using Microsoft.EntityFrameworkCore;
using SourceNotes.Data;

namespace SourceNotes.Data {
    
    public class KeywordService {
        
        protected readonly SourceNotesContext _dbcontext;
        
        public KeywordService(SourceNotesContext _db) {
            _dbcontext = _db;
        }

        public bool DeleteKeyword(Keyword k) {
            _dbcontext.Keyword.Remove(k);
            _dbcontext.SaveChanges();
            return true;
        }

        public List<Keyword> getKeywords()
        {
            return _dbcontext.Keyword.ToList();

        }

    }

}
