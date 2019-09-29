using System;
namespace ChallengedTexting.Models
{
    public class Note
    {
        public string Filename { get; set; }
        public string Text { get; set; }
        public DateTime Date { get; set; }

        public static implicit operator string(Note v)
        {
            throw new NotImplementedException();
        }
    }
}