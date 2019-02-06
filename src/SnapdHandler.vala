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

    public void update_installed_package_row (InstalledPackageRow installed_package_row) {
        client.find_async.begin ( FindFlags.MATCH_NAME, installed_package_row.package.get_name (), null, (obj, res) => {
                string std_out;
                try {
                    GLib.GenericArray<weak Snapd.Snap> snaps = client.find_async.end (res, out std_out);
                    Snap snap = snaps[0];
                    if (snap.get_icon () != "" && snap.get_icon () != null) {
                        installed_package_row.package.set_icon (snap.get_icon ());
                    }
                    if ( snap.get_screenshots ().length != 0) {
                        installed_package_row.package.set_screenshots (snap.get_screenshots ());
                    }
                    installed_package_row.load_package (installed_package_row.package);
                } catch (Snapd.Error e) {
                    stdout.printf ("An error occured in SnapdHandler: %s", e.message);
                    return;
                } catch (GLib.Error e) {
                    stdout.printf ("An error occured in SnapdHandler: %s", e.message);
                    return;
                }
        });
    }
}
}
