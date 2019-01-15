using Granite.Widgets;

namespace Application {
public class DetailViewBanner : ListBoxRow {

    private ResponseTranslator responseTranslator = new ResponseTranslator ();
    private Gtk.Image icon = new Gtk.Image.from_icon_name ("package", Gtk.IconSize.DND);
    private Gtk.Image backup_icon = new Gtk.Image.from_icon_name ("package", Gtk.IconSize.DND);

        private File                    file_photo;
        private Granite.AsyncImage      image;


    Gtk.Box package_row;

    Gtk.Label summary_label;
    Gtk.Label version_label;

    public DetailViewBanner (Package package){
        reloadView(package);
    }

    public void loadPackage(Package newPackage){
        remove(package_row);
        reloadView(newPackage);
        show_all();
    }

    public Gtk.Image getIconFromString(Package package) {
        if( package.getIcon().substring(0,4) == "http") {
            file_photo = File.new_for_uri (package.getIcon());
            image = new Granite.AsyncImage(true, true);
            image.get_style_context ().add_class ("backimg");
            image.set_from_file_async.begin(file_photo, 50, 50, false);
            return image;
        } else {
            try {
                var pixbuf =  new Gdk.Pixbuf.from_file_at_size ("/snap/" + package.getName() + "/current/" + package.getName() +".png", 50, 50);

                var localImage = new Gtk.Image();
                localImage.set_from_pixbuf(pixbuf);
                return localImage;

            } catch (Error e) {
                error ("%s", e.message);
            }
            return backup_icon;
        }
    }

    public void reloadView(Package package){

        if( package.getIcon() != "" && package.getIcon() != null) {
            icon = getIconFromString(package);
        } else{
            icon = backup_icon;
        }

        var installedPackages = responseTranslator.getInstalledPackages();
        var refreshablePackages = responseTranslator.getRefreshablePackages();

        name_label = new Gtk.Label(package.getName().strip());
        name_label.get_style_context ().add_class ("detail-view-banner-title");

        summary_label = new Gtk.Label("");
        if(package.getDeveloper() != null){
            summary_label = generateSummaryLabel(package.getDeveloper());
        }
        version_label = new Gtk.Label("");
        if(package.getVersion() != null) {
            var label = package.getChannel() != "" 
                ? "(" + package.getChannel() + ")" + package.getVersion()
                : package.getVersion();
            version_label = generateSummaryLabel(label);
        }

        var delete_button = generateDeleteButton(package);
        var update_button = generateUpdateButton(package);
        var open_button = generateOpenButton(package);
        var install_button = generateInstallButton(package);
        
        var horizontal_box = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 10);
        horizontal_box.add (name_label);
        horizontal_box.add (version_label);
        
        var vertical_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 10);
        vertical_box.add (horizontal_box);
        vertical_box.add (summary_label);
        
        package_row = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12);
        package_row.margin = 12;
        package_row.add(icon);
        package_row.add (vertical_box);

        if(!isInstalled(package, installedPackages)){
            summary_label.set_label("This snap is not installed yet");
            package_row.pack_end (install_button, false, false);
            add (package_row);
            return;
        }

        if(package.getName() != "core" && package.getDeveloper() != "conanical"){
            package_row.pack_end (open_button, false, false);
        }

        if(!isLatestVersion(package, refreshablePackages)){
            package_row.pack_end (update_button, false, false);
        }
        if(package.getName() != "core" && package.getDeveloper() != "conanical"){
            package_row.pack_end (delete_button, false, false);
        }

        add (package_row);
    }
}
}
