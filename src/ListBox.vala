using Granite.Widgets;

namespace Application {
public class ListBox : Gtk.ListBox{

    static ListBox? instance;

    private ConfigFileReader configFileReader = new ConfigFileReader ();
    private StackManager stackManager = StackManager.get_instance();

    ListBox() {
    }
 
    public static ListBox get_instance() {
        if (instance == null) {
            instance = new ListBox();
        }
        return instance;
    }

    public void emptyList(){
        this.foreach ((ListBoxRow) => {
            this.remove(ListBoxRow);
        }); 
    }

    public void getInstalledPackages(){
        emptyList();

        HeaderBar.get_instance().searchEntry.sensitive = true;
        HeaderBar.get_instance().showReturnButton(false);

        stackManager.getStack().visible_child_name = "list-view";

        var installedPackages = configFileReader.getInstalledPackages();

        foreach (Package package in installedPackages) {
            add (new InstalledPackageRow (package, installedPackages));
        }

        show_all();
    }

    public void getOnlinePackages(string searchWord = ""){
        emptyList();

        HeaderBar.get_instance().searchEntry.sensitive = true;
        HeaderBar.get_instance().showReturnButton(true);

        stackManager.getStack().visible_child_name = "list-view";

        var packages = configFileReader.getOnlinePackages(searchWord);

        var installedPackages = configFileReader.getInstalledPackages();

        foreach (Package package in packages) {
            add (new SearchPackageRow (package, installedPackages));
        }

        show_all();
    }
}
}
