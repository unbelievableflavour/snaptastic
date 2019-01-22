using Granite.Widgets;

namespace Application {
public class IconHandler {

    private FileManager fileManager = FileManager.get_instance();
    private int icon_size = 32;

    private Gtk.Image backup_icon = new Gtk.Image.from_icon_name ("package", Gtk.IconSize.DND);

    private File                    file_photo;
    private Granite.AsyncImage      image;

    public Gtk.Image get_icon_from_string(Package package) {
        if( package.getIcon() == "" || package.getIcon() == null) {
            return backup_icon;
        }
        try {
            if( package.getIcon().substring(0,4) == "http") {
                file_photo = File.new_for_uri (package.getIcon());
                image = new Granite.AsyncImage(true, true);
                image.get_style_context ().add_class ("backimg");
                image.set_from_file_async.begin(file_photo, icon_size, icon_size, false);
                return image;
            }

            var filePath = getLocalIconPath (package);

            if(filePath == "") {
                return backup_icon;
            }

            var pixbuf =  new Gdk.Pixbuf.from_file_at_size (filePath, icon_size, icon_size);

            var localImage = new Gtk.Image();
            localImage.set_from_pixbuf(pixbuf);

            return localImage;

        } catch (Error e) {
            error ("%s", e.message);
        }
    }

    public void set_icon_size(int icon_size){
        this.icon_size = icon_size;
    }

    private string getLocalIconPath (Package package) {
        Array<string> possibleIconPaths = new Array<string> ();
            possibleIconPaths.append_val (
                "/snap/" + package.getName() + "/current/" + package.getName() +".png");
	        possibleIconPaths.append_val (
                "/snap/" + package.getName() + "/current/usr/share/icons/hicolor/48x48/apps/"
                + package.getName() + ".png");

        for (int i = 0; i < possibleIconPaths.length ; i++) {
            if (fileManager.file_exists (possibleIconPaths.index (i))) {
                return possibleIconPaths.index (i);
            }
        }

        return "";
    }
}
}
