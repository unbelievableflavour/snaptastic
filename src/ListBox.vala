using Granite.Widgets;

namespace Application {
public class ListBox : Gtk.ListBox{

    static ListBox? instance;

    private ConfigFileReader configFileReader = new ConfigFileReader ();
    private StackManager stackManager = StackManager.get_instance();

    ListBox() {
    }
 
    public static ListBox get_instance() {
        if (instance == null) {
            instance = new ListBox();
        }
        return instance;
    }

    public void emptyList(){
        this.foreach ((ListBoxRow) => {
            this.remove(ListBoxRow);
        }); 
    }

    public void getBookmarks(string searchWord = ""){
        emptyList();

        HeaderBar.get_instance().searchEntry.sensitive = true;
        HeaderBar.get_instance().showReturnButton(false);

        stackManager.getStack().visible_child_name = "list-view";

        var bookmarks = configFileReader.getBookmarks();

        foreach (Bookmark bookmark in bookmarks) {
            if(searchWord == ""){
                add (new ListBoxRow (bookmark));
                continue;
            }

            if(searchWord in bookmark.getName()){             
                add (new ListBoxRow (bookmark));
            }            
        }

        show_all();
    }

    public void getOnlinePackages(string searchWord = ""){
        emptyList();

        HeaderBar.get_instance().searchEntry.sensitive = true;
        HeaderBar.get_instance().showReturnButton(false);

        stackManager.getStack().visible_child_name = "list-view";

        var bookmarks = configFileReader.getOnlinePackages(searchWord);

        foreach (Bookmark bookmark in bookmarks) {             
            add (new ListBoxRow (bookmark));
        }

        show_all();
    }

    private bool listisEmpty(Bookmark[] bookmarks){
        return bookmarks.length == 0;    
    }

    private bool searchWordDoesntMatchAnyInList(string searchWord, Bookmark[] bookmarks){
        int matchCount = 0;
        
        if(searchWord == ""){
            return false;
        }

        foreach (Bookmark bookmark in bookmarks) {
            if(searchWord in bookmark.getName()){
                matchCount++;                
            }                
        }
        return matchCount == 0;    
    }
}
}
