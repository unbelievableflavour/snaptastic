using Granite.Widgets;

namespace Application {
public class WelcomeView : Gtk.ScrolledWindow {

    private StackManager stack_manager = StackManager.get_instance ();
    private CommandHandler command_handler = new CommandHandler ();
    private ResponseTranslator response_translator = new ResponseTranslator ();

    public WelcomeView () {
        var welcome_view = new Welcome (_("Install Some Snaps"), _("Click open to select a downloaded snap file"));
        welcome_view.append ("ubuntu-open", _("Open"), _("Browse to open a single snap file"));

        welcome_view.activated.connect ((option) => {
            switch (option) {
                case 0:
                    var path = get_file_path ();
                    if (path == "") {
                        break;
                    }

                    string name = command_handler.get_package_name_by_file_path (path);
                    var package = response_translator.get_package_by_name (name);

                    if (package == null) {
                        break;
                    }

                    stack_manager.set_detail_package (package);
                    stack_manager.get_stack ().visible_child_name = "detail-view";

                    break;
            }
        });
        this.add (welcome_view);
    }

    public string get_file_path () {

        // The FileChooserDialog:
        Gtk.FileChooserDialog chooser = new Gtk.FileChooserDialog (
                "Select your favorite file", null, Gtk.FileChooserAction.OPEN,
                "_Cancel",
                Gtk.ResponseType.CANCEL,
                "_Open",
                Gtk.ResponseType.ACCEPT);

        // Multiple files can be selected:
        chooser.select_multiple = false;

        // We are only interested in .snap files:
        Gtk.FileFilter filter = new Gtk.FileFilter ();
        chooser.set_filter (filter);
        filter.add_mime_type ("application/vnd.snap");

        // Add a preview widget:
        Gtk.Image preview_area = new Gtk.Image ();
        chooser.set_preview_widget (preview_area);
        chooser.update_preview.connect (() => {
            string uri = chooser.get_preview_uri ();
            // We only display local files:
            if (uri != null && uri.has_prefix ("file://") == true) {
                try {
                    Gdk.Pixbuf pixbuf = new Gdk.Pixbuf.from_file_at_scale (uri.substring (7), 150, 150, true);
                    preview_area.set_from_pixbuf (pixbuf);
                    preview_area.show ();
                } catch (Error e) {
                    preview_area.hide ();
                }
            } else {
                preview_area.hide ();
            }
        });

        string filePath = "";

        // Process response:
        if (chooser.run () == Gtk.ResponseType.ACCEPT) {
            SList<string> uris = chooser.get_uris ();

            foreach (unowned string uri in uris) {
                filePath = uri.replace ("file://", "");
            }
        }

        // Close the FileChooserDialog:
        chooser.close ();
        return filePath;
    }
}
}
