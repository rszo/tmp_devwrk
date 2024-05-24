using System;
using System.Collections.Generic;
using System.ComponentModel;
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
using System.Windows.Threading;

namespace SelfregiApp.Views
{
  /// <summary>
  /// Page8.xaml の相互作用ロジック
  /// </summary>
  public partial class Page8 : Page
  {
    private DispatcherTimer _timer;

    private EventHandler _handler;

    private NavigatingCancelEventHandler _leaveHandler;

    public Page8()
    {
      InitializeComponent();

      Loaded += Page_Loaded;

      _timer = new DispatcherTimer
      {
        Interval = new TimeSpan(0, 0, 3)
      };

      _handler = (sender, e) =>
      {
        NavigationService.Navigate(new Uri("/Views/Page9.xaml", UriKind.Relative));
        _timer.Tick -= _handler;
      };

      _timer.Tick += _handler;

      _timer.Start();
    }

    private void Page_Loaded(object sender, RoutedEventArgs e)
    {
      _leaveHandler = (sender, e) =>
      {
        _timer?.Stop();
        NavigationService.Navigating -= _leaveHandler;
      };

      NavigationService.Navigating += _leaveHandler;
    }

    private void Button_Click(object sender, RoutedEventArgs e)
    {
      NavigationService.Navigate(new Uri("/Views/Page1.xaml", UriKind.Relative));
      NavigationService.RemoveBackEntry();
    }

    private void Button_Click_1(object sender, RoutedEventArgs e)
    {
      NavigationService.GoBack();
    }
  }
}
