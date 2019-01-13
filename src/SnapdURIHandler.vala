namespace Application {
public class SnapdURIHandler : Object {

    private string name = "";
    private string channel = "";

    public void setParametersFromURI(string nameAndChannel){
        string[] nameAndChannelArray = nameAndChannel.split ("/?");
        setURIName(nameAndChannelArray[0]);
        string channel = nameAndChannelArray[1];

        if(channel != null) {
            string[] urlParameter = channel.split ("=");
            if(urlParameter[0] == "channel"){;
                setURIChannel(urlParameter[1]);
            }
        }
    }

    public string getURIName(){
        return this.name;
    }

    public void setURIName(string name){
        this.name = name;
    }

    public string getURIChannel(){
        return this.channel;
    }

    public void setURIChannel(string channel){
        this.channel = channel;
    }
}
}
