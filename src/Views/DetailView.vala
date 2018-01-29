namespace Application {
public class DetailView : Gtk.ScrolledWindow{

    private ConfigFileReader configFileReader = new ConfigFileReader ();

    Gtk.Label packageInformation = new Gtk.Label ("Name Information");

    public DetailView(){
        add(packageInformation);
    }

    public void loadPackage(string packageName){
        packageInformation.set_label("");
        
        if(packageName != null){
            string packageString = configFileReader.getPackageByName(packageName);
            packageInformation.set_label(packageString);
        }
    }
}}
