using Snapd;

namespace Application {
public class CommandHandler : Object {

    private StackManager stackManager = StackManager.get_instance(); 
    string[] env = Environ.get ();
    string homeDir = Environment.get_home_dir ();

    public void deletePackage(Package package) {
        spawnAsync("remove", package.getName());
    }

    public void installPackage(Package package) {
        spawnAsync("install", package.getName());
    }

    public void updatePackage(Package package) {
        spawnAsync("update", package.getName());
    }

    public void spawnAsync(string option, string packageName){

        MainLoop loop = new MainLoop ();

        string[] arguments = {
            "pkexec",
            "env",
            "HOME=" + homeDir,
            "com.github.bartzaalberg.snaptastic-wizard",
            option,
            packageName
        };

        Pid child_pid;

        try {
            Process.spawn_async ("/",
    			arguments,
    			env,
    			SpawnFlags.SEARCH_PATH | SpawnFlags.DO_NOT_REAP_CHILD,
    			null,
    			out child_pid);

            ChildWatch.add (child_pid, (pid, status) => {
			    Process.close_pid (pid);
			    loop.quit ();
                ListBox listBox = ListBox.get_instance();
                listBox.getInstalledPackages();
		    });

        } catch (SpawnError e) {
            new Alert("There was an error spawning the process. Details", e.message);
        }
    }

    public void runPackage(string packageName) {

        string[] arguments = {
            "snap", 
            "run",
            packageName
        };

        Pid child_pid;

        try {
            Process.spawn_async ("/",
    			arguments,
    			env,
    			SpawnFlags.SEARCH_PATH | SpawnFlags.DO_NOT_REAP_CHILD,
    			null,
    			out child_pid);

        } catch (SpawnError e) {
            new Alert("There was an error spawning the process. Details", e.message);
        }
    }

    public string getPackageNameByFilePath(string searchWord = "") {

        string result;
	    string error;
	    int status;

        try {
            Process.spawn_command_line_sync ("snap info " + searchWord,
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

        string[] lines = result.split("\n");
	
    	string name = "";
        foreach (string line in lines) {
			if("name:" in line){
				string []resultString = line.split(":");
				name = resultString[1].strip();
				break;
			}
		}

        return name;
    }
}
}
