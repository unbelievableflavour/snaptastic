using Granite.Widgets;

namespace Application {
public class App:Granite.Application {

    public static MainWindow window = null;
    public static string[] supported_mimetypes;
    public static GLib.Settings settings;

    private FileManager file_manager = FileManager.get_instance ();

    construct {
        flags |= ApplicationFlags.HANDLES_OPEN;
        application_id = Constants.APPLICATION_NAME;
        program_name = Constants.APPLICATION_NAME;
        settings = new GLib.Settings (Constants.APPLICATION_NAME);

        var app_info = new DesktopAppInfo (Constants.DESKTOP_NAME);
        try {
            app_info.set_as_default_for_type ("application/vnd.snap");

            if (AppInfo.get_default_for_uri_scheme ("snap") == null) {
                app_info.set_as_default_for_type ("x-scheme-handler/snap");
            }
        } catch (Error e) {
            critical ("Unable to set default for the settings scheme: %s", e.message);
        }
    }

    public override void open (File[] files, string hint) {
        var file = files[0];
        if (file == null) {
            return;
        }

        file_manager.set_file (file);
        activate ();
    }

    protected override void activate () {
        new_window ();
    }

    public static int main (string[] args) {
        var app = new Application.App ();
        return app.run (args);
    }

    public void new_window () {
        var stack_manager = StackManager.get_instance ();

        if (window != null) {
            if (stack_manager.get_stack ().get_visible_child_name () == "progress-view") {
                window.present ();
                return;
            }

            window.recheck ();
            window.present ();
            return;
        }

        weak Gtk.IconTheme default_theme = Gtk.IconTheme.get_default ();
        default_theme.add_resource_path ("/com/github/bartzaalberg/snaptastic");

        var provider = new Gtk.CssProvider ();
        provider.load_from_resource ("/com/github/bartzaalberg/snaptastic/application.css");
        Gtk.StyleContext.add_provider_for_screen (
            Gdk.Screen.get_default (),
            provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        );

        window = new MainWindow (this);
        go_to_last_saved_position (window);
        go_to_last_saved_size (window);

        window.show_all ();
    }

    private void go_to_last_saved_position (MainWindow main_window) {
        int window_x, window_y;
        settings.get ("window-position", "(ii)", out window_x, out window_y);
        if (window_x != -1 || window_y != -1) {
            window.move (window_x, window_y);
        }
    }

    private void go_to_last_saved_size (MainWindow main_window) {
        var rect = Gtk.Allocation ();

        settings.get ("window-size", "(ii)", out rect.width, out rect.height);
        window.set_allocation (rect);

        if (settings.get_boolean ("window-maximized")) {
            window.maximize ();
        }
    }
}
}
