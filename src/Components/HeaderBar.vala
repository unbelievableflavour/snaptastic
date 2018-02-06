using Granite.Widgets;

namespace Application {
public class HeaderBar : Gtk.HeaderBar {
    
    static HeaderBar? instance;

    private StackManager stackManager = StackManager.get_instance();
    ListBox listBox = ListBox.get_instance();    
    public Gtk.Button return_button = new Gtk.Button ();
    private Granite.Widgets.ModeButton view_mode = new Granite.Widgets.ModeButton();

    HeaderBar() {
        Granite.Widgets.Utils.set_color_primary (this, Constants.BRAND_COLOR);
        
        generateViewMode();
        generateReturnButton();

        this.pack_start (return_button);
        this.show_close_button = true;
        this.set_custom_title(view_mode);
    }
 
    public static HeaderBar get_instance() {
        if (instance == null) {
            instance = new HeaderBar();
        }
        return instance;
    }

    private void generateViewMode(){
	    //Create two labels. Assign names for a check later on.
	    var label1 = new Gtk.Label("Home");
        label1.get_style_context().add_class("view-mode-button");
	    label1.name = "home";
            
	    var label2 = new Gtk.Label("Updates");
        label2.get_style_context().add_class("view-mode-button");
	    label2.name = "updates";
        
	    //Add each label to the Mode Button.
	    view_mode.append(label1);
	    view_mode.append(label2);

	    //Specify which button is active on initialization
	    view_mode.set_active(0);
        view_mode.margin = 1;
        view_mode.notify["selected"].connect (on_view_mode_changed);
    }

    private void generateReturnButton(){
        return_button.label = _("Back");
        return_button.no_show_all = true;
        return_button.get_style_context ().add_class ("back-button");
        return_button.visible = false;
        return_button.clicked.connect (() => {
            stackManager.getStack().visible_child_name = "list-view";
        });
    }

    public void showViewMode(bool answer){
        view_mode.visible = answer;
    }

    public void showReturnButton(bool answer){
        return_button.visible = answer;
    }

    public void setSelectedViewMode(int answer){
        view_mode.selected = answer;
    }

     private void on_view_mode_changed () {
        if (view_mode.selected == 0){
            stackManager.getStack().visible_child_name = "welcome-view";
        }else{
            stackManager.getStack().visible_child_name = "list-view";
            listBox.getInstalledPackages();
        }
    }
}
}
