using Granite.Widgets;

namespace Application {
public class IconHandler {

    private FileManager file_manager = FileManager.get_instance ();
    private int icon_size = 32;
    private Gtk.Image backup_icon = new Gtk.Image.from_icon_name ("package", Gtk.IconSize.DND);
    private File file_photo;
    private Granite.AsyncImage image;

    public Gtk.Image get_icon_from_string (Package package) {
        if ( package.get_icon () == "" || package.get_icon () == null) {
            return backup_icon;
        }
        try {
            if ( package.get_icon ().substring (0,4) == "http") {
                file_photo = File.new_for_uri (package.get_icon ());
                image = new Granite.AsyncImage (true, true);
                image.get_style_context ().add_class ("backimg");
                image.set_from_file_async.begin (file_photo, icon_size, -1, true);
                return image;
            }

            var filePath = get_local_icon_path (package);

            if (filePath == "") {
                return backup_icon;
            }

            var pixbuf = new Gdk.Pixbuf.from_file_at_size (filePath, icon_size, icon_size);

            var local_image = new Gtk.Image ();
            local_image.set_from_pixbuf (pixbuf);

            return local_image;

        } catch (Error e) {
            error ("%s", e.message);
        }
    }

    public void set_icon_size (int icon_size) {
        this.icon_size = icon_size;
    }

    private string get_local_icon_path (Package package) {
        Array<string> possible_icon_paths = new Array<string> ();
            possible_icon_paths.append_val (
                "/snap/" + package.get_name () + "/current/" + package.get_name () +".png");
            possible_icon_paths.append_val (
                "/snap/" + package.get_name () + "/current/usr/share/icons/hicolor/64x64/apps/"
                + package.get_name () + ".png");
            possible_icon_paths.append_val (
                "/snap/" + package.get_name () + "/current/usr/share/icons/hicolor/48x48/apps/"
                + package.get_name () + ".png");
            possible_icon_paths.append_val (
                "/snap/" + package.get_name () + "/current/usr/share/icons/hicolor/32x32/apps/"
                + package.get_name () + ".png");

        for (int i = 0; i < possible_icon_paths.length ; i++) {
            if (file_manager.file_exists (possible_icon_paths.index (i))) {
                return possible_icon_paths.index (i);
            }
        }

        return "";
    }
}
}
