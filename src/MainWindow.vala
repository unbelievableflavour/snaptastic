using Granite.Widgets;

namespace Application {
public class MainWindow : Gtk.Window{

    private Settings settings = new Settings ("com.github.bartzaalberg.bookmark-manager");

    private StackManager stackManager = StackManager.get_instance();
    private HeaderBar headerBar = HeaderBar.get_instance();

    construct {
        if(settings.get_string ("sshname") == ""){
           settings.set_string ("sshname", Environment.get_user_name ());
        }
        if(settings.get_string ("terminalname") == ""){
           settings.set_string ("terminalname", "pantheon-terminal");
        }

        set_default_size(Constants.APPLICATION_WIDTH, Constants.APPLICATION_HEIGHT);
        set_titlebar (headerBar);

        stackManager.loadViews(this);

        stackManager.getStack().visible_child_name = "welcome-view";
        headerBar.searchEntry.grab_focus();
    }
}
}
