using Granite.Widgets;

namespace Application {
public class MainWindow : Gtk.Window{

    private StackManager stackManager = StackManager.get_instance();
    private FileManager fileManager = FileManager.get_instance();
    private HeaderBar headerBar = HeaderBar.get_instance();
    private CommandHandler commandHandler = new CommandHandler();
    private ResponseTranslator responseTranslator = new ResponseTranslator();

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
                installFromUrl();
            }

            if (fileManager.getFile().has_uri_scheme ("file")) {
                installFromFile();
            }
        }
    }

    public void installFromUrl(){
        var name = fileManager.getFile().get_uri().replace ("snap://", "");

        if (name.has_suffix ("/")) {
            name = name.substring (0, name.last_index_of_char ('/'));
        }
	    
        Package package = responseTranslator.getPackageByName(name);

        if(package == null){
            return;
        }

        stackManager.setDetailPackage(package);
        stackManager.getStack().visible_child_name = "detail-view";
    }

    public void installFromFile(){
        string path = fileManager.getFile().get_uri().replace ("file://", "");

        string name = commandHandler.getPackageNameByFilePath(path);
		var package = responseTranslator.getPackageByName(name);
        
        if(package == null){
            return;
        }

        stackManager.setDetailPackage(package);
        stackManager.getStack().visible_child_name = "detail-view";
    }
}
}
