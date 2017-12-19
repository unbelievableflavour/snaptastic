using Granite.Widgets;

namespace Application {
public class MainWindow : Gtk.Window{

    private Settings settings = new Settings ("com.github.bartzaalberg.bookmark-manager");

    private ListBox listBox = ListBox.get_instance();
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

        addShortcuts();
    }

    private void addShortcuts(){
        key_press_event.connect ((e) => {
            switch (e.keyval) {
                case Gdk.Key.l:
                  if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {
                    stackManager.getStack().visible_child_name = "list-view";
                    headerBar.showReturnButton(false);
                  }
                  break;
                case Gdk.Key.f:
                  if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {
                    headerBar.searchEntry.grab_focus();
                  }
                  break;
            }

            return false;
        });
    }
}
}
