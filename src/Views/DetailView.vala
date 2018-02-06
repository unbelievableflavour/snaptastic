namespace Application {
public class DetailView : Gtk.Grid{

    private ResponseTranslator responseTranslator = new ResponseTranslator ();
    private CommandHandler commandHandler = new CommandHandler();

    Gtk.Label packageInformation = new Gtk.Label (_("Name Information"));
    DetailViewBanner packageRow;

    public DetailView(){
        column_spacing = 12;
        hexpand = true;

        var package = new Package();
        package.setName("name");
        package.setVersion("1.0.0");
        package.setDeveloper("Developer");

        var installedPackages = responseTranslator.getInstalledPackages();
        packageRow = new DetailViewBanner (package, installedPackages);

        var content_grid = new Gtk.Grid ();
            content_grid.halign = Gtk.Align.CENTER;
            content_grid.margin = 30;
            content_grid.row_spacing = 20;
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

    public void loadPackage(Package package){
        packageInformation.set_label("");
        
        if(package.getName() != null){
            string packageString = commandHandler.getPackageByName(package.getName());
            packageInformation.set_label(packageString);
            var installedPackages = responseTranslator.getInstalledPackages();
            packageRow.loadPackage(package, installedPackages);
        }
    }
}}
