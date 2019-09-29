using System;
using System.IO;
using Xamarin.Forms;

namespace ChallengedTexting
{
    public partial class App : Application
    {
        public static string FolderPath { get; private set; }
        //public static string User = "Rendy";
        public App()
        {
            InitializeComponent();

            //MainPage = new MainPage();
            FolderPath = Path.Combine(Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData));
            MainPage = new NavigationPage(new NotesPage());
        }
        
        protected override void OnStart()
        {
            // Handle when your app starts
        }

        protected override void OnSleep()
        {
            // Handle when your app sleeps
        }

        protected override void OnResume()
        {
            // Handle when your app resumes
        }
        
    }
}
