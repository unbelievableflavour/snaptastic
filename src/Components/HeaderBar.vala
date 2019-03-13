using Granite.Widgets;

namespace Application {
public class HeaderBar : Gtk.HeaderBar {

    static HeaderBar? instance;

    private StackManager stack_manager = StackManager.get_instance ();
    ListBox list_box = ListBox.get_instance ();
    public Gtk.Button return_button = new Gtk.Button ();
    private Granite.Widgets.ModeButton view_mode = new Granite.Widgets.ModeButton ();
    private Granite.ModeSwitch dark_mode_switch = new Granite.ModeSwitch.from_icon_name (
        "display-brightness-symbolic", "weather-clear-night-symbolic"
    );
    public static GLib.Settings settings;

    HeaderBar () {
        Granite.Widgets.Utils.set_color_primary (this, Constants.BRAND_COLOR);

        generate_view_mode ();
        generate_return_button ();
        generate_dark_mode_button ();

        this.pack_start (return_button);
        this.show_close_button = true;
        this.set_custom_title (view_mode);
        this.pack_end (dark_mode_switch);
    }

    public static HeaderBar get_instance () {
        if (instance == null) {
            instance = new HeaderBar ();
        }
        return instance;
    }

    private void generate_view_mode () {
        var label1 = new Gtk.Label ("Home");
        label1.tooltip_markup = Granite.markup_accel_tooltip ({"<Ctrl>H"}, _("Go to home"));
        label1.get_style_context ().add_class ("view-mode-button");
        label1.name = "home";

        var label2 = new Gtk.Label ("Updates");
        label2.tooltip_markup = Granite.markup_accel_tooltip ({"<Ctrl>U"}, _("Go to installed applications"));
        label2.get_style_context ().add_class ("view-mode-button");
        label2.name = "updates";

        view_mode.append (label1);
        view_mode.append (label2);
        view_mode.no_show_all = true;
        view_mode.visible = false;
        view_mode.margin = 1;
        view_mode.notify["selected"].connect (on_view_mode_changed);
    }

    private void generate_return_button () {
        return_button.label = _("Back");
        return_button.no_show_all = true;
        return_button.visible = false;
        return_button.get_style_context ().add_class ("back-button");
        return_button.clicked.connect (() => {
            stack_manager.get_stack ().visible_child_name = "list-view";
        });
    }

    private void generate_dark_mode_button () {
        settings = new GLib.Settings (Constants.APPLICATION_NAME);
        var gtk_settings = Gtk.Settings.get_default ();
        dark_mode_switch.primary_icon_tooltip_text = _("Light mode");
        dark_mode_switch.secondary_icon_tooltip_text = _("Dark mode");
        dark_mode_switch.valign = Gtk.Align.CENTER;
        dark_mode_switch.bind_property ("active", gtk_settings, "gtk_application_prefer_dark_theme");
        settings.bind ("use-dark-theme", dark_mode_switch, "active", GLib.SettingsBindFlags.DEFAULT);

    }

    public void show_view_mode (bool answer) {
        view_mode.visible = answer;
    }

    public void show_return_button (bool answer) {
        return_button.visible = answer;
    }

    public void show_dark_mode_button (bool answer) {
        dark_mode_switch.visible = answer;
    }

    public void set_selected_view_mode (int answer) {
        view_mode.selected = answer;
    }

     private void on_view_mode_changed () {
        if (view_mode.selected == 0) {
            stack_manager.get_stack ().visible_child_name = "welcome-view";
        }else {
            stack_manager.get_stack ().visible_child_name = "list-view";
            list_box.get_installed_packages ();
        }
    }
}
}
