using Granite.Widgets;

namespace Application {
public class ListBoxRow : Gtk.ListBoxRow {

    public bool isInstalled(Package package, Package[] installedPackages){
        foreach (Package installedPackage in installedPackages) {
            if(package.getName() == installedPackage.getName()){
                return true;
            }
        }
        return false;
    }

    public bool isLatestVersion(Package package, Package[] installedPackages){
        foreach (Package installedPackage in installedPackages) {
            if(package.getName() == installedPackage.getName()){
                if(package.getVersion() == installedPackage.getVersion()){
                    return true;
                }
            }
        }
        return false;
    }

    public Gtk.Label generateNameLabel(string name){
        var name_label = new Gtk.Label ("<b>%s</b>".printf (name));
        name_label.use_markup = true;
        name_label.halign = Gtk.Align.START;

        return name_label;
    }

    public Gtk.Label generateSummaryLabel(string developer){
        var summary_label = new Gtk.Label (developer);
        summary_label.halign = Gtk.Align.START;

        return summary_label;
    }

    public Gtk.Button generateUpdateButton(Package package){
     
    var update_button = new Gtk.Button();
        update_button.set_label(_("Update"));
        update_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
        update_button.set_tooltip_text(_("Update this to latest version"));
        update_button.button_press_event.connect (() => {
            new Alert("Updating!", "not really...yet..");
            return true;
        });

        return update_button;
    }

    public Gtk.Button generateDeleteButton(Package package){
        var delete_button = new Gtk.Button();
        delete_button.set_label(_("Uninstall"));
        delete_button.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
        delete_button.set_tooltip_text(_("Uninstall this application"));
        delete_button.button_press_event.connect (() => {
            new DeleteConfirm(package);
            return true;
        });

        return delete_button;
    }

    public Gtk.Button generateStartButton(Package package){

        var install_button = new Gtk.Button(); 
        install_button.set_label(_("Install")); 
        install_button.set_tooltip_text(_("Install this application")); 
        install_button.button_press_event.connect (() => { 
            string homeDir = Environment.get_home_dir ();
            string notes = "";
            if(package.getNotes() == "classic"){
                notes = "--classic";            
            }
            // Create the variables for the process execution
            string[] spawnArguments = {
                "pkexec", 
                "env", 
                "HOME=" + homeDir, 
                "com.github.bartzaalberg.snapcenter-install", 
                "snap", 
                "install", 
                package.getName(),
                notes
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
            return true;
        }); 
        return install_button;
    }
}
}
