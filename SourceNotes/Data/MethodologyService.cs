using Microsoft.EntityFrameworkCore;
using System.Linq;
using Microsoft.Data.SqlClient;
using Microsoft.CodeAnalysis;

namespace SourceNotes.Data
{
	public class MethodologyService
	{
        //session
		private readonly SourceNotesContext _context;

		public MethodologyService(SourceNotesContext context)
		{
			_context = context;
		}
		public List<Methodology> getMethodology(int projectID)
		{
            return _context.Methodology
        .Where(m => m.MethodologyProjectId == projectID)
        .ToList();

        }
        /*public async Task<List<Methodology>> GetMethodologyAsync(int projectId)
        {
            return await _context.Methodology.FromSqlRaw("exec getMethodology @ProjectID = {0}", projectId)
                                              .ToListAsync();
        }*/
        public void setMethodology(string text, int projectID)
        {
            
            _context.Methodology.Where(m => m.MethodologyProjectId == projectID).ExecuteUpdate(m => m.SetProperty(x => x.MethodologyText, x => text));
        }
        /*public async Task SetMethodologyAsync(string text, int projectId)
        {
            await _context.Methodology.Where(m => m.MethodologyProjectId == projectId)
                                       .ExecuteUpdateAsync(m => m.SetProperty(x => x.MethodologyText, text));
        }*/
       
    }
}
