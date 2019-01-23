using Granite.Widgets;

namespace Application {
public class InstalledPackageRow : ListBoxRow {

    private Gtk.Box vertical_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 6);

    public InstalledPackageRow (Package package,Package[] installed_packages) {

            this.package = package;

            IconHandler iconHandler = new IconHandler ();
            var icon = iconHandler.get_icon_from_string (package);

            name_label = generate_name_label (package.get_name () + " (" + package.get_developer () + ")");

            var summary_label = generate_summary_label ("("+ package.get_channel () + ") " + package.get_version ());

            vertical_box.add (name_label);
            vertical_box.add (summary_label);

            var package_row = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
            package_row.margin = 12;
            package_row.add (icon);
            package_row.add (vertical_box);

            this.add (package_row);
        }
}
}
