namespace Application {
public class BookmarkListManager : Object {
    
    static BookmarkListManager? instance;

    private ListBox listBox;

    // Private constructor
    BookmarkListManager() {
        listBox = new ListBox ();
    }
 
    // Public constructor
    public static BookmarkListManager get_instance() {
        if (instance == null) {
            instance = new BookmarkListManager();
        }
        return instance;
    }

    public ListBox getList() {
        return this.listBox;
    }
}
}
