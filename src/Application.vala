using Granite.Widgets;

namespace Application {
public class App:Granite.Application{
   
    public static string[] supported_mimetypes;

    private FileManager fileManager = FileManager.get_instance();
    private static string? link = null;

    construct {
        flags |= ApplicationFlags.HANDLES_OPEN;
        application_id = Constants.APPLICATION_ID;
        program_name = Constants.APP_NAME;
        app_years = Constants.APP_YEARS;
        exec_name = Constants.EXEC_NAME;
        app_launcher = Constants.DESKTOP_NAME;
        build_version = Constants.VERSION;
        app_icon = Constants.ICON;
        main_url = Constants.MAIN_URL;
        bug_url = Constants.BUG_URL;

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
   
    public override void activate() {
        weak Gtk.IconTheme default_theme = Gtk.IconTheme.get_default ();
        default_theme.add_resource_path ("/com/github/bartzaalberg/snaptastic");

        var provider = new Gtk.CssProvider ();
        provider.load_from_resource ("/com/github/bartzaalberg/snaptastic/application.css");
        Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);
       
        var window = new MainWindow ();
        window.destroy.connect (Gtk.main_quit);
        window.show_all();
    }

    public override void open (File[] files, string hint) {
        var file = files[0];
        if (file == null) {
            return;
        }
        string uri = file.get_uri ();

        fileManager.setFilePath(uri);
        activate ();
	}

    public static void main(string[] args) {
        new App().run(args);
        Gtk.main();
    }
}
}
