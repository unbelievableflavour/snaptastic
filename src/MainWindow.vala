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

        if(fileManager.getFile() != null){
            if (fileManager.getFile().has_uri_scheme ("snap")) {
                installByName();
            }

            if (fileManager.getFile().has_uri_scheme ("file")) {
                installFromUrl();
            }
        }
    }

    public void installFromUrl(){
        var name = fileManager.getFile().get_uri().replace ("snap://", "");

        if (name.has_suffix ("/")) {
            name = name.substring (0, name.last_index_of_char ('/'));
        }

	    stackManager.getStack().visible_child_name = "progress-view";
        Package package = new Package();
        package.setName(name);
        package.setNotes("classic");
	    commandHandler.installPackage(package);
    }

    public void installByName(){
        var link = fileManager.getFile().get_uri().replace ("file://", "");

	    stackManager.getStack().visible_child_name = "progress-view";
        commandHandler.installPackageFromFile(link);
    }
}
}
