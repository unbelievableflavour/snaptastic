namespace Application {
public class Package : Object {

    private string nickname;

    private string name;
    private string channel;
    private string version;
    private string developer;
    private string revision;
    private string summary;
    private string description;
    private string contact;

    public string getNickname(){
        return this.nickname;
    }

    public void setNickname(string nickname){
        this.nickname = nickname;
    }

    public string getName(){
        return this.name;
    }

    public void setName(string name){
        this.name = name;    
    }

    public string getChannel(){
        return this.channel;
    }

    public void setChannel(string channel){
        this.channel = channel;
    }

    public string getVersion(){
        return this.version;
    }

    public void setVersion(string version){
        this.version = version;
    }

    public string getRevision(){
        return this.revision;
    }

    public void setRevision(string revision){
        this.revision = revision;
    }

    public string getDeveloper(){
        return this.developer;
    }

    public void setDeveloper(string developer){
        this.developer = developer;
    }

    public string getSummary(){
        return this.summary;
    }

    public void setSummary(string summary){
        this.summary = summary;
    }

    public string getDescription(){
        return this.description;
    }

    public void setDescription(string description){
        this.description = description;
    }

    public string getContact(){
        return this.contact;
    }

    public void setContact(string contact){
        this.contact = contact;
    }
}
}
