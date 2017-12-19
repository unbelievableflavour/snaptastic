using Granite.Widgets;

namespace Application {
public class ListBoxRow : Gtk.ListBoxRow {

    private Gtk.Image icon = new Gtk.Image.from_icon_name ("package", Gtk.IconSize.DND);
    private Gtk.Box vertical_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 6);
    private Bookmark bookmark;


    public bool isInstalled(Bookmark bookmark, Bookmark[] installedBookmarks){
        foreach (Bookmark installedBookmark in installedBookmarks) {
            if(bookmark.getName() == installedBookmark.getName()){
                return true;
            }
        }
        return false;
    }

    public bool isLatestVersion(Bookmark bookmark, Bookmark[] installedBookmarks){
        foreach (Bookmark installedBookmark in installedBookmarks) {
            if(bookmark.getName() == installedBookmark.getName()){
                if(bookmark.getVersion() == installedBookmark.getVersion()){
                    return true;
                }
            }
        }
        return false;
    }

    public Gtk.Label generateNameLabel(string name){
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

    public Gtk.Button generateUpdateButton(){
     
   var update_button = new Gtk.Button();
        update_button.set_label(_("Update"));
        update_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
        update_button.set_tooltip_text(_("Update this to latest version"));
        update_button.button_press_event.connect (() => {
            new Alert("Updating!", "not really...yet..");
            return true;
        });

        return update_button;
    }
}
}
