using Granite.Widgets;

namespace Application {
public class IconHandler {

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
            
            var pixbuf =  new Gdk.Pixbuf.from_file_at_size ("/snap/" + package.getName() + "/current/" + package.getName() +".png", icon_size, icon_size);

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
}
}
