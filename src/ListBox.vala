using Granite.Widgets;

namespace Application {
public class ListBox : Gtk.ListBox{

    static ListBox? instance;

    private ResponseTranslator responseTranslator = new ResponseTranslator ();
    private StackManager stackManager = StackManager.get_instance();

    ListBox() {

        row_activated.connect (on_row_activated);

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

        stackManager.getStack().visible_child_name = "list-view";

        var installedPackages = responseTranslator.getInstalledPackages();

        emptyList();
        foreach (Package package in installedPackages) {
            add (new InstalledPackageRow (package, installedPackages));
        }

        show_all();
    }

    private void on_row_activated (Gtk.ListBoxRow row) {
        stackManager.getStack().visible_child_name = "progress-view";

        var activePackage = ((ListBoxRow)row).package;

        stackManager.setDetailPackage(activePackage);

        stackManager.getStack().visible_child_name = "detail-view";
    }
}
}
