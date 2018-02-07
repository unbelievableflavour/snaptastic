using Granite.Widgets;

namespace Application {
public class ListBoxRow : Gtk.ListBoxRow {

    private StackManager stackManager = StackManager.get_instance();
    public Gtk.Label name_label;
    public Package package;

    private CommandHandler commandHandler = new CommandHandler();

    public bool isInstalled(Package package, Package[] installedPackages){
        foreach (Package installedPackage in installedPackages) {
            if(package.getName() == installedPackage.getName()){
                return true;
            }
        }
        return false;
    }

    public bool isLatestVersion(Package package, Package[] refreshablePackages){
        foreach (Package refreshablePackage in refreshablePackages) {          
            if(package.getName() == refreshablePackage.getName()){
                return true;
            }
        }
        return false;
    }

    public Gtk.Label generateNameLabel(string name){
        var name_label = new Gtk.Label ("<big><b>%s</b></big>".printf (name));
        name_label.use_markup = true;
        name_label.halign = Gtk.Align.START;

        return name_label;
    }

    public Gtk.Label generateSummaryLabel(string summary){
        var summary_label = new Gtk.Label ("%s".printf (summary));
        summary_label.use_markup = true;
        summary_label.halign = Gtk.Align.START;

        return summary_label;
    }

    public Gtk.Button generateUpdateButton(Package package){
     
    var update_button = new Gtk.Button();
        update_button.set_label(_("Refresh"));
        update_button.valign = Gtk.Align.CENTER;
        update_button.set_tooltip_text(_("Update this to latest version"));
        update_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
        update_button.button_press_event.connect (() => {
            stackManager.getStack().visible_child_name = "progress-view";
            commandHandler.updatePackage(package);
            return true;
        });

        return update_button;
    }

    public Gtk.Button generateDeleteButton(Package package){
        var delete_button = new Gtk.Button();
        delete_button.valign = Gtk.Align.CENTER;
        delete_button.set_label(_("Uninstall"));
        delete_button.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
        delete_button.set_tooltip_text(_("Uninstall this application"));
        delete_button.button_press_event.connect (() => {
            new DeleteConfirm(package);
            return true;
        });

        return delete_button;
    }

    public Gtk.Button generateInstallButton(Package package){

        var install_button = new Gtk.Button(); 
        install_button.set_label(_("Install")); 
        install_button.valign = Gtk.Align.CENTER;
        install_button.set_tooltip_text(_("Install this application")); 
        install_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
        install_button.button_press_event.connect (() => {
            stackManager.getStack().visible_child_name = "progress-view";
            commandHandler.installPackage(package);
            return true;
        }); 
        return install_button;
    }

    public Gtk.Button generateOpenButton(Package package){

        var open_button = new Gtk.Button(); 
        open_button.valign = Gtk.Align.CENTER;
        open_button.set_label(_("Open")); 
        open_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
        open_button.set_tooltip_text(_("Run the application")); 
        open_button.button_press_event.connect (() => {
            commandHandler.runPackage(package.getName());
            return true;
        }); 
        return open_button;
    }
}
}
