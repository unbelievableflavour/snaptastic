namespace Application {
public class Polkit : Object {

    private StackManager stackManager = StackManager.get_instance();

    string[] env = Environ.get ();
    string homeDir = Environment.get_home_dir ();

    public void deletePackage(Package deletedPackage) {

        string[] arguments = {
            "pkexec",
            "env",
            "HOME=" + homeDir,
            "com.github.bartzaalberg.snapcenter-install",
            "snap",
            "remove",
            deletedPackage.getName()
        };

        string output;
        string error;
        int status;

        try {
            Process.spawn_sync ("/", arguments, env, SpawnFlags.SEARCH_PATH, null, out output, out error, out status);

            if(error != null && error != ""){
                new Alert("There was an error in the spawned process", error);
            }
        } catch (SpawnError e) {
            new Alert("There was an error spawining the process. Details", e.message);
        }
    }

    public void installPackage(Package package) {

        string notes = "";
        if(package.getNotes() == "classic"){
            notes = "--classic";            
        }

        string[] arguments = {
            "pkexec", 
            "env", 
            "HOME=" + homeDir, 
            "com.github.bartzaalberg.snapcenter-install", 
            "snap", 
            "install", 
            package.getName(),
            notes
        };

        string output;
        string error;
        int status;

        try {
            Process.spawn_sync ("/", arguments, env, SpawnFlags.SEARCH_PATH, null, out output, out error, out status);

            if(error != null && error != ""){
                new Alert("There was an error in the spawned process", error);
            }
        } catch (SpawnError e) {
            new Alert("There was an error spawining the process. Details", e.message);
        }
    }

    public void updatePackage(Package package) {

        string notes = "";
        if(package.getNotes() == "classic"){
            notes = "--classic";            
        }

        string[] arguments = {
            "pkexec", 
            "env", 
            "HOME=" + homeDir, 
            "com.github.bartzaalberg.snapcenter-install", 
            "snap", 
            "refresh", 
            package.getName(),
            notes
        };

        string output;
        string error;
        int status;

        try {
            Process.spawn_sync ("/", arguments, env, SpawnFlags.SEARCH_PATH, null, out output, out error, out status);

            if(error != null && error != ""){
                new Alert("There was an error in the spawned process", error);
            }
        } catch (SpawnError e) {
            new Alert("There was an error spawining the process. Details", e.message);
        }
    }

    public string getInstalledPackages() {
        string result;
	    string error;
	    int status;

        try {
            Process.spawn_command_line_sync ("snap list",
								        out result,
								        out error,
								        out status);
            if(error != null && error != ""){
                new Alert("An error occured",error);
            }
        } catch (SpawnError e) {
            new Alert("An error occured", e.message);
        }

        return result;
    }

    public string getOnlinePackages(string searchWord = "") {
        string result;
	    string error;
	    int status;

        try {
            Process.spawn_command_line_sync ("snap search " + searchWord,
								        out result,
								        out error,
								        out status);

            if(error != null && error != ""){
                if("returned 0 snaps" in error){
                    stackManager.getStack().visible_child_name = "not-found-view";
                }else{
                    new Alert("An error occured",error);                
                }  
            }
        } catch (SpawnError e) {
            new Alert("An error occured", e.message);
        }

        return result;
    }
}
}
