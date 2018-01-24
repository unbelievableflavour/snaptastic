namespace Application {
public class DetailView : Gtk.Grid{

    private ConfigFileReader configFileReader = new ConfigFileReader ();
    StackManager stackManager = StackManager.get_instance();
    private ListBox listBox = ListBox.get_instance();

    Gtk.Label packageInformation = new Gtk.Label ("Name Information");

    public DetailView(){ 
        attach (packageInformation, 0, 0, 2, 1);
    }

    public void loadPackage(string packageName){
        packageInformation.set_label("");
        
        if(packageName != null){
            string packageString = configFileReader.getPackageByName(packageName);
            packageInformation.set_label(packageString);
        }
    }
}}
