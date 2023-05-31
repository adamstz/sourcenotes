using Microsoft.EntityFrameworkCore;
using SourceNotes.Data;

namespace SourceNotes.Data
{
    public class UsersToProjectsService
    {
        private readonly SourceNotesContext _context;
        private readonly ProjectServices _projectservices;
        public UsersToProjectsService(SourceNotesContext context, ProjectServices projectservices)
        {
            _context = context;
            _projectservices = projectservices;
        }
        public List<int> GetProjectIds(string email)
        {
            // Get all project IDs associated with the email
            var result =  _context.UsersToProjects
                           .Where(utp => utp.UserEmail == email)
                           .Select(utp => utp.ProjectId)
                           .ToList();
            return result;
        }

        public List<string> GetUsers(int projectId)
        {
            // Get all email associated with the project ID
            var result = _context.UsersToProjects
                           .Where(utp => utp.ProjectId == projectId)
                           .Select(utp => utp.UserEmail)
                           .ToList();
            return result;
        }

        public void AddUserToProject(string email, int projectId)
        {
            var userToProject = new UsersToProjects
            {
                UserEmail = email,
                ProjectId = projectId
            };

            _context.UsersToProjects.Add(userToProject);
            _context.SaveChanges();
        }

        public void RemoveUserFromProject(string email, int projectId)
        {
            var userToProject = _context.UsersToProjects.FirstOrDefault(utp => utp.UserEmail == email && utp.ProjectId == projectId);
            if (userToProject != null)
            {
                _context.UsersToProjects.Remove(userToProject);
                _context.SaveChanges();
            }
        }

    }
}