namespace Application {
public class DetailView : Gtk.Grid{

    Gtk.Label packageInformation = new Gtk.Label (_("Package Information"));
    Gtk.Label packageContact = new Gtk.Label (_("Developer"));
    DetailViewBanner packageRow;

    public DetailView(){
        column_spacing = 12;
        hexpand = true;

        packageInformation.set_line_wrap(true);
        packageInformation.set_max_width_chars(60);

        var package = new Package();
        package.setName("name");
        package.setVersion("1.0.0");
        package.setDeveloper("Developer");

        packageRow = new DetailViewBanner (package);

        var content_grid = new Gtk.Grid ();

            content_grid.halign = Gtk.Align.CENTER;
            content_grid.margin = 30;
            content_grid.row_spacing = 20;
            content_grid.orientation = Gtk.Orientation.VERTICAL;
            content_grid.add (packageInformation);
            content_grid.add (packageContact);

        var scrolled = new Gtk.ScrolledWindow (null, null);
            scrolled.hscrollbar_policy = Gtk.PolicyType.NEVER;
            scrolled.expand = true;
            scrolled.add (content_grid);

        packageRow.get_style_context().add_class("detail-view-banner");

        attach (packageRow, 0, 0, 1, 1);
        attach (scrolled, 0, 1, 1, 1);
    }

    public void loadPackage(Package package){
        packageInformation.set_label("");
        
        if(package.getName() != null){
            packageInformation.set_label(package.getDescription());
            packageContact.set_label(package.getContact());
            packageRow.loadPackage(package);
        }
    }
}}
