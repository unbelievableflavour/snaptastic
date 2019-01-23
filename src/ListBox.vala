using Granite.Widgets;

namespace Application {
public class ListBox : Gtk.ListBox {

    static ListBox? instance;

    private ResponseTranslator response_translator = new ResponseTranslator ();
    private StackManager stack_manager = StackManager.get_instance ();

    ListBox () {

        row_activated.connect (on_row_activated);

    }

    public static ListBox get_instance () {
        if (instance == null) {
            instance = new ListBox ();
        }
        return instance;
    }

    public void empty_list () {
        this.foreach ((ListBoxRow) => {
            this.remove (ListBoxRow);
        });
    }

    public void get_installed_packages () {

        stack_manager.get_stack ().visible_child_name = "list-view";

        var installed_packages = response_translator.get_installed_packages ();

        empty_list ();
        foreach (Package package in installed_packages) {
            add (new InstalledPackageRow (package, installed_packages));
        }

        show_all ();
    }

    private void on_row_activated (Gtk.ListBoxRow row) {
        stack_manager.get_stack ().visible_child_name = "progress-view";

        var activePackage = ((ListBoxRow)row).package;

        stack_manager.set_detail_package (activePackage);

        stack_manager.get_stack ().visible_child_name = "detail-view";
    }
}
}
