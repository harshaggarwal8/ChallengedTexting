using System;

using Xamarin.Forms;

namespace ChallengedTexting
{
    public class OutgoingViewCell : ContentPage
    {
        public OutgoingViewCell()
        {
            Content = new StackLayout
            {
                Children = {
                    new Label { Text = "Hello ContentPage" }
                }
            };
        }
    }
}

