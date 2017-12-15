using Granite.Widgets;

namespace Application {
public class EmptyView : Gtk.ScrolledWindow {

    StackManager stackManager = StackManager.get_instance();

    public EmptyView(){ 
        var empty_view = new Welcome(_("Empty"), _("blabla empty?"));
        this.add(empty_view);
    }
}
}
