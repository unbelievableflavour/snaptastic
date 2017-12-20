using Granite.Widgets;

namespace Application {
public class MainWindow : Gtk.Window{

    private StackManager stackManager = StackManager.get_instance();
    private HeaderBar headerBar = HeaderBar.get_instance();

    construct {
        set_default_size(Constants.APPLICATION_WIDTH, Constants.APPLICATION_HEIGHT);
        set_titlebar (headerBar);

        stackManager.loadViews(this);

        stackManager.getStack().visible_child_name = "welcome-view";
        headerBar.searchEntry.grab_focus();
    }
}
}
