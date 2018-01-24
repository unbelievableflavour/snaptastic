using Granite.Widgets;

namespace Application {
public class ProgressView : Gtk.ScrolledWindow {

    public ProgressView(){ 
        var progress_view = new Welcome(_("Please Wait..."), _("Operation is in progress..."));
        this.add(progress_view);
    }
}
}
