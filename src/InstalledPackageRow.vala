using Granite.Widgets;

namespace Application {
public class InstalledPackageRow : ListBoxRow {

    private Gtk.Image icon = new Gtk.Image.from_icon_name ("package", Gtk.IconSize.DND);
    private Gtk.Box vertical_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 6);
    private Bookmark bookmark;

    public InstalledPackageRow (Bookmark bookmark,Bookmark[] installedBookmarks){

        this.bookmark = bookmark;

        var name_label = generateNameLabel(bookmark.getName() + " (" + bookmark.getDeveloper() + ")");
        var summary_label = generateSummaryLabel(bookmark.getVersion());
        var delete_button = generateDeleteButton();
        var update_button = generateUpdateButton();

        vertical_box.add (name_label);
        vertical_box.add (summary_label);

        var bookmark_row = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
        bookmark_row.margin = 12;
        bookmark_row.add(icon);
        bookmark_row.add (vertical_box);
        

        if(isLatestVersion(bookmark, installedBookmarks)){
                bookmark_row.pack_end (delete_button, false, false);
            }else{
                bookmark_row.pack_end (update_button, false, false);
        }
        
        this.add (bookmark_row);
    }
}
}
