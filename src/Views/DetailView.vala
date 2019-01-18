namespace Application {
public class DetailView : Gtk.Grid{

    Gtk.Label packageInformation;
    Gtk.Label packageContact;
    Gtk.Image screenshot;

    Gtk.Grid content_grid;
    DetailViewBanner packageRow;
    Gtk.ScrolledWindow scrolled;

    public DetailView (){
        var package = new Package();
        package.setName("name");
        package.setVersion("1.0.0");
        package.setDeveloper("Developer");

        reloadView(package);
    }

    public void reloadView(Package package) {

        packageInformation = new Gtk.Label ("");
        if (package.getDescription() != null) {
            packageInformation = new Gtk.Label (package.getDescription());
        }

        packageContact = new Gtk.Label ("");
        if (package.getContact() != null) {
            packageContact = new Gtk.Label (package.getContact());
        }

        screenshot = new Gtk.Image();
        if (package.getScreenshots().length != 0) {
            screenshot = get_screenshot_from_string(package.getScreenshots().index(0));
        }

        column_spacing = 12;
        hexpand = true;

        packageInformation.set_line_wrap(true);
        packageInformation.set_max_width_chars(60);

        packageRow = new DetailViewBanner (package);

        content_grid = new Gtk.Grid ();
        content_grid.halign = Gtk.Align.CENTER;
        content_grid.margin = 30;
        content_grid.row_spacing = 20;
        content_grid.orientation = Gtk.Orientation.VERTICAL;
        content_grid.add (screenshot);
        content_grid.add (packageInformation);
        content_grid.add (packageContact);

        scrolled = new Gtk.ScrolledWindow (null, null);
        scrolled.hscrollbar_policy = Gtk.PolicyType.NEVER;
        scrolled.expand = true;
        scrolled.add (content_grid);

        packageRow.get_style_context().add_class("detail-view-banner");

        attach (packageRow, 0, 0, 1, 1);
        attach (scrolled, 0, 1, 1, 1);
    }

    public void loadPackage(Package package){
        remove (packageInformation);
        remove (packageContact);
        remove (screenshot);
        remove (content_grid);
        remove (packageRow);
        remove (scrolled);

        reloadView(package);
        show_all();
    }


    public Gtk.Image get_screenshot_from_string(string url) {
        try {
                var file_photo = File.new_for_uri (url);
                var image = new Granite.AsyncImage(true, true);
                image.get_style_context ().add_class ("backimg");
                image.set_from_file_async.begin(file_photo, 300, 200, false);
                return image;
        } catch (Error e) {
            error ("%s", e.message);
        }
    }
}}
