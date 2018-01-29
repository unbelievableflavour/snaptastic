namespace Application {
public class FileManager : Object {

    static FileManager? instance;

    string filePath = "";

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

    public string getFilePath() {
        return this.filePath;
    }

   public void setFilePath(string path){
        this.filePath = (path);
    }
}
}
