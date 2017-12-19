namespace Application {
public class DeleteConfirm : Object {
      
    private ListBox listBox = ListBox.get_instance();
    private StackManager stackManager = StackManager.get_instance();

    public DeleteConfirm(Package deletedPackage){
        var message_dialog = new Granite.MessageDialog.with_image_from_icon_name (_("Delete this application?"), _("Are you sure you want to delete this application?"), "edit-delete", Gtk.ButtonsType.CANCEL);

        var suggested_button = new Gtk.Button.with_label ("Delete");
        suggested_button.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
        message_dialog.add_action_widget (suggested_button, Gtk.ResponseType.ACCEPT);

        message_dialog.show_all ();
        if (message_dialog.run () == Gtk.ResponseType.ACCEPT) {
            deletePackage(deletedPackage);
        }
        message_dialog.destroy ();
    }

    private void deletePackage(Package deletedPackage) {
        string homeDir = Environment.get_home_dir ();

        string[] spawnArguments = {
                "pkexec", 
                "env", 
                "HOME=" + homeDir, 
                "com.github.bartzaalberg.snapcenter-install", 
                "snap", 
                "remove", 
                deletedPackage.getName()
            };
        string[] spawnEnvironment = Environ.get ();
        string spawnStdOut;
        string spawnStdError;
        int spawnExitStatus;

        try {
            // Spawn the process synchronizedly
            // We do it synchronizedly because since we are just launching another process and such is the whole
            // purpose of this program, we don't want to exit this, the caller, since that will cause our spawned process to become a zombie.
            Process.spawn_sync ("/", spawnArguments, spawnEnvironment, SpawnFlags.SEARCH_PATH, null, out spawnStdOut, out spawnStdError, out spawnExitStatus);

            new Alert("Output", spawnStdOut);
            new Alert("There was an error in the spawned process", spawnStdError);
            new Alert("Exit status was", (string) spawnExitStatus);
        } catch (SpawnError spawnCaughtError) {
            new Alert("There was an error spawining the process. Details", spawnCaughtError.message);
        }

        stackManager.getStack().visible_child_name = "list-view"; 
        listBox.getInstalledPackages();
    }
}
}
