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
  /// Page3.xaml の相互作用ロジック
  /// </summary>
  public partial class Page3 : Page
  {
    public Page3()
    {
      InitializeComponent();

      grid1.Visibility = Visibility.Visible;
      grid2.Visibility = Visibility.Collapsed;
    }

    private void Button_Click(object sender, RoutedEventArgs e)
    {
      NavigationService.Navigate(new Uri("/Views/Page1.xaml", UriKind.Relative));
    }

    private void Button_Click_1(object sender, RoutedEventArgs e)
    {
      NavigationService.Navigate(new Uri("/Views/Page2.xaml", UriKind.Relative));
    }

    private void Button_Click_2(object sender, RoutedEventArgs e)
    {
      grid1.Visibility = Visibility.Collapsed;
      grid2.Visibility = Visibility.Visible;
    }

    private void Button_Click_3(object sender, RoutedEventArgs e)
    {
      grid1.Visibility = Visibility.Collapsed;
      grid2.Visibility = Visibility.Visible;
    }

    private void Button_Click_4(object sender, RoutedEventArgs e)
    {
      grid1.Visibility = Visibility.Collapsed;
      grid2.Visibility = Visibility.Visible;
    }

    private void Button_Click_5(object sender, RoutedEventArgs e)
    {
      grid1.Visibility = Visibility.Collapsed;
      grid2.Visibility = Visibility.Visible;
    }

    private void Button_Click_6(object sender, RoutedEventArgs e)
    {
      grid1.Visibility = Visibility.Visible;
      grid2.Visibility = Visibility.Collapsed;
    }

    private void Button_Click_7(object sender, RoutedEventArgs e)
    {
      NavigationService.Navigate(new Uri("/Views/Page4.xaml", UriKind.Relative));
    }
  }
}
