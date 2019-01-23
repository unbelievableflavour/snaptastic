using Granite.Widgets;

namespace Application {
public class ListBoxRow : Gtk.ListBoxRow {

    private StackManager stack_manager = StackManager.get_instance ();
    public Gtk.Label name_label;
    public Package package;

    private CommandHandler command_handler = new CommandHandler ();

    public bool is_installed (Package package, Package[] installed_packages) {
        foreach (Package installed_package in installed_packages) {
            if (package.get_name () == installed_package.get_name ()) {
                return true;
            }
        }
        return false;
    }

    public bool is_latest_version (Package package, Package[] refreshable_packagess) {
        foreach (Package refreshable_packages in refreshable_packagess) {
            if (package.get_name () == refreshable_packages.get_name ()) {
                return true;
            }
        }
        return false;
    }

    public Gtk.Label generate_name_label (string name) {
        var name_label = new Gtk.Label ("<big><b>%s</b></big>".printf (name));
        name_label.use_markup = true;
        name_label.halign = Gtk.Align.START;

        return name_label;
    }

    public Gtk.Label generate_summary_label (string summary) {
        var summary_label = new Gtk.Label ("%s".printf (summary));
        summary_label.use_markup = true;
        summary_label.halign = Gtk.Align.START;

        return summary_label;
    }

    public Gtk.Button generate_update_button (Package package) {
        var update_button = new Gtk.Button ();
        update_button.set_label (_("Refresh"));
        update_button.valign = Gtk.Align.CENTER;
        update_button.set_tooltip_text (_("Update this to latest version"));
        update_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
        update_button.button_press_event.connect (() => {
            stack_manager.get_stack ().visible_child_name = "progress-view";
            command_handler.update_package (package);
            return true;
        });

        return update_button;
    }

    public Gtk.Button generate_delete_button (Package package) {
        var delete_button = new Gtk.Button ();
        delete_button.valign = Gtk.Align.CENTER;
        delete_button.set_label (_("Uninstall"));
        delete_button.get_style_context ().add_class (Gtk.STYLE_CLASS_DESTRUCTIVE_ACTION);
        delete_button.set_tooltip_text (_("Uninstall this application"));
        delete_button.button_press_event.connect (() => {
            new DeleteConfirm (package);
            return true;
        });

        return delete_button;
    }

    public Gtk.Button generate_install_button (Package package) {

        var install_button = new Gtk.Button ();

        if ( package.get_channel () != "") {
            install_button.set_label (_("Install") + " "+ package.get_channel ());
        } else {
            install_button.set_label (_("Install"));
        }

        install_button.valign = Gtk.Align.CENTER;
        install_button.set_tooltip_text (_("Install this application"));
        install_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
        install_button.button_press_event.connect (() => {
            stack_manager.get_stack ().visible_child_name = "progress-view";
            command_handler.install_package (package);
            return true;
        });
        return install_button;
    }

    public Gtk.Button generate_open_button (Package package) {

        var open_button = new Gtk.Button ();
        open_button.valign = Gtk.Align.CENTER;
        open_button.set_label (_("Open"));
        open_button.get_style_context ().add_class (Gtk.STYLE_CLASS_SUGGESTED_ACTION);
        open_button.set_tooltip_text (_("Run the application"));
        open_button.button_press_event.connect (() => {
            command_handler.run_package (package.get_name ());
            return true;
        });
        return open_button;
    }
}
}
