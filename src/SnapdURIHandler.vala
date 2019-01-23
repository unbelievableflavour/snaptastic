namespace Application {
public class SnapdURIHandler : Object {

    private string name = "";
    private string channel = "";

    public void set_parameters_from_uri (string name_and_channel) {
        string[] name_and_channel_array = name_and_channel.split ("/?");
        set_uri_name (name_and_channel_array[0]);
        string channel = name_and_channel_array[1];

        if (channel != null) {
            string[] url_parameter = channel.split ("=");
            if (url_parameter[0] == "channel") {;
                set_uri_channel (url_parameter[1]);
            }
        }
    }

    public string get_uri_name () {
        return this.name;
    }

    public void set_uri_name (string name) {
        this.name = name;
    }

    public string get_uri_channel () {
        return this.channel;
    }

    public void set_uri_channel (string channel) {
        this.channel = channel;
    }
}
}
