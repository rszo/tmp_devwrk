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
  /// Page1.xaml の相互作用ロジック
  /// </summary>
  public partial class Page1 : Page
  {
    public Page1()
    {
      InitializeComponent();
    }

    private void Button_Click(object sender, RoutedEventArgs e)
    {
      SystemCommands.CloseWindow(Window.GetWindow(this));
    }

    private void Button_Click_1(object sender, RoutedEventArgs e)
    {
      // Create a pack URI
      Uri uri = new("/Views/Page2.xaml", UriKind.Relative);

      // Get the navigation service that was used to
      // navigate to this page, and navigate to
      // AnotherPage.xaml
      NavigationService.Navigate(uri);
    }
  }
}
