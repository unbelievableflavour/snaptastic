namespace Application {
public class StackManager : Object {

    static StackManager? instance;

    private Gtk.Stack stack;
    private const string LIST_VIEW_ID = "list-view";
    private const string EMPTY_VIEW_ID = "empty-view";
    private const string NOT_FOUND_VIEW_ID = "not-found-view";
    private const string WELCOME_VIEW_ID = "welcome-view";
    private const string PROGRESS_VIEW_ID = "progress-view";
    private const string DETAIL_VIEW_ID = "detail-view";

    DetailView detail_view;
    public Gtk.Window main_window;

    StackManager () {
        stack = new Gtk.Stack ();
        stack.margin_bottom = 4;
        stack.transition_type = Gtk.StackTransitionType.SLIDE_LEFT_RIGHT;
    }

    public static StackManager get_instance () {
        if (instance == null) {
            instance = new StackManager ();
        }
        return instance;
    }

    public Gtk.Stack get_stack () {
        return this.stack;
    }

    public void load_views (Gtk.Window window) {
        detail_view = new DetailView ();
        main_window = window;

        stack.add_named (new ListView (), LIST_VIEW_ID);
        stack.add_named (new NotFoundView (), NOT_FOUND_VIEW_ID);
        stack.add_named (new WelcomeView (), WELCOME_VIEW_ID);
        stack.add_named (new ProgressView (), PROGRESS_VIEW_ID);
        stack.add_named (detail_view, DETAIL_VIEW_ID);

        stack.notify["visible-child"].connect (() => {
            var header_bar = HeaderBar.get_instance ();

            if (stack.get_visible_child_name () == WELCOME_VIEW_ID) {
                header_bar.show_view_mode (true);
                header_bar.set_selected_view_mode (0);
                header_bar.show_return_button (false);
            }

            if (stack.get_visible_child_name () == DETAIL_VIEW_ID) {
                header_bar.show_view_mode (false);
                header_bar.show_return_button (true);
            }

            if (stack.get_visible_child_name () == PROGRESS_VIEW_ID) {
                header_bar.show_view_mode (false);
                header_bar.show_return_button (false);
            }

            if (stack.get_visible_child_name () == LIST_VIEW_ID) {
                header_bar.show_view_mode (true);
                header_bar.set_selected_view_mode (1);
                header_bar.show_return_button (false);
            }
        });

        window.add (stack);
   }

   public void set_detail_package (Package package) {
        detail_view.load_package (package);
   }
}
}
