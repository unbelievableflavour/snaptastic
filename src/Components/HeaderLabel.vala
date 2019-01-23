namespace Application {
public class HeaderLabel : Gtk.Label {

    public HeaderLabel (string text) {
        label = text;
        get_style_context ().add_class ("h4");
        halign = Gtk.Align.START;
    }
}
}
