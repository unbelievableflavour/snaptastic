namespace Application {
public class ListView : Gtk.ScrolledWindow {
       
    private ListBox listBox = ListBox.get_instance();

   public ListView(){ 

        var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 6);
        box.add(listBox);

        this.hscrollbar_policy = Gtk.PolicyType.NEVER;
        this.add (box);

        Gdk.RGBA color = {1,1,1,1};
        this.override_background_color(Gtk.StateFlags.NORMAL,color);
    }
}
}
