using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Input;
using System.Windows.Media;
using System.Xml;
using System.Xml.Xsl;
using Microsoft.Win32;

namespace OlimpSet
{
    internal static class Util
    {
        public static string NormStr(string s)
        {
            s = (s ?? "").Replace('\r', ' ').Replace('\n', ' ').Replace('\t', ' ');
            while (s.Contains("  ")) s = s.Replace("  ", " ");
            return s.Trim();
        }

        private static Color[] fColorList = new Color[] 
        { 
            Colors.LightGoldenrodYellow,
            Colors.LightGray,
            Colors.LightPink,
            Colors.LightGreen,
            Colors.Cyan,
            Colors.LightBlue,
            Colors.Violet,
            Colors.Yellow,
            Colors.Chartreuse,
            Colors.Aquamarine,
            Colors.Coral,
        };
        public static Color[] ColorList { get { return fColorList; } }

        public static string XmlTransform(XmlDocument Xml, string Xsl)
        {
            StringReader sr = new StringReader(Xsl);
            XmlReader xr = XmlReader.Create(sr);
            XslCompiledTransform tr = new XslCompiledTransform();
            tr.Load(xr);
            StringBuilder sb = new StringBuilder();
            XmlWriter res = XmlWriter.Create(sb, tr.OutputSettings);
            tr.Transform(Xml, res);
            return sb.ToString();
        }
    }

    public class TChangedClass
    {
        public event PropertyChangedEventHandler PropertyChanged;
        internal void OnPropertyChanged(string field)
        {
            if (PropertyChanged != null)
                PropertyChanged(this, new PropertyChangedEventArgs(field));
        }
        internal void OnPropertyChanged() { OnPropertyChanged(""); }
    }

    public class RelayCommand : ICommand
    {
        private readonly Action _handler;
        private bool _isEnabled = true;

        public RelayCommand(Action handler)
        {
            _handler = handler;
        }

        public bool IsEnabled
        {
            get { return _isEnabled; }
            set
            {
                if (value != _isEnabled)
                {
                    _isEnabled = value;
                    if (CanExecuteChanged != null)
                        CanExecuteChanged(this, EventArgs.Empty);
                }
            }
        }

        public bool CanExecute(object parameter)
        {
            return IsEnabled;
        }

        public event EventHandler CanExecuteChanged;

        public void Execute(object parameter)
        {
            _handler();
        }
    }

    public class TSetting : TChangedClass, INotifyPropertyChanged
    {
        public TSetting()
        {
            PersList = new TPers[] { };
            LevelList = new TLevel[] { };
            ComAddRoom = new RelayCommand(DoComAddRoom);
            ComDelRoom = new RelayCommand(DoComDelRoom);
            ComSave = new RelayCommand(DoComSave);
            ComLoad = new RelayCommand(DoComLoad);
            ComNew = new RelayCommand(DoComNew);
            ComAddPers = new RelayCommand(DoComAddPers);
            ComRepMap = new RelayCommand(DoComRepMap);
            ComRepList = new RelayCommand(DoComRepList);
            ComRepRoom= new RelayCommand(DoComRepRoom);
        }

        public TPers[] PersList { get; private set; }

        private List<TRoom> fRoomList = new List<TRoom>();
        public TRoom[] RoomList { get { return fRoomList.ToArray(); } }

        private TLevel fCurLevel = null;
        public TLevel CurLevel
        {
            get { return fCurLevel; }
            set
            {
                if ((value != fCurLevel)&&LevelList.Contains(value))
                {
                    fCurLevel = value;
                    OnPropertyChanged("CurLevel");
                    OnPropertyChanged("CurPersList");
                }
            }
        }

        public TLevel[] LevelList { get; private set; }

        public TPers[] CurPersList
        {
            get
            {
                return (from p in PersList where (p.Level == CurLevel.Level) && (p.Table == null) select p).ToArray();
            }
        }

        private TRoom fCurRoom = null;
        public TRoom CurRoom
        {
            get { return fCurRoom; }
            set
            {
                if ((value != fCurRoom) && (value != null) && (value.Parent==this))
                {
                    fCurRoom = value;
                    OnPropertyChanged("CurRoom");
                    OnPropertyChanged("IsEnableDelRoom");
                }
            }
        }

        public bool IsEmpty
        {
            get
            {
                return PersList.Length == 0;
            }
        }
        public bool IsNotEmpty { get { return !IsEmpty; } }

        private bool fIsChange = false;
        public bool IsChange
        {
            get { return fIsChange; }
            set
            {
                if (IsEmpty) value = false;
                if (value != fIsChange)
                {
                    fIsChange = value;
                    OnPropertyChanged("IsChange");
                }
            }
        }

        public bool IsEnableDelRoom 
        {
            get 
            {
                return ((fRoomList.Count > 1) && (CurRoom.CurPersCount == 0)); 
            }
        }

        public Color[] ColorList { get { return Util.ColorList; } }
        
        public ICommand ComAddRoom { get; private set; }
        public ICommand ComDelRoom { get; private set; }

        public ICommand ComSave { get; private set; }
        public ICommand ComLoad { get; private set; }
        public ICommand ComNew { get; private set; }

        public ICommand ComAddPers { get; private set; }

        public ICommand ComRepMap { get; private set; }
        public ICommand ComRepList { get; private set; }
        public ICommand ComRepRoom { get; private set; }

        private void DoComAddRoom()
        {
            TRoom room = new TRoom(this);
            fRoomList.Add(room);
            CurRoom = room;
            IsChange = true;
            OnPropertyChanged("RoomList");
            OnPropertyChanged("CurRoom");
            OnPropertyChanged("IsEnableDelRoom");
        }
        private void DoComDelRoom()
        {
            if (IsEnableDelRoom)
            {
                TRoom old = CurRoom;
                int n = fRoomList.IndexOf(old);
                CurRoom = (n == fRoomList.Count - 1 ? RoomList[n - 1] : RoomList[n + 1]);
                fRoomList.Remove(old);
                IsChange = true;
                OnPropertyChanged("RoomList");
                OnPropertyChanged("CurRoom");
                OnPropertyChanged("IsEnableDelRoom");
            }
        }
        
        private void DoComSave()
        {
            if (IsEmpty)
            {
                MessageBox.Show("Так ведь нет никого!");
                return;
            }
            SaveFileDialog dlg = new SaveFileDialog();
            dlg.Filter = "Файл рассадки (*.xml)|*.xml";
            dlg.DefaultExt = "xml";
            if (dlg.ShowDialog() == true)
                try { GetXml().Save(dlg.FileName); }
                catch (Exception ex) { MessageBox.Show(ex.Message); }
            IsChange = false;
        }
        private void DoComLoad()
        {
            if (IsChange && (MessageBox.Show("Текущая рассадка не сохранена. Продолжить?", "Вопрос", MessageBoxButton.YesNo) == MessageBoxResult.No)) return;
            OpenFileDialog dlg = new OpenFileDialog();
            dlg.Filter = "Файл рассадки (*.xml)|*.xml";
            if (dlg.ShowDialog() == true)
                try 
                {
                    XmlDocument xml = new XmlDocument();
                    xml.Load(dlg.FileName);
                    SetXml(xml);
                    IsChange = false;
                }
                catch (Exception ex) { MessageBox.Show(ex.Message); }
        }
        private void DoComNew()
        {
            if (IsChange && (MessageBox.Show("Текущая рассадка не сохранена. Продолжить?", "Вопрос", MessageBoxButton.YesNo) == MessageBoxResult.No)) return;
            PersList = new TPers[] { };
            LevelList = new TLevel[] { };
            fRoomList.Clear();
            fRoomList.Add(new TRoom(this));
            CurRoom = null;
            CurLevel = null;
            IsChange = false;
            OnPropertyChanged();
        }

        private void DoComAddPers()
        {           
            TPers[] ls = FNewClipboard.GetPersList(this);
            if (ls != null)
                AddPers(ls);
        }

        private void DoComRepMap()
        {
            SaveReport(Properties.Resources.RoomMap);
        }
        private void DoComRepList()
        {
            SaveReport(Properties.Resources.ListMap);
        }
        private void DoComRepRoom()
        {
            SaveReport(Properties.Resources.RoomList);
        }

        private void SaveReport(string xsl)
        {
            if (IsEmpty)
            {
                MessageBox.Show("Так ведь нет никого!");
                return;
            }
            SaveFileDialog dlg = new SaveFileDialog();
            dlg.Filter = "Документ Word (*.rtf)|*.rtf";
            dlg.DefaultExt = "rtf";
            if (dlg.ShowDialog() == true)
                try
                {
                    XmlDocument xml = GetXml();
                    string rtf = Util.XmlTransform(xml, xsl);
                    File.WriteAllText(dlg.FileName, rtf, Encoding.GetEncoding(1251));
                }
                catch (Exception ex) { MessageBox.Show(ex.Message); }
        }

        public void AddPers(IEnumerable<TPers> lsPers)
        {
            if (lsPers.Count() > 0)
            {
                List<TPers> newPers = new List<TPers>();
                newPers.AddRange(PersList);
                List<TLevel> newLevel = new List<TLevel>();
                newLevel.AddRange(LevelList);
                foreach (TPers p in lsPers)
                {
                    newPers.Add(p);
                    if((from x in newLevel where x.Level==p.Level select x).Count()==0)
                    {
                        TLevel lvl = new TLevel(this, p.Level);
                        lvl.Color = ColorList[p.Level % ColorList.Length];
                        newLevel.Add(lvl);
                    }
                }
                PersList = newPers.ToArray();
                LevelList = newLevel.ToArray();
                if (RoomList.Length == 0)
                {
                    fRoomList.Add(new TRoom(this));
                    CurRoom = RoomList[0];
                }
                if (CurLevel == null)
                    CurLevel = LevelList[0];
                IsChange = true;
                OnPropertyChanged();
            }
        }

        public XmlDocument GetXml()
        {
            XmlDocument xml = new XmlDocument();
            xml.AppendChild(xml.CreateXmlDeclaration("1.0", "windows-1251", null));
            XmlNode xRoot = xml.AppendChild(xml.CreateElement("OlimpSet"));
            xRoot.AppendChild(xml.CreateElement("Version")).InnerText = "1.0";
            #region PersList
            XmlNode xPersList = xRoot.AppendChild(xml.CreateElement("PersList"));
            for (int i = 0; i < PersList.Length; i++)
            {
                XmlNode xPers = xPersList.AppendChild(xml.CreateElement("Pers"));
                xPers.AppendChild(xml.CreateElement("Id")).InnerText = (i + 1).ToString();
                xPers.AppendChild(xml.CreateElement("Fio")).InnerText = PersList[i].Fio;
                xPers.AppendChild(xml.CreateElement("Level")).InnerText = PersList[i].Level.ToString();
                xPers.AppendChild(xml.CreateElement("Symbol")).InnerText = PersList[i].Symbol;
                xPers.AppendChild(xml.CreateElement("Rem")).InnerText = PersList[i].Rem;
            }
            #endregion
            #region ColorList
            XmlNode xColorList = xRoot.AppendChild(xml.CreateElement("ColorList"));
            foreach (TLevel lvl in LevelList)
            {
                XmlNode xColor = xColorList.AppendChild(xml.CreateElement("Color"));
                xColor.AppendChild(xml.CreateElement("Level")).InnerText = lvl.Level.ToString();
                xColor.AppendChild(xml.CreateElement("RGB")).InnerText = lvl.Color.ToString();
            }
            #endregion
            #region RoomList
            XmlNode xRoomList = xRoot.AppendChild(xml.CreateElement("RoomList"));
            foreach (TRoom rm in RoomList)
            {
                XmlNode xRoom = xRoomList.AppendChild(xml.CreateElement("Room"));
                xRoom.AppendChild(xml.CreateElement("NumRoom")).InnerText = rm.NumRoom;
                xRoom.AppendChild(xml.CreateElement("Boss")).InnerText = rm.Boss;
                #region TableList
                XmlNode xTableList = xRoom.AppendChild(xml.CreateElement("TableList"));
                for(int r=0;r<TRoom.RowCount;r++)
                    for (int c = 0; c < TRoom.ColCount; c++)
                    {
                        TTable tb = rm.TableList[r, c];
                        XmlNode xTable = xTableList.AppendChild(xml.CreateElement("Table"));
                        xTable.AppendChild(xml.CreateElement("Row")).InnerText = (r + 1).ToString();
                        xTable.AppendChild(xml.CreateElement("Col")).InnerText = (c + 1).ToString();
                        xTable.AppendChild(xml.CreateElement("Left")).InnerText = (tb.Left == null ? "0" : (tb.Left.Id + 1).ToString());
                        xTable.AppendChild(xml.CreateElement("Right")).InnerText = (tb.Right == null ? "0" : (tb.Right.Id + 1).ToString());
                    }
                #endregion
            }
            #endregion
            return xml;
        }
        public void SetXml(XmlDocument xml)
        {
            XmlNode xRoot = xml.SelectSingleNode("/OlimpSet");
            if (xRoot == null) throw new Exception("Не найден тег «/OlimpSet»");
            XmlNode xVersion = xRoot.SelectSingleNode("Version");
            if (xVersion == null) throw new Exception("Не найден тег «/OlimpSet/Version»");
            if (Util.NormStr(xVersion.InnerText) != "1.0") throw new Exception("Неизвестная версия");
            #region PersList
            XmlNode xPersList = xRoot.SelectSingleNode("PersList");
            if (xPersList == null) throw new Exception("Не найден тег «/OlimpSet/PersList»");
            List<TPers> lsPers = new List<TPers>();
            foreach (XmlNode xPers in xPersList.SelectNodes("Pers"))
            {
                XmlNode xFio = xPers.SelectSingleNode("Fio");
                if (xFio == null) throw new Exception("Не найден тег «.../Pers/Fio»");
                string Fio = Util.NormStr(xFio.InnerText);
                XmlNode xLevel = xPers.SelectSingleNode("Level");
                if (xLevel == null) throw new Exception("Не найден тег «.../Pers/Level»");
                int Level = int.Parse(Util.NormStr(xLevel.InnerText));
                XmlNode xSymbol = xPers.SelectSingleNode("Symbol");
                if (xSymbol == null) throw new Exception("Не найден тег «.../Pers/Symbol»");
                string Symbol = Util.NormStr(xSymbol.InnerText);
                XmlNode xRem = xPers.SelectSingleNode("Rem");
                if (xRem == null) throw new Exception("Не найден тег «.../Pers/Rem»");
                string Rem = Util.NormStr(xRem.InnerText);
                lsPers.Add(new TPers(this, Fio, Level, Symbol, Rem));
            }
            PersList = lsPers.ToArray();
            #endregion
            #region ColorList
            List<TLevel> lsLevel = new List<TLevel>();
            XmlNode xColorList = xRoot.SelectSingleNode("ColorList");
            if (xColorList == null) throw new Exception("Не найден тег «/OlimpSet/ColorList»");
            foreach (XmlNode xColor in xColorList.SelectNodes("Color"))
            {
                XmlNode xLevel = xColor.SelectSingleNode("Level");
                if (xLevel == null) throw new Exception("Не найден тег «.../Color/Level»");
                int Level = int.Parse(Util.NormStr(xLevel.InnerText));
                XmlNode xRGB = xColor.SelectSingleNode("RGB");
                if (xRGB == null) throw new Exception("Не найден тег «.../Pers/RGB»");
                Color Color = (Color)ColorConverter.ConvertFromString(Util.NormStr(xRGB.InnerText));
                TLevel lvl = new TLevel(this, Level);
                lvl.Color = Color;
                lsLevel.Add(lvl);
            }
            LevelList = (from x in lsLevel orderby x.Level select x).ToArray();
            #endregion
            #region RoomList
            fRoomList.Clear();
            XmlNode xRoomList = xRoot.SelectSingleNode("RoomList");
            if (RoomList == null) throw new Exception("Не найден тег «/OlimpSet/RoomList»");
            foreach (XmlNode xRoom in xRoomList.SelectNodes("Room"))
            {
                XmlNode xNumRoom = xRoom.SelectSingleNode("NumRoom");
                if (xNumRoom == null) throw new Exception("Не найден тег «.../Room/NumRoom»");
                string NumRoom = Util.NormStr(xNumRoom.InnerText);
                XmlNode xBoss = xRoom.SelectSingleNode("Boss");
                if (xBoss == null) throw new Exception("Не найден тег «.../Room/Boss»");
                string Boss = Util.NormStr(xBoss.InnerText);
                TRoom room = new TRoom(this);
                fRoomList.Add(room);
                room.NumRoom = NumRoom;
                room.Boss = Boss;
                #region TableList
                XmlNode xTableList = xRoom.SelectSingleNode("TableList");
                if (xTableList == null) throw new Exception("Не найден тег «.../Room/TableList»");
                foreach (XmlNode xTable in xTableList.SelectNodes("Table"))
                {
                    XmlNode xRow = xTable.SelectSingleNode("Row");
                    if (xRow == null) throw new Exception("Не найден тег «.../Table/Row»");
                    int Row = int.Parse(Util.NormStr(xRow.InnerText));
                    XmlNode xCol = xTable.SelectSingleNode("Col");
                    if (xCol == null) throw new Exception("Не найден тег «.../Table/Col»");
                    int Col = int.Parse(Util.NormStr(xCol.InnerText));
                    TTable tb = room.TableList[Row - 1, Col - 1];
                    XmlNode xLeft = xTable.SelectSingleNode("Left");
                    if (xLeft == null) throw new Exception("Не найден тег «.../Table/Left»");
                    int Left = int.Parse(Util.NormStr(xLeft.InnerText));
                    XmlNode xRight = xTable.SelectSingleNode("Right");
                    if (xRight == null) throw new Exception("Не найден тег «.../Table/Right»");
                    int Right = int.Parse(Util.NormStr(xRight.InnerText));
                    if (Left != 0) tb.Left = PersList[Left - 1];
                    if (Right != 0) tb.Right = PersList[Right - 1];
                }
                #endregion
            }
            #endregion
            CurRoom = RoomList[0];
            CurLevel = LevelList[0];
            OnPropertyChanged();
        }
    }

    public class TRoom : TChangedClass, INotifyPropertyChanged
    {
        public TRoom(TSetting parent)
        {
            Parent = parent;
            TableList = new TTable[RowCount, ColCount];
            for (int r = 0; r < RowCount; r++)
            {
                for (int c = 0; c < ColCount; c++)
                    TableList[r, c] = new TTable(this);
            }
        }

        public const int RowCount = 5;
        public const int ColCount = 3;

        public TSetting Parent { get; private set; }
        public TTable[,] TableList { get; private set; }
        public TTable this[int npp]
        {
            get
            {
                int r = npp / ColCount;
                int c = npp % ColCount;
                return TableList[r, c];
            }
        }

        private string fNumRoom = "бн";
        public string NumRoom
        {
            get { return fNumRoom; }
            set
            {
                value = Util.NormStr(value);
                if ((value != fNumRoom) && (value != ""))
                {
                    fNumRoom = value;
                    Parent.IsChange = true;
                    OnPropertyChanged("NumRoom");
                }
            }
        }

        private string fBoss = "";
        public string Boss
        {
            get { return fBoss; }
            set
            {
                value = Util.NormStr(value);
                if (value != fBoss)
                {
                    fBoss = value;
                    Parent.IsChange = true;
                    OnPropertyChanged("Boss");
                }
            }
        }

        public int MaxPersCount { get { return 2 * RowCount * ColCount; } }
        public int CurPersCount
        {
            get
            {
                int res = 0;
                foreach (TTable t in TableList)
                {
                    if (t.Left != null) res++;
                    if (t.Right != null) res++;
                }
                return res;
            }
        }
    }

    public class TTable : TChangedClass, INotifyPropertyChanged
    {
        public TTable(TRoom parent)
        {
            Parent = parent;
            ComSetLeft = new RelayCommand(DoComSetLeft);
            ComSetRight = new RelayCommand(DoComSetRight);
        }

        public TRoom Parent { get; private set; }

        private TPers fLeft = null;
        public TPers Left
        {
            get { return fLeft; }
            set
            {
                if ((value != fLeft) && ((value == null) || (value.Parent == Parent.Parent)))
                {
                    TPers old = Left;                    
                    RemovePers(value);
                    if (old != null) old.LevelLink.OnPropertyChanged("CurPersCount");
                    fLeft = value;
                    Parent.Parent.IsChange = true;
                    OnPropertyChanged("Left");
                    Parent.OnPropertyChanged("CurPersCount");
                    Parent.Parent.OnPropertyChanged("CurPersList");
                    Parent.Parent.OnPropertyChanged("IsEnableDelRoom");
                    if (value != null)
                    {
                        value.OnPropertyChanged("Table");
                        value.LevelLink.OnPropertyChanged("CurPersCount");
                    }
                }
            }
        }

        private TPers fRight = null;
        public TPers Right
        {
            get { return fRight; }
            set
            {
                if ((value != fRight) && ((value == null) || (value.Parent == Parent.Parent)))
                {
                    TPers old = Right;  
                    RemovePers(value);
                    if (old != null) old.LevelLink.OnPropertyChanged("CurPersCount");
                    fRight = value;
                    Parent.Parent.IsChange = true;
                    OnPropertyChanged("Right");
                    Parent.OnPropertyChanged("CurPersCount");
                    Parent.Parent.OnPropertyChanged("CurPersList");
                    Parent.Parent.OnPropertyChanged("IsEnableDelRoom");
                    if (value != null)
                    {
                        value.OnPropertyChanged("Table");
                        value.LevelLink.OnPropertyChanged("CurPersCount");
                    }
                }
            }
        }

        public int Row
        {
            get
            {
                for (int r = 0; r < TRoom.RowCount; r++)
                    for (int c = 0; c < TRoom.ColCount; c++)
                        if (Parent.TableList[r, c] == this)
                            return r;
                return -1;
            }
        }
        public int Col
        {
            get
            {
                for (int r = 0; r < TRoom.RowCount; r++)
                    for (int c = 0; c < TRoom.ColCount; c++)
                        if (Parent.TableList[r, c] == this)
                            return c;
                return -1;
            }
        }

        private void RemovePers(TPers p)
        {
            if (p == null) return;
            foreach(TRoom r in Parent.Parent.RoomList)
                foreach (TTable t in r.TableList)
                {
                    if (t.Left == p) t.Left = null;
                    if (t.Right == p) t.Right = null;
                }
        }

        public ICommand ComSetLeft { get; private set; }
        public ICommand ComSetRight { get; private set; }

        private void DoComSetLeft()
        {
            TPers[] ls = Parent.Parent.CurPersList;
            if (ls.Length != 0)
                Left = ls[0];
        }
        private void DoComSetRight()
        {
            TPers[] ls = Parent.Parent.CurPersList;
            if (ls.Length != 0)
                Right = ls[0];
        }
    }

    public class TPers : TChangedClass, INotifyPropertyChanged
    {
        public TPers(TSetting parent, string fio, int level, string symbol, string rem)
        {
            Parent = parent;
            Fio = fio;
            Level = level;
            Symbol = symbol;
            Rem = rem;
            ComRemove = new RelayCommand(DoComRemove);
        }

        public TSetting Parent { get; private set; }
        public string Fio { get; private set; }
        public int Level { get; private set; }
        public string Symbol { get; private set; }
        public string Rem { get; private set; }

        public int Id
        {
            get
            {
                for (int i = 0; i < Parent.PersList.Length; i++)
                    if (Parent.PersList[i] == this)
                        return i;
                return -1;
            }
        }

        public Color Color 
        {
            get { return LevelLink.Color; }
        }

        public TTable Table
        {
            get
            {
                foreach (TRoom r in Parent.RoomList)
                    foreach (TTable t in r.TableList)
                        if ((t.Left == this) || (t.Right == this))
                            return t;
                return null;
            }
        }

        public TLevel LevelLink
        {
            get { return (from x in Parent.LevelList where x.Level == Level select x).First(); }
        }

        public ICommand ComRemove { get; private set; }

        private void DoComRemove()
        {
            TTable tb = Table;
            if (tb != null)
            {
                if (tb.Left == this) tb.Left = null;
                if (tb.Right == this) tb.Right = null;
                LevelLink.OnPropertyChanged("CurPersCount");
            }
        }
    }

    public class TLevel : TChangedClass, INotifyPropertyChanged
    {
        public TLevel(TSetting parent, int level)
        {
            Parent = parent;
            Level = level;
        }
        public TSetting Parent { get; private set; }
        public int Level { get; private set; }

        private Color fColor = Colors.LightGoldenrodYellow;
        public Color Color
        {
            get { return fColor; }
            set
            {
                if (value != fColor)
                {
                    fColor = value;
                    OnPropertyChanged("Color");
                    foreach (TPers p in Parent.PersList)
                        if (p.Level == Level)
                        {
                            p.OnPropertyChanged("Color");
                        }
                    Parent.IsChange = true;
                }
            }
        }

        public int MaxPersCount
        {
            get { return (from p in Parent.PersList where p.Level == Level select p).Count(); }
        }
        public int CurPersCount
        {
            get { return (from p in Parent.PersList where (p.Level == Level) && (p.Table == null) select p).Count(); }
        }
    }
}
