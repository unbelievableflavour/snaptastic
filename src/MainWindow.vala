using Granite.Widgets;

namespace Application {
public class MainWindow : Gtk.Window{

    private StackManager stackManager = StackManager.get_instance();
    private FileManager fileManager = FileManager.get_instance();
    private HeaderBar headerBar = HeaderBar.get_instance();
    private CommandHandler commandHandler = new CommandHandler();

    const string SWITCHER_STYLE_CSS = """	
@define-color textColorPrimary #fff;
@define-color textColorPrimaryShadow shade(@colorPrimary, 0.85);

.h1,
.h2 {
    font-family: Ubuntu;
}

.h2 {
    color: @colorPrimary;
}

.view-mode-button {
    color: @fff;
    text-shadow: 0 1px @textColorPrimaryShadow;
}
    """;

    construct {
        var style_context = get_style_context ();
        style_context.add_class (Gtk.STYLE_CLASS_VIEW);
        style_context.add_class ("rounded");

            var provider = new Gtk.CssProvider ();	
            try {	
                provider.load_from_data (SWITCHER_STYLE_CSS, SWITCHER_STYLE_CSS.length);	
                Gtk.StyleContext.add_provider_for_screen (Gdk.Screen.get_default (), provider, Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION);	
            } catch (Error e) {	
                critical (e.message);	
            }

        set_default_size(Constants.APPLICATION_WIDTH, Constants.APPLICATION_HEIGHT);
        set_titlebar (headerBar);

        stackManager.loadViews(this);

        stackManager.getStack().visible_child_name = "welcome-view";

        if(fileManager.getFilePath() != ""){
        	stackManager.getStack().visible_child_name = "progress-view";
			commandHandler.installPackageFromFile(fileManager.getFilePath().replace("file://", ""));
        }
    }
}
}
