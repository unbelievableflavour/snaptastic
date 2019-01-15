using Granite.Widgets;

namespace Application {
public class MainWindow : Gtk.Window{

    private StackManager stackManager = StackManager.get_instance();
    private FileManager fileManager = FileManager.get_instance();
    private HeaderBar headerBar = HeaderBar.get_instance();
    private CommandHandler commandHandler = new CommandHandler();
    private ResponseTranslator responseTranslator = new ResponseTranslator();
    private SnapdURIHandler snapdURIHandler = new SnapdURIHandler();

    public MainWindow (Gtk.Application application) {
        Object (application: application,
                resizable: true,
                height_request: Constants.APPLICATION_HEIGHT,
                width_request: Constants.APPLICATION_WIDTH);
    }

    public void recheck() {
        if(fileManager.getFile() != null){
            if (fileManager.getFile().has_uri_scheme ("snap")) {
                installFromUrl();
            }

            if (fileManager.getFile().has_uri_scheme ("file")) {
                installFromFile();
            }
        }
    }

    construct {
        var style_context = get_style_context ();
        style_context.add_class (Gtk.STYLE_CLASS_VIEW);
        style_context.add_class ("rounded");

        set_titlebar (headerBar);

        stackManager.loadViews(this);

        stackManager.getStack().visible_child_name = "welcome-view";
        recheck();
        addShortcuts();
    }

    public void installFromUrl(){
        var nameAndChannel = fileManager.getFile().get_uri().replace ("snap://", "");

        if (nameAndChannel.has_suffix ("/")) {
            nameAndChannel = nameAndChannel.substring (0, nameAndChannel.last_index_of_char ('/'));
        }

	    snapdURIHandler.setParametersFromURI(nameAndChannel);

        Package package = responseTranslator.getPackageByName(snapdURIHandler.getURIName());

        if(package == null){
            return;
        }

        if(snapdURIHandler.getURIChannel() != "") {
            package.setVersion("");
            package.setChannel(snapdURIHandler.getURIChannel());
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

    private void addShortcuts(){
        key_press_event.connect ((e) => { 
            switch (e.keyval) {
                case Gdk.Key.u:    
                  if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {  
                    stackManager.getStack().visible_child_name = "list-view";
                  }
                  break;
                case Gdk.Key.h:
                  if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {  
                    stackManager.getStack().visible_child_name = "welcome-view";
                  }
                  break;
                case Gdk.Key.q:
                  if ((e.state & Gdk.ModifierType.CONTROL_MASK) != 0) {  
                    this.destroy ();
                  }
                  break;
            }

            return false; 
        });
    }
}
}
