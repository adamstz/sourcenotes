
using Microsoft.EntityFrameworkCore;
using System.Linq;
using Microsoft.Data.SqlClient;
namespace SourceNotes.Data
{
    public class CommentServices
    {
        //session
        private SourceNotesContext _context;
        

        public CommentServices(SourceNotesContext context)
        {
            _context = context;

        }
        public List<Comment> getComments(int noteID)
        {
            return _context.Comment.Where(m => m.CommentNotesId == noteID).ToList();
           
        }
        public void editComment(int noteID, string commentText)
        {
            // Get the comment with the specified note ID from the database
            Comment comment = _context.Comment.FirstOrDefault(c => c.CommentNotesId == noteID);

            if (comment != null)
            {
                // Update the comment's text property
                comment.CommentText = commentText;

                // Save the changes back to the database
                _context.SaveChanges();
            }
        }
        public void addComment(int noteId, string newCommentText, string loggedInUser)
        {
            // Create a new Comment instance with the provided information
            Comment newComment = new Comment
            {
                CommentNotesId = noteId,
                CommentText = newCommentText,
                CommentFromUser = loggedInUser,
                // Set other properties as needed, e.g. CommentCreateDate, etc.
            };

            // Add the new comment to the database
            _context.Comment.Add(newComment);

            // Save the changes back to the database
            _context.SaveChanges();
        }
    }
}