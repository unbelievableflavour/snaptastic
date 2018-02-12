using Snapd;

namespace Application {
public class SnapdHandler : Object {

    private Client client; 

    public SnapdHandler(){
        client = new Snapd.Client();
          
        if (!client.connect_sync (null)){
            new Alert("An error occured","could not connect to snapd");
        }
    }

    public GLib.GenericArray<weak Snapd.Snap> getInstalledPackages() {

        GLib.GenericArray<weak Snapd.Snap> snaps = client.list_sync (null);

        bool asc = true;
	    snaps.sort_with_data (( a, b) => {
		    return (asc)? strcmp (a.name, b.name) : strcmp (b.name, a.name);
	    });

        return snaps;
    }

    public GLib.GenericArray<weak Snapd.Snap> getRefreshablePackages() {

        GLib.GenericArray<weak Snapd.Snap> snaps = client.find_refreshable_sync (null);

        bool asc = true;
	    snaps.sort_with_data (( a, b) => {
		    return (asc)? strcmp (a.name, b.name) : strcmp (b.name, a.name);
	    });

        return snaps;
    }

    public Snapd.Snap getPackageByName(string searchWord = "") {

        try{
             GLib.GenericArray<weak Snapd.Snap> snaps = client.find_sync ( FindFlags.MATCH_NAME, searchWord, null, null);
            return snaps[0];
        } catch (Snapd.Error e) {
            new Alert("There was an error spawning the process. Details", e.message);
        }

        return null;
    }
}
}
