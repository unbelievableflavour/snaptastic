using Granite.Widgets;

namespace Application {
public class NotFoundView : Gtk.ScrolledWindow {

    public NotFoundView(){ 
        var not_found_view = new Welcome(_("No snaps where found"), _("Please install some"));
        this.add(not_found_view);
    }
}
}
