namespace Application {
public class StackManager : Object {
    
    static StackManager? instance;

    private Gtk.Stack stack;
    private const string LIST_VIEW_ID = "list-view";
    private const string EMPTY_VIEW_ID = "empty-view";
    private const string NOT_FOUND_VIEW_ID = "not-found-view";
    private const string WELCOME_VIEW_ID = "welcome-view";
    private const string PROGRESS_VIEW_ID = "progress-view";

    // Private constructor
    StackManager() {
        stack = new Gtk.Stack ();
        stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT_RIGHT;
    }
 
    // Public constructor
    public static StackManager get_instance() {
        if (instance == null) {
            instance = new StackManager();
        }
        return instance;
    }

    public Gtk.Stack getStack() {
        return this.stack;
    }

    public void loadViews(Gtk.Window window){
        stack.add_named (new ListView(), LIST_VIEW_ID);
        stack.add_named (new NotFoundView(), NOT_FOUND_VIEW_ID);
        stack.add_named (new WelcomeView(), WELCOME_VIEW_ID);
        stack.add_named (new ProgressView(), PROGRESS_VIEW_ID);

        window.add(stack);
        window.show_all();
   }
}
}
