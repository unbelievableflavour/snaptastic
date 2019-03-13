using Granite.Widgets;

namespace Application {
public class DetailViewBanner : ListBoxRow {

    private ResponseTranslator response_translator = new ResponseTranslator ();
    public static GLib.Settings settings;
    Gtk.Box package_row;

    Gtk.Label summary_label;
    Gtk.Label version_label;

    public DetailViewBanner (Package package) {
        reload_view (package);
    }

    public void load_package (Package new_package) {
        remove (package_row);
        reload_view (new_package);
        show_all ();
    }

    public void reload_view (Package package) {
        settings = new GLib.Settings (Constants.APPLICATION_NAME);
        set_dark_mode (settings.get_boolean ("use-dark-theme"));
        IconHandler iconHandler = new IconHandler ();
        iconHandler.set_icon_size (64);
        var icon = iconHandler.get_icon_from_string (package);

        var installed_packages = response_translator.get_installed_packages ();
        var refreshablePackages = response_translator.get_refreshable_packages ();

        name_label = new Gtk.Label (package.get_name ().strip ());
        name_label.get_style_context ().add_class ("detail-view-banner-title");

        summary_label = new Gtk.Label ("");
        if (package.get_developer () != null) {
            summary_label = generate_summary_label (package.get_developer ());
        }
        version_label = new Gtk.Label ("");
        if (package.get_version () != null) {
            var label = package.get_channel () != ""
                ? "(" + package.get_channel () + ")" + package.get_version ()
                : package.get_version ();
            version_label = generate_summary_label (label);
        }

        var delete_button = generate_delete_button (package);
        var update_button = generate_update_button (package);
        var open_button = generate_open_button (package);
        var install_button = generate_install_button (package);

        var horizontal_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 10);
        horizontal_box.add (name_label);
        horizontal_box.add (version_label);

        var vertical_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 10);
        vertical_box.add (horizontal_box);
        vertical_box.add (summary_label);

        package_row = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
        package_row.margin = 12;
        package_row.add (icon);
        package_row.add (vertical_box);

        if (!is_installed (package, installed_packages)) {
            summary_label.set_label ("This snap is not installed yet");
            package_row.pack_end (install_button, false, false);
            add (package_row);
            return;
        }

        if (package.get_name () != "core" && package.get_developer () != "conanical") {
            package_row.pack_end (open_button, false, false);
        }

        if (!is_latest_version (package, refreshablePackages)) {
            package_row.pack_end (update_button, false, false);
        }
        if (package.get_name () != "core" && package.get_developer () != "conanical") {
            package_row.pack_end (delete_button, false, false);
        }

        add (package_row);
    }

    public void set_dark_mode (bool answer = true) {
        if (answer) {
           this.get_style_context ().add_class ("detail-view-banner-dark");
        } else {
           this.get_style_context ().remove_class ("detail-view-banner-dark");
        }
    }
}
}
