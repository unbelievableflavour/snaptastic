namespace Application {
public class FileManager : Object {

    static FileManager? instance;

    File file = null;

    // Private constructor
    FileManager() {
    }
 
    // Public constructor
    public static FileManager get_instance() {
        if (instance == null) {
            instance = new FileManager();
        }
        return instance;
    }

    public File getFile() {
        return this.file;
    }

    public void setFile(File newFile){
        this.file = newFile;
    }
}
}
