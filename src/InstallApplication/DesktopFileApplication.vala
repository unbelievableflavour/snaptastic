using Snapd;

namespace Application {
public class App {

    public static int main(string[] args) {
        string command = "";
        int count = 1;

        foreach (string arg in args) {
            if(count == 1){
                count++;
                continue;
            }
            command += arg + " ";
        }
        
        string option = args[1];
        string name = args[2];

        if(option == "remove"){
           deletePackage(name);
            return 0;
        }

        if(option == "install"){
           installPackage(name);
            return 0;
        }

        string result;
        string error;
        int status;

        try {
            Process.spawn_command_line_sync (command ,
								        out result,
								        out error,
								        out status);

            if(error != null && error != ""){
                stdout.printf("An error occured: " +error);
            }

        } catch (SpawnError e) {
            stdout.printf("An error occured: "+ e.message);
        }
        return 0;
    }

    public static void deletePackage(string name) {
        var client = new Snapd.Client();
              
        if (!client.connect_sync (null)){
            stdout.printf("Could not connect to snapd");
        }

        try{
            client.remove_sync (name,null, null);
        } catch (SpawnError e) {
            stdout.printf(e.message);
        }
    }

    public static void installPackage(string name) {
        var client = new Snapd.Client();
              
        if (!client.connect_sync (null)){
            stdout.printf("Could not connect to snapd");
        }

        try{
            client.install2_sync (InstallFlags.CLASSIC, name, null, null, null, null);
        } catch (SpawnError e) {
            stdout.printf(e.message);
        }
    }
}
}

