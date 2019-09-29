using System;
using System.Collections.Generic;
using System.IO;
using Xamarin.Forms;
using ChallengedTexting.Models;
using System.Linq;

namespace ChallengedTexting
{
    public partial class NoteEntryPage : ContentPage
    {
        //static Note note = (Note)BindingContext;
        
        char[] letters = { ' ', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '1', '2', '3', '4', '5', '6', '7', '8', '9', '0' };
        //string[] morseLetters = { " ", ".___", "___...", "___.___.", "___..", ".", "..___.", "______.", "....", "..", "._________", "___.___", ".___. .", "___ ___", "___ .", "___ ___ ___", ". ___ ___ .", "___ ___ . ___", ". ___ .", ". . .", "_", ". . ___", ". . . ___", ". ___ ___", "___ . . ___", "___ . ___ ___", "___ ___ . .", ". ___ ___ ___ ___", ". . ___ ___ ___", ". . . ___ ___", ". . . . ___", ". . . . .", "___ . . . .", "___ ___ . . .", "___ ___ ___ . .", "___ ___ ___ ___ .", "___ ___ ___ ___ ___" };

        string[] morseLetters =
        {   " ",
            ".-",
            "-...",
            "-.-.",
            "-..",
            ".",
            "..-.",
            "--.",
            "....",
            "..",
            ".---",
            "-.-",
            ".-..",
            "--",
            "-.",
            "---",
            ".--.",
            "--.-",
            ".-.",
            "...",
            "-",
            "..-",
            "...-",
            ".--",
            "-..-",
            "-.--",
           "--.."
        };
        string textToChange = string.Empty;
        string newText = string.Empty;
        int i = 0;
        public NoteEntryPage()
        {
            InitializeComponent();
            InitialiseDictionary();
        }

        async void OnSaveButtonClicked(object sender, EventArgs e)
        {
            string note =string.Empty;
            //note = DecodeMorse(textToChange).ToString();

            //IEnumerable<string> note = DecodeMorse(textToChange);
            note = newText;
            var filename = Path.Combine(App.FolderPath, $"{Path.GetRandomFileName()}.notes.txt");
            if (string.IsNullOrWhiteSpace(filename))
            {
                // Save
                
                File.WriteAllText(filename, note);
            }
            else
            {
                // Update
                //var filename = Path.Combine(App.FolderPath, $"{Path.GetRandomFileName()}.notes.txt");
                File.WriteAllText(filename, note);
            }
            /*
            var note = (Note)BindingContext;
            //note = (ChallengedTexting.Models.Note)DecodeMorse(textToChange);
            note = (ChallengedTexting.Models.Note)DecodeMorse(textToChange);
            if (string.IsNullOrWhiteSpace(note.Filename))
            {
                // Save
                var filename = Path.Combine(App.FolderPath, $"{Path.GetRandomFileName()}.notes.txt");
                File.WriteAllText(filename, note.Text);
            }
            else
            {
                // Update
                File.WriteAllText(note.Filename, note.Text);
            }
            */
            await Navigation.PopAsync();
        }
        async void OnNextButtonClicked(object sender, EventArgs e)
        {
            int key = 0;
            for (int i = 0; i < morseLetters.Length; i++)
            {
                if (String.Equals(morseLetters[i], textToChange))
                {
                    key = i;
                    break;
                }
            }
            newText += letters[key].ToString();
            Console.WriteLine(newText);
            textToChange = string.Empty;

        }

        async void OnDeleteButtonClicked(object sender, EventArgs e)
        {
            var note = (Note)BindingContext;

            if (File.Exists(note.Filename))
            {
                File.Delete(note.Filename);
            }

            await Navigation.PopAsync();
        }
        async void OnPlayButtonClicked(object sender, EventArgs e)
        {
            await Navigation.PopAsync();
        }
        async void OnPress1ButtonClicked(object sender, EventArgs e)
        {
            //var note = (Note)BindingContext;
            if (i == 0)
            {
                Label_ControlSW.Text = "Enter Morse now";
                i = 1;
            }
            else
            {
                textToChange += ".";
                //note = DecodeMorse(textToChange).ToString();
                //Label_ControlSW.Text = note.ToString();

            }
        }
        async void OnPress2ButtonClicked(object sender, EventArgs e)
        {
           //var note = (Note)BindingContext;
            if (i == 0)
            {
                Label_ControlSW.Text = "Enter Morse now";
                i = 1;
            }
            else
            {
                textToChange += "-";
                //note = DecodeMorse(textToChange).ToString();
                //Label_ControlSW.Text = note.ToString();
            }
        }
        private static void OnEnterButtonClicked(string note)
        {

        }
        /// <summary>
        /// //////////
        /// </summary>
        static Dictionary<char, string> translator;
        static Dictionary<string, string> map;
        private static void InitialiseDictionary()
        {
            char dot = '.';
            char dash = '−';

            translator = new Dictionary<char, string>()
            {
                { 'a', string.Concat(dot, dash) },
                { 'b', string.Concat(dash, dot, dot, dot) },
                { 'c', string.Concat(dash, dot, dash, dot) },
                { 'd', string.Concat(dash, dot, dot) },
                { 'e', dot.ToString() },
                { 'f', string.Concat(dot, dot, dash, dot) },
                { 'g', string.Concat(dash, dash, dot) },
                { 'h', string.Concat(dot, dot, dot, dot) },
                { 'i', string.Concat(dot, dot) },
                { 'j', string.Concat(dot, dash, dash, dash) },
                { 'k', string.Concat(dash, dot, dash) },
                { 'l', string.Concat(dot, dash, dot, dot) },
                { 'm', string.Concat(dash, dash) },
                { 'n', string.Concat(dash, dot) },
                { 'o', string.Concat(dash, dash, dash) },
                { 'p', string.Concat(dot, dash, dash, dot) },
                { 'q', string.Concat(dash, dash, dot, dash) },
                { 'r', string.Concat(dot, dash, dot) },
                { 's', string.Concat(dot, dot, dot) },
                { 't', string.Concat(dash) },
                { 'u', string.Concat(dot, dot, dash) },
                { 'v', string.Concat(dot, dot, dot, dash) },
                { 'w', string.Concat(dot, dash, dash) },
                { 'x', string.Concat(dash, dot, dot, dash) },
                { 'y', string.Concat(dash, dot, dash, dash) },
                { 'z', string.Concat(dash, dash, dot, dot) },
                { '0', string.Concat(dash, dash, dash, dash, dash) },
                { '1', string.Concat(dot, dash, dash, dash, dash) },
                { '2', string.Concat(dot, dot, dash, dash, dash) },
                { '3', string.Concat(dot, dot, dot, dash, dash) },
                { '4', string.Concat(dot, dot, dot, dot, dash) },
                { '5', string.Concat(dot, dot, dot, dot, dot) },
                { '6', string.Concat(dash, dot, dot, dot, dot) },
                { '7', string.Concat(dash, dash, dot, dot, dot) },
                { '8', string.Concat(dash, dash, dash, dot, dot) },
                { '9', string.Concat(dash, dash, dash, dash, dot) }
            };

            map = new Dictionary<string, string>()
            {
            { ".-", "a" },
            { "-...", "b" },
            { "-.-.", "c" },
            { "-..", "d" },
            { ".", "e" },
            { "..-.", "f" },
            { "--.", "g" },
            { "....", "h" },
            { "..", "i" },
            { ".---", "j" },
            { "-.-", "k" },
            { ".-..", "l" },
            { "--", "m" },
            { "-.", "n" },
            { "---", "o" },
            { ".--.", "p" },
            { "--.-", "q" },
            { ".-.", "r" },
            { "...", "s" },
            { "-", "t" },
            { "..-", "u" },
            { "...-", "v" },
            { ".--", "x" },
            { "-..-", "y" },
            { "-.--", "z" },
            { "--..", " " }
            };
        }
        /*
        translator2 = new Dictionary<string, char>()
        {
            {string.Concat(dot, dash),'a'},
            {string.Concat(dash, dot, dot, dot),'b'},
            {string.Concat(dash, dot, dash, dot),'c'},
            {string.Concat(dash, dot, dot),'d'},
            {dot.ToString(),'e'},
            {string.Concat(dot, dot, dash, dot),'f'},
            {string.Concat(dash, dash, dot),'g'},
            {string.Concat(dot, dot, dot, dot),'h'},
            {string.Concat(dot, dot),'i'},
            {string.Concat(dot, dash, dash, dash),'j'},
            {string.Concat(dash, dot, dash),'k'},
            {string.Concat(dot, dash, dot, dot),'l'},
            {string.Concat(dash, dash),'m'},
            {string.Concat(dash, dot),'n'},
            {string.Concat(dash, dash, dash),'o'},
            {string.Concat(dot, dash, dash, dot),'p'},
            {string.Concat(dash, dash, dot, dash),'q'},
            {string.Concat(dot, dash, dot),'r'},
            {string.Concat(dot, dot, dot),'s'},
            {string.Concat(dash),'t'},
            {string.Concat(dot, dot, dash),'u'},
            {string.Concat(dot, dot, dot, dash),'v'},
            {string.Concat(dot, dash, dash),'w'},
            {string.Concat(dash, dot, dot, dash),'x'},
            {string.Concat(dash, dot, dash, dash),'y'},
            {string.Concat(dash, dash, dot, dot),'z'},
            {string.Concat(dash, dash, dash, dash, dash),'0'},
            {string.Concat(dot, dash, dash, dash, dash),'1'},
            {string.Concat(dot, dot, dash, dash, dash),'2'},
            {string.Concat(dot, dot, dot, dash, dash),'3'},
            {string.Concat(dot, dot, dot, dot, dash),'4'},
            {string.Concat(dot, dot, dot, dot, dot),'5'},
            {string.Concat(dash, dot, dot, dot, dot),'6'},
            {string.Concat(dash, dash, dot, dot, dot),'7'},
            {string.Concat(dash, dash, dash, dot, dot),'8'},
            {string.Concat(dash, dash, dash, dash, dot),'9'}
        };*/


        public static string getUserInput(string input)
        {
            input = input.ToLower();
            translate(input);
            return input;
        }
        public IEnumerable<string> DecodeMorse(string morse)
        {
            var letters =
                map
                    .Where(kvp => morse.StartsWith(kvp.Key))
                    .Select(kvp => new
                    {
                        letter = kvp.Value,
                        remainder = morse.Substring(kvp.Key.Length)
                    })
                    .ToArray();
            if (letters.Any())
            {
                var query =
                    from l in letters
                    from x in DecodeMorse(l.remainder)
                    select l.letter + x;

                Console.WriteLine("VIABLE STRING WAS RETURNED");
                return query.ToArray();


                //Console.WriteLine(query.ToArray());
            }
            else
            {
                Console.WriteLine("NNAHAH");
                //return new[] { "" };
                return new[] { "THIS WAS RETURNED" };
            }
        }

        private static string translate(string input)
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            foreach (char character in input)
            {
                if (translator.ContainsKey(character))
                {
                    sb.Append(translator[character] + " ");
                }
                else if (character == ' ')
                {
                    sb.Append("/ ");
                }
                else
                {
                    sb.Append(character + " ");
                }
            }
            return sb.ToString();
        }
    }
}

