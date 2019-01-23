using Snapd;

namespace Application {
public class CommandHandler : Object {

    private StackManager stack_manager = StackManager.get_instance ();
    string[] env = Environ.get ();
    string home_dir = Environment.get_home_dir ();

    public void delete_package (Package package) {
        spawn_async ("remove", package.get_name ());
    }

    public void install_package (Package package) {
        if (package.get_channel () != "") {
            spawn_async ("install", package.get_name () + "/?channel=" + package.get_channel ());
        } else {
            spawn_async ("install", package.get_name ());
        }
    }

    public void update_package (Package package) {
        spawn_async ("update", package.get_name ());
    }

    public void spawn_async (string option, string package_name) {

        MainLoop loop = new MainLoop ();

        string[] arguments = {
            "pkexec",
            "env",
            "HOME=" + home_dir,
            "com.github.bartzaalberg.snaptastic-wizard",
            option,
            package_name
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
                ListBox list_box = ListBox.get_instance ();
                list_box.get_installed_packages ();
            });

        } catch (SpawnError e) {
            new Alert ("There was an error spawning the process. Details", e.message);
        }
    }

    public void run_package (string package_name) {
        string[] arguments = {
            "snap",
            "run",
            package_name
        };

        try {
            Process.spawn_async ("/",
                arguments,
                env,
                SpawnFlags.SEARCH_PATH | SpawnFlags.DO_NOT_REAP_CHILD,
                null,
                null);

        } catch (SpawnError e) {
            new Alert ("There was an error spawning the process. Details", e.message);
        }
    }

    public string get_package_name_by_file_path (string search_word = "") {

        string result;
        string error;
        int status;

        try {
            Process.spawn_command_line_sync ("snap info " + search_word,
                                        out result,
                                        out error,
                                        out status);

            if (error != null && error != "") {
                if ("returned 0 snaps" in error) {
                    stack_manager.get_stack ().visible_child_name = "not-found-view";
                }else {
                    new Alert ("An error occured",error);
                }
            }
        } catch (SpawnError e) {
            new Alert ("An error occured", e.message);
        }

        string[] lines = result.split ("\n");

        string name = "";
        foreach (string line in lines) {
            if ("name:" in line) {
                string []resultString = line.split (":");
                name = resultString[1].strip ();
                break;
            }
        }

        return name;
    }
}
}
