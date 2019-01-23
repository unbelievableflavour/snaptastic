using Snapd;

namespace Application {
public class SnapdHandler : Object {

    private Client client;

    public SnapdHandler () {
        client = new Snapd.Client ();

        try {
            if (!client.connect_sync (null)) {
                new Alert ("An error occured","could not connect to snapd");
            }
        } catch (GLib.Error e) {
            new Alert ("An error occured",e.message);
        }
    }

    public GLib.GenericArray<weak Snapd.Snap> get_installed_packages () {
        GLib.GenericArray<weak Snapd.Snap> snaps = new GLib.GenericArray<weak Snapd.Snap> ();

        try {

            snaps = client.get_snaps_sync (Snapd.GetSnapsFlags.NONE, null, null);

            bool asc = true;
            snaps.sort_with_data (( a, b) => {
                return (asc)? strcmp (a.name, b.name) : strcmp (b.name, a.name);
            });
        } catch (GLib.Error e) {
            new Alert ("An error occured",e.message);
        }

        return snaps;
    }

    public GLib.GenericArray<weak Snapd.Snap> get_refreshable_packages () {
        GLib.GenericArray<weak Snapd.Snap> snaps = new GLib.GenericArray<weak Snapd.Snap> ();

        try {
            snaps = client.find_refreshable_sync (null);

            bool asc = true;
            snaps.sort_with_data (( a, b) => {
                return (asc)? strcmp (a.name, b.name) : strcmp (b.name, a.name);
            });
        } catch (GLib.Error e) {
            new Alert ("An error occured",e.message);
        }

        return snaps;
    }

    public Snapd.Snap get_package_by_name (string search_word = "") {
        GLib.GenericArray<weak Snapd.Snap> snaps = new GLib.GenericArray<weak Snapd.Snap> ();

        try {
            snaps = client.find_sync ( FindFlags.MATCH_NAME, search_word, null, null);
        } catch (GLib.Error e) {
            new Alert ("There was an error spawning the process. Details", e.message);
        }

        return snaps.length != 0 ? snaps[0] : null;
    }
}
}
