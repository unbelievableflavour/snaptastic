using Granite.Widgets;

namespace Application {
public class ListBoxRow : Gtk.ListBoxRow {

    StackManager stackManager = StackManager.get_instance();

    private const int PROGRESS_BAR_HEIGHT = 5;
    private Settings settings = new Settings ("com.github.bartzaalberg.bookmark-manager");
    private HeaderBar headerBar = HeaderBar.get_instance();

    private Gtk.Image start_image = new Gtk.Image.from_icon_name ("media-playback-start-symbolic", Gtk.IconSize.SMALL_TOOLBAR);
    private Gtk.Image delete_image = new Gtk.Image.from_icon_name ("edit-delete-symbolic", Gtk.IconSize.SMALL_TOOLBAR);

    private Gtk.Image icon = new Gtk.Image.from_icon_name ("package", Gtk.IconSize.DND);
    private Gtk.Box vertical_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 6);
    private Bookmark bookmark;

    public ListBoxRow (Bookmark bookmark){

        this.bookmark = bookmark;

        var name_label = generateNameLabel(bookmark);
        var summary_label = generateSummaryLabel(bookmark.getDeveloper());
        var start_button = generateStartButton();
        var delete_button = generateDeleteButton();

        vertical_box.add (name_label);
        vertical_box.add (summary_label);

        var bookmark_row = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
        bookmark_row.margin = 12;
        bookmark_row.add(icon);
        bookmark_row.add (vertical_box);
        bookmark_row.pack_end (start_button, false, false);
        bookmark_row.pack_end (delete_button, false, false);

        this.add (bookmark_row);
    }

    public Gtk.Label generateNameLabel(Bookmark bookmark){
        var name = bookmark.getName() + " (" + bookmark.getVersion() + ")";
       
        var name_label = new Gtk.Label ("<b>%s</b>".printf (name));
        name_label.use_markup = true;
        name_label.halign = Gtk.Align.START;

        return name_label;
    }

    public Gtk.Label generateSummaryLabel(string developer){
        var summary_label = new Gtk.Label (developer);
        summary_label.halign = Gtk.Align.START;

        return summary_label;
    }

    public Gtk.Button generateStartButton(){
        var start_button = new Gtk.Button();
        start_button.set_label(_("Install"));
        start_button.set_tooltip_text(_("Install this application"));
        start_button.button_press_event.connect (() => {
            string result;
	        string error;
	        int status;

            try {
                Process.spawn_command_line_sync ("snap install " + bookmark.getName(),
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

        return start_button;
    }

    public Gtk.Button generateDeleteButton(){
        var delete_button = new Gtk.Button();
        delete_button.set_label(_("Uninstall"));
        delete_button.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
        delete_button.set_tooltip_text(_("Uninstall this application"));
        delete_button.button_press_event.connect (() => {
            new DeleteConfirm(bookmark);
            return true;
        });

        return delete_button;
    }
}
}
