using Snapd;

namespace Application {
public class App {

    private static Client client; 

    public static int main(string[] args) {

        client = new Snapd.Client();

        if (!client.connect_sync (null)){
            stdout.printf("Could not connect to snapd");
            return 0;
        }

        string option = args[1];
        var snapdURIHandler = new SnapdURIHandler();
        snapdURIHandler.setParametersFromURI(args[2]);

        if(option == "remove"){
           deletePackage(snapdURIHandler.getURIName());
           return 0;
        }

        if(option == "install"){
           installPackage(snapdURIHandler.getURIName(), snapdURIHandler.getURIChannel());
           return 0;
        }

        if(option == "update"){
           updatePackage(snapdURIHandler.getURIName());
           return 0;
        }

        return 0;
    }

    public static void deletePackage(string name) {
        try{
            client.remove_sync (name,null, null);
        } catch (SpawnError e) {
            stdout.printf(e.message);
        }
    }

    public static void installPackage(string name, string channel) {
        try{
            client.install2_sync (
                InstallFlags.CLASSIC,
                name, 
                channel != "" ? channel : null,
                null, null, null);
        } catch (SpawnError e) {
            stdout.printf(e.message);
        }
    }

    public static void updatePackage(string name) {
        try{
            client.refresh_sync (name, null, null, null);
        } catch (SpawnError e) {
            stdout.printf(e.message);
        }
    }
}
}

