using Snapd;

namespace Application {
public class Package : Object {

    private string nickname;

    private string name;
    private string channel = "";
    private string version;
    private string developer;
    private string revision;
    private string summary;
    private string description;
    private string contact;
    private string icon;
    Array<string> screenshots = new Array<string> ();

    public string get_nickname () {
        return this.nickname;
    }

    public void set_nickname (string nickname) {
        this.nickname = nickname;
    }

    public string get_name () {
        return this.name;
    }

    public void set_name (string name) {
        this.name = name;
    }

    public string get_channel () {
        return this.channel;
    }

    public void set_channel (string channel) {
        this.channel = channel;
    }

    public string get_version () {
        return this.version;
    }

    public void set_version (string version) {
        this.version = version;
    }

    public string get_revision () {
        return this.revision;
    }

    public void set_revision (string revision) {
        this.revision = revision;
    }

    public string get_developer () {
        return this.developer;
    }

    public void set_developer (string developer) {
        this.developer = developer;
    }

    public string get_summary () {
        return this.summary;
    }

    public void set_summary (string summary) {
        this.summary = summary;
    }

    public string get_description () {
        return this.description;
    }

    public void set_description (string description) {
        this.description = description;
    }

    public string get_contact () {
        return this.contact;
    }

    public void set_contact (string contact) {
        this.contact = contact;
    }

    public string get_icon () {
        return this.icon;
    }

    public void set_icon (string icon) {
        this.icon = icon;
    }

    public Array<string> get_screenshots () {
        return this.screenshots;
    }

    public void set_screenshots (GLib.GenericArray<Snapd.Screenshot> screenshots) {
        Array<string> screenshots_array = new Array<string> ();

        screenshots.foreach ((screenshot) => {
            screenshots_array.append_val (screenshot.get_url ());
        });

        this.screenshots = screenshots_array;
    }
}
}
