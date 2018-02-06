namespace Application {
public class DeleteConfirm : Object {

    private StackManager stackManager = StackManager.get_instance();
    private CommandHandler commandHandler = new CommandHandler();

    public DeleteConfirm(Package deletedPackage){
        var message_dialog = new Granite.MessageDialog.with_image_from_icon_name (_("Delete this application?"), _("Are you sure you want to delete this application?"), "edit-delete", Gtk.ButtonsType.CANCEL);

        var suggested_button = new Gtk.Button.with_label ("Delete");
        suggested_button.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
        message_dialog.add_action_widget (suggested_button, Gtk.ResponseType.ACCEPT);

        message_dialog.show_all ();
        if (message_dialog.run () == Gtk.ResponseType.ACCEPT) {
            stackManager.getStack().visible_child_name = "progress-view";
            commandHandler.deletePackage(deletedPackage);
        }
        message_dialog.destroy ();
    }
}
}
