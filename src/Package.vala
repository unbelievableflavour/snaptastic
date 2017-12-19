namespace Application {
public class Package : Object {

    private string nickname;

    private string name;
    private string version;
    private string developer;
    private string revision;
    private string notes;
    private string summary;

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

    public string getNotes(){
        return this.notes;
    }

    public void setNotes(string notes){
        this.notes = notes;
    }

     public string getSummary(){
        return this.summary;
    }

    public void setSummary(string summary){
        this.summary = summary;
    }
}
}
