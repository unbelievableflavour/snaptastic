namespace Application {
public class Alert : Object {

    private StackManager stack_manager = StackManager.get_instance ();

    public Alert (string title, string description) {
        var message_dialog = new Granite.MessageDialog.with_image_from_icon_name (title, description, "dialog-warning");
        message_dialog.transient_for = stack_manager.main_window;
        message_dialog.window_position = Gtk.WindowPosition.CENTER_ON_PARENT;
        message_dialog.show_all ();

        if (message_dialog.run () == Gtk.ResponseType.CLOSE) {
            message_dialog.destroy ();
        }
    }
}
}
