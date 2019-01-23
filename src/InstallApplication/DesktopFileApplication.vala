using Snapd;

namespace Application {
public class App {

    private static Client client;

    public static int main (string[] args) {

        client = new Snapd.Client ();

        if (!client.connect_sync (null)) {
            stdout.printf ("Could not connect to snapd");
            return 0;
        }

        string option = args[1];
        var snapd_uri_handler = new SnapdURIHandler ();
        snapd_uri_handler.set_parameters_from_uri (args[2]);

        if (option == "remove") {
           delete_package (snapd_uri_handler.get_uri_name ());
           return 0;
        }

        if (option == "install") {
           install_package (snapd_uri_handler.get_uri_name (), snapd_uri_handler.get_uri_channel ());
           return 0;
        }

        if (option == "update") {
           update_package (snapd_uri_handler.get_uri_name ());
           return 0;
        }

        return 0;
    }

    public static void delete_package (string name) {
        try {
            client.remove_sync (name,null, null);
        } catch (SpawnError e) {
            stdout.printf (e.message);
        }
    }

    public static void install_package (string name, string channel) {
        try {
            client.install2_sync (
                InstallFlags.CLASSIC,
                name,
                channel != "" ? channel : null,
                null, null, null);
        } catch (SpawnError e) {
            stdout.printf (e.message);
        }
    }

    public static void update_package (string name) {
        try {
            client.refresh_sync (name, null, null, null);
        } catch (SpawnError e) {
            stdout.printf (e.message);
        }
    }
}
}

