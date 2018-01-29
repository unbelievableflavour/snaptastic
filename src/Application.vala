using Granite.Widgets;

namespace Application {
public class App:Granite.Application{
   
    public static string[] supported_mimetypes;

    private FileManager fileManager = FileManager.get_instance();

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
        app_info.set_as_default_for_type ("application/vnd.snap");
   }
   
    public override void activate() {
        var window = new MainWindow ();
        window.destroy.connect (Gtk.main_quit);
        window.show_all();
    }

    public override void open (File[] files, string hint) {
		foreach (File file in files) {
			string uri = file.get_uri ();
            fileManager.setFilePath(uri);
		}
        activate ();
	}

    public static void main(string[] args) {
        new App().run(args);
        Gtk.main();
    }
}
}
