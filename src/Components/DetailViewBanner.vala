using Granite.Widgets;

namespace Application {
public class DetailViewBanner : ListBoxRow {

    private Gtk.Image icon = new Gtk.Image.from_icon_name ("package", Gtk.IconSize.DND);
    private Gtk.Box vertical_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 30);
    private Package package;

    public DetailViewBanner (Package package,Package[] installedPackages){
        this.package = package;

        name_label = generateNameLabel(package.getName() + " (" + package.getDeveloper() + ")");

        var summary_label = generateSummaryLabel(package.getVersion());
        var delete_button = generateDeleteButton(package);
        var update_button = generateUpdateButton(package);
        var open_button = generateOpenButton(package);

        vertical_box.add (name_label);
        vertical_box.add (summary_label);

        var package_row = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
        package_row.margin = 12;
        package_row.add(icon);
        package_row.add (vertical_box);

        package_row.pack_end (open_button, false, false);

        if(!isLatestVersion(package, installedPackages)){
            package_row.pack_end (update_button, false, false);
        }

        package_row.pack_end (delete_button, false, false);

        this.add (package_row);
    }
}
}
