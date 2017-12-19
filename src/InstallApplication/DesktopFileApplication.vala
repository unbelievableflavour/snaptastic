namespace BookmarkManager {
public class App:Application{


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

        stdout.printf(command);
        
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
}
}

