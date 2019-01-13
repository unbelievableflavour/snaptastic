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

	    string[] nameAndChannel = args[2].split ("/?");

        string name = nameAndChannel[0];
        string channel = nameAndChannel[1];

        if(channel != null) {
            string[] urlParameters = channel.split ("=");
            channel = urlParameters[1];
        } else {
            channel = "";
        }

        if(option == "remove"){
           deletePackage(name);
           return 0;
        }

        if(option == "install"){
           installPackage(name, channel);
           return 0;
        }

        if(option == "update"){
           updatePackage(name);
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

