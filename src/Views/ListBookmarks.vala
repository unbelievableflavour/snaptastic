namespace Application {
public class ListBookmarks : Gtk.ScrolledWindow {
       
    private ListBox listBox = ListBox.get_instance();

   public ListBookmarks(){ 

        var box = new Gtk.Box (Gtk.Orientation.VERTICAL, 6);
        box.add(listBox);

        this.hscrollbar_policy = Gtk.PolicyType.NEVER;
        this.add (box);
    }
}
}
