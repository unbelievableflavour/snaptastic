using Granite.Widgets;

namespace Application {
public class MainWindow : Gtk.Window {

    private StackManager stack_manager = StackManager.get_instance ();
    private FileManager file_manager = FileManager.get_instance ();
    private HeaderBar header_bar = HeaderBar.get_instance ();
    private CommandHandler command_handler = new CommandHandler ();
    private ResponseTranslator response_translator = new ResponseTranslator ();
    private SnapdURIHandler snapd_uri_handler = new SnapdURIHandler ();

    public MainWindow (Gtk.Application application) {
        Object (application: application,
                icon_name: Constants.APPLICATION_NAME,
                resizable: true,
                height_request: Constants.APPLICATION_HEIGHT,
                width_request: Constants.APPLICATION_WIDTH);
    }

    public void recheck () {
        if (file_manager.get_file () != null) {
            if (file_manager.get_file ().has_uri_scheme ("snap")) {
                install_from_url ();
            }

            if (file_manager.get_file ().has_uri_scheme ("file")) {
                install_from_file ();
            }
        }
    }

    construct {
        var style_context = get_style_context ();
        style_context.add_class (Gtk.STYLE_CLASS_VIEW);
        style_context.add_class ("rounded");

        set_titlebar (header_bar);

        stack_manager.load_views (this);

        stack_manager.get_stack ().visible_child_name = "welcome-view";
        recheck ();
        add_shortcuts ();
    }

    public void install_from_url () {
        var name_and_channel = file_manager.get_file ().get_uri ().replace ("snap://", "");

        if (name_and_channel.has_suffix ("/")) {
            name_and_channel = name_and_channel.substring (0, name_and_channel.last_index_of_char ('/'));
        }

        snapd_uri_handler.set_parameters_from_uri (name_and_channel);

        Package package = response_translator.get_package_by_name (snapd_uri_handler.get_uri_name ());

        if (package == null) {
            return;
        }

        if (snapd_uri_handler.get_uri_channel () != "") {
            package.set_version ("");
            package.set_channel (snapd_uri_handler.get_uri_channel ());
        }

        stack_manager.set_detail_package (package);
        stack_manager.get_stack ().visible_child_name = "detail-view";
    }

    public void install_from_file () {
        string path = file_manager.get_file ().get_uri ().replace ("file://", "");

        string name = command_handler.get_package_name_by_file_path (path);
        var package = response_translator.get_package_by_name (name);

        if (package == null) {
            return;
        }

        stack_manager.set_detail_package (package);
        stack_manager.get_stack ().visible_child_name = "detail-view";
    }

    private void add_shortcuts () {
        key_press_event.connect ((e) => {
            switch (e.keyval) {
                case Gdk.Key.u:
                  if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {
                    stack_manager.get_stack ().visible_child_name = "list-view";
                  }
                  break;
                case Gdk.Key.h:
                  if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {
                    stack_manager.get_stack ().visible_child_name = "welcome-view";
                  }
                  break;
                case Gdk.Key.q:
                  if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {
                    this.destroy ();
                  }
                  break;
            }

            return false;
        });
    }
}
}
