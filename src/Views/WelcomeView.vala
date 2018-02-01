using Granite.Widgets;

namespace Application {
public class WelcomeView : Gtk.ScrolledWindow {

    private StackManager stackManager = StackManager.get_instance();
    ListBox listBox = ListBox.get_instance();
    private CommandHandler commandHandler = new CommandHandler();

    public WelcomeView(){
        var welcome_view = new Welcome(_("Install Some Snaps"), _("Click open to select a downloaded snap file"));
        
		welcome_view.append("ubuntu-web-browser", _("Snapcraft"), _("Go the store on the web"));
		welcome_view.append("ubuntu-open", _("Open"), _("Browse to open a single snap file"));
        welcome_view.activated.connect ((option) => {
            switch (option) {		
                case 0:
					commandHandler.openStore();
                    break;
				case 1:
					var path = getFilePath();
					if(path != ""){
						stackManager.getStack().visible_child_name = "progress-view";
						commandHandler.installPackageFromFile(path);
					}
                    break;
            }
        });
        this.add(welcome_view);
    }

	public string getFilePath(){
		
		// The FileChooserDialog:
		Gtk.FileChooserDialog chooser = new Gtk.FileChooserDialog (
				"Select your favorite file", null, Gtk.FileChooserAction.OPEN,
				"_Cancel",
				Gtk.ResponseType.CANCEL,
				"_Open",
				Gtk.ResponseType.ACCEPT);

		// Multiple files can be selected:
		chooser.select_multiple = true;

		// We are only interested in jpegs:
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
					Gdk.Pixbuf pixbuf = new Gdk.Pixbuf.from_file_at_scale (uri.substring (7), 150, 	150, true);
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
				filePath = uri.replace("file://", "");
			}
		}

		// Close the FileChooserDialog:
		chooser.close ();
		return filePath;
	}
}
}
