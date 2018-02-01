using Granite.Widgets;

namespace Application {
public class MainWindow : Gtk.Window{

    private StackManager stackManager = StackManager.get_instance();
    private FileManager fileManager = FileManager.get_instance();
    private HeaderBar headerBar = HeaderBar.get_instance();
    private CommandHandler commandHandler = new CommandHandler();

    construct {
        var style_context = get_style_context ();
        style_context.add_class (Gtk.STYLE_CLASS_VIEW);
        style_context.add_class ("rounded");

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
