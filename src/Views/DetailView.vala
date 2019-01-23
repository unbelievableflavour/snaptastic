namespace Application {
public class DetailView : Gtk.Grid {

    Gtk.Label package_information;
    Gtk.Label package_contact;
    Gtk.Image screenshot;

    Gtk.Grid content_grid;
    DetailViewBanner package_row;
    Gtk.ScrolledWindow scrolled;

    public DetailView () {
        var package = new Package ();
        package.set_name ("name");
        package.set_version ("1.0.0");
        package.set_developer ("Developer");

        reload_view (package);
    }

    public void reload_view (Package package) {

        package_information = new Gtk.Label ("");
        if (package.get_description () != null) {
            package_information = new Gtk.Label (package.get_description ());
        }

        package_contact = new Gtk.Label ("");
        if (package.get_contact () != null) {
            package_contact = new Gtk.Label (package.get_contact ());
        }

        screenshot = new Gtk.Image ();
        if (package.get_screenshots ().length != 0) {
            screenshot = get_screenshot_from_string (package.get_screenshots ().index (0));
        }

        column_spacing = 12;
        hexpand = true;

        package_information.set_line_wrap (true);
        package_information.set_max_width_chars (60);

        package_row = new DetailViewBanner (package);

        content_grid = new Gtk.Grid ();
        content_grid.halign = Gtk.Align.CENTER;
        content_grid.margin = 30;
        content_grid.row_spacing = 20;
        content_grid.orientation = Gtk.Orientation.VERTICAL;
        content_grid.add (screenshot);
        content_grid.add (package_information);
        content_grid.add (package_contact);

        scrolled = new Gtk.ScrolledWindow (null, null);
        scrolled.hscrollbar_policy = Gtk.PolicyType.NEVER;
        scrolled.expand = true;
        scrolled.add (content_grid);

        package_row.get_style_context ().add_class ("detail-view-banner");

        attach (package_row, 0, 0, 1, 1);
        attach (scrolled, 0, 1, 1, 1);
    }

    public void load_package (Package package) {
        remove (package_information);
        remove (package_contact);
        remove (screenshot);
        remove (content_grid);
        remove (package_row);
        remove (scrolled);

        reload_view (package);
        show_all ();
    }


    public Gtk.Image get_screenshot_from_string (string url) {
        var file_photo = File.new_for_uri (url);
        var image = new Granite.AsyncImage (true, true);
        image.get_style_context ().add_class ("backimg");
        image.set_from_file_async.begin (file_photo, 300, 200, false);
        return image;

    }
}}
