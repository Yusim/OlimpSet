using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.ComponentModel;

namespace OlimpSet
{
    /// <summary>
    /// Логика взаимодействия для FNewClipboard.xaml
    /// </summary>
    public partial class FNewClipboard : Window
    {
        public FNewClipboard()
        {
            InitializeComponent();
        }

        private vmFromClip Core { get { return (Box.Content as vmFromClip); } }

        public static TPers[] GetPersList(TSetting set)
        {
            FNewClipboard fm = new FNewClipboard();
            fm.Core.Parent = set;
            fm.Owner = App.Current.MainWindow;
            if (fm.ShowDialog() == true)
                return fm.Core.List;
            else
                return null;
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            DialogResult = true;
            Close();
        }
    }

    public class vmFromClip : TChangedClass, INotifyPropertyChanged
    {
        public vmFromClip()
        {
            List = new TPers[] { };
            ComLoadClip = new RelayCommand(DoComLoadClip);
        }

        public TSetting Parent { get; set; }
        public TPers[] List { get; private set; }

        public ICommand ComLoadClip { get; private set; }
        private void DoComLoadClip()
        {
            List<TPers> ls = new List<TPers>();
            if (Clipboard.ContainsText())
            {
                string Txt = Clipboard.GetText();
                Txt = Txt.Replace('\r', '\n');
                string[] lsTxt = Txt.Split('\n');
                foreach (string s in lsTxt)
                {
                    string[] fld = (s + "\t\t").Split('\t');
                    string fFio = Util.NormStr(fld[0]);
                    string fLvlSym = Util.NormStr(fld[1])+" ";
                    string fRem = Util.NormStr(fld[2]);
                    int n = 0;
                    while (char.IsDigit(fLvlSym[n])) n++;
                    int fLvl = (n == 0 ? 0 : int.Parse(fLvlSym.Substring(0, n)));
                    string fSym = "";
                    foreach (char c in Util.NormStr(fLvlSym.Substring(n)))
                        if (char.IsLetter(c))
                            fSym += c.ToString().ToLower();
                    if (fFio != "")
                        ls.Add(new TPers(Parent, fFio, fLvl, fSym, fRem));
                }
            }
            List = ls.ToArray();
            OnPropertyChanged();
        }
    }
}
