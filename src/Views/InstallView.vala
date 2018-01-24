using Granite.Widgets;

namespace Application {
public class InstallView : Gtk.ScrolledWindow {

    public InstallView(){ 
        var install_view = new Welcome(_("Please Wait..."), _("Application is installing..."));
        this.add(install_view);
    }
}
}
