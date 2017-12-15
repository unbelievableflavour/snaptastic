using Granite.Widgets;

namespace Application {
public class NotFoundView : Gtk.ScrolledWindow {

    public NotFoundView(){ 
        var not_found_view = new Welcome(_("Nothing was found"), _("Try searching for something else"));

        this.add(not_found_view);
    }
}
}
