using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace SelfregiApp.Views
{
  /// <summary>
  /// Page2.xaml の相互作用ロジック
  /// </summary>
  public partial class Page2 : Page
  {
    public Page2()
    {
      InitializeComponent();
    }

    private void Button_Click(object sender, RoutedEventArgs e)
    {
      NavigationService.Navigate(new Uri("/Views/Page1.xaml", UriKind.Relative));
      NavigationService.RemoveBackEntry();
    }

    private void Button_Click_1(object sender, RoutedEventArgs e)
    {
      NavigationService.Navigate(new Uri("/Views/Page4.xaml", UriKind.Relative));
    }
  }
}
