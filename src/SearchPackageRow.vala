using Granite.Widgets;

namespace Application {
public class SearchPackageRow : ListBoxRow {

    private Gtk.Image icon = new Gtk.Image.from_icon_name ("package", Gtk.IconSize.DND);
    private Gtk.Box vertical_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 6);
    private Bookmark bookmark;

    public SearchPackageRow (Bookmark bookmark,Bookmark[] installedBookmarks){

        this.bookmark = bookmark;

        var name_label = generateNameLabel(bookmark.getName() + " (" + bookmark.getDeveloper() + ")");
        var summary_label = generateSummaryLabel(bookmark.getSummary());
        var install_button = generateStartButton();
        var delete_button = generateDeleteButton();
        var update_button = generateUpdateButton();

        vertical_box.add (name_label);
        vertical_box.add (summary_label);

        var bookmark_row = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
        bookmark_row.margin = 12;
        bookmark_row.add(icon);
        bookmark_row.add (vertical_box);
        
        if(isInstalled(bookmark, installedBookmarks)){
            if(isLatestVersion(bookmark, installedBookmarks)){
                bookmark_row.pack_end (delete_button, false, false);
            }else{
                bookmark_row.pack_end (update_button, false, false);
            }
        }else{
            bookmark_row.pack_end (install_button, false, false);
        }
        
        this.add (bookmark_row);
    }

    public Gtk.Button generateStartButton(){
        var install_button = new Gtk.Button();
        install_button.set_label(_("Install"));
        install_button.set_tooltip_text(_("Install this application"));
        install_button.button_press_event.connect (() => {
            string result;
	        string error;
	        int status;

            var classic = "";
            if(bookmark.getNotes() == "classic"){
                classic = " --classic";
            }

            try {
                Process.spawn_command_line_sync ("snap install " + bookmark.getName() + classic,
									        out result,
									        out error,
									        out status);

                if(error != null && error != ""){
                    new Alert("An error occured",error);
                }

            } catch (SpawnError e) {
	            new Alert("An error occured", e.message);
            }
            return true;
        });

        return install_button;
    }
}
}
