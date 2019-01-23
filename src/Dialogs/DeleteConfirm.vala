namespace Application {
public class DeleteConfirm : Object {

    private StackManager stack_manager = StackManager.get_instance ();
    private CommandHandler command_handler = new CommandHandler ();

    public DeleteConfirm (Package deleted_package) {
        var message_dialog = new Granite.MessageDialog.with_image_from_icon_name (
            _("Delete this application?"),
            _("Are you sure you want to delete this application?"),
            "edit-delete",
            Gtk.ButtonsType.CANCEL
        );

        var suggested_button = new Gtk.Button.with_label ("Delete");
        suggested_button.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
        message_dialog.add_action_widget (suggested_button, Gtk.ResponseType.ACCEPT);

        message_dialog.show_all ();
        if (message_dialog.run () == Gtk.ResponseType.ACCEPT) {
            stack_manager.get_stack ().visible_child_name = "progress-view";
            command_handler.delete_package (deleted_package);
        }
        message_dialog.destroy ();
    }
}
}
