using Snapd;

namespace Application {
public class SnapdHandler : Object {

    private StackManager stackManager = StackManager.get_instance(); 
    string[] env = Environ.get ();
    string homeDir = Environment.get_home_dir ();

    public GLib.GenericArray<weak Snapd.Snap> getInstalledPackages() {

        var client = new Snapd.Client();
          
        if (!client.connect_sync (null)){
            new Alert("An error occured","could not connect to snapd");
        }

        GLib.GenericArray<weak Snapd.Snap> snaps = client.list_sync (null);

        bool asc = true;
	    snaps.sort_with_data (( a, b) => {
		    return (asc)? strcmp (a.name, b.name) : strcmp (b.name, a.name);
	    });

        return snaps;
    }

    public void getPackageByName() {

        var client = new Snapd.Client();
        
        if (!client.connect_sync (null)){
            new Alert("An error occured","could not connect to snapd");
        }

        GLib.GenericArray<weak Snapd.Snap> array = client.find_sync ( FindFlags.NONE, "vlc", null, null);

        array.foreach ((Snap) => {
    		stdout.printf ("%s\n", Snap.name);
    	});
    }
}
}
