using Granite.Widgets;

namespace Application {
public class InstalledPackageRow : ListBoxRow {

    private SnapdHandler snapd_handler = new SnapdHandler ();
    private IconHandler icon_handler = new IconHandler ();
    private Gtk.Box vertical_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 6);
    private Gtk.Box package_row;
    private Gtk.Label summary_label;
    private Gtk.Image icon;

    public InstalledPackageRow (Package package,Package[] installed_packages) {

        this.package = package;
        package_row = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
        reload_view (package);
        this.add (package_row);
        snapd_handler.update_installed_package_row (this);

    }

    public void reload_view (Package package) {

        icon = icon_handler.get_icon_from_string (package);
        name_label = generate_name_label (package.get_name () + " (" + package.get_developer () + ")");
        summary_label = generate_summary_label ("("+ package.get_channel () + ") " + package.get_version ());

        vertical_box.add (name_label);
        vertical_box.add (summary_label);

        package_row.margin = 12;
        package_row.add (icon);
        package_row.add (vertical_box);

    }

    public void load_package (Package package) {

        package_row.remove (icon);
        vertical_box.remove (name_label);
        vertical_box.remove (summary_label);
        package_row.remove (vertical_box);
        reload_view (package);
        show_all ();

    }
}
}
