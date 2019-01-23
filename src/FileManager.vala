namespace Application {
public class FileManager : Object {

    static FileManager? instance;

    File file = null;

    FileManager () {
    }

    public static FileManager get_instance () {
        if (instance == null) {
            instance = new FileManager ();
        }
        return instance;
    }

    public File get_file () {
        return this.file;
    }

    public void set_file (File new_file) {
        this.file = new_file;
    }

    public bool file_exists (string file_path) {
        var file = File.new_for_path (file_path);
        return file.query_exists ();
    }
}
}
