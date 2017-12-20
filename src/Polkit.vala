namespace Application {
public class Polkit : Object {

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
}
}
