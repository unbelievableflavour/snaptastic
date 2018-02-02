namespace Application {
public class DetailView : Gtk.Grid{

    private ConfigFileReader configFileReader = new ConfigFileReader ();

    Gtk.Label packageInformation = new Gtk.Label ("Name Information");

    public DetailView(){
        column_spacing = 12;
        hexpand = true;

        var package = new Package();
        package.setName("name");
        package.setVersion("1.0.0");
        var installedPackages = configFileReader.getInstalledPackages();
        var packageRow = new DetailViewBanner (package, installedPackages);

        var content_grid = new Gtk.Grid ();
            content_grid.width_request = 800;
            content_grid.halign = Gtk.Align.CENTER;
            content_grid.margin = 48;
            content_grid.row_spacing = 24;
            content_grid.orientation = Gtk.Orientation.VERTICAL;
            content_grid.add (packageInformation);

        var scrolled = new Gtk.ScrolledWindow (null, null);
            scrolled.hscrollbar_policy = Gtk.PolicyType.NEVER;
            scrolled.expand = true;
            scrolled.add (content_grid);

        packageRow.get_style_context().add_class("detail-view-banner");

        attach (packageRow, 0, 0, 1, 1);
        attach (scrolled, 0, 1, 1, 1);
    }

    public void loadPackage(string packageName){
        packageInformation.set_label("");
        
        if(packageName != null){
            string packageString = configFileReader.getPackageByName(packageName);
            packageInformation.set_label(packageString);
        }
    }
}}
