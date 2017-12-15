namespace Application {
public class Bookmark : Object {

    private string nickname;

    private string name;
    private string version;
    private string developer;
    private string revision;
    private string notes;

    private string ip;
    private string user;
    private int port;
    private string forwardAgent;
    private string proxyCommand;

    private int serverAliveInterval;
    private string logLevel;
    private string strictHostKeyChecking;
    private string userKnownHostsFile;
    private string visualHostKey;
    private string compression;

    private string localForward;
    private string remoteForward;
    private string dynamicForward;
    private string forwardX11;

    private string identityFile;
    private string identitiesOnly;

    private string controlMaster;
    private string controlPath;
    private string controlPersist;

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


















    public string getIp(){
        return this.ip;    
    }

    public void setIp(string ip){
        this.ip = ip;
    }
    
    public string getUser(){
        return this.user;    
    }

    public void setUser(string user){
        this.user = user;    
    }

    public int getPort(){
        return this.port;    
    }

    public void setPort(int port){
        this.port = port;    
    }

    public string getForwardAgent(){
        return this.forwardAgent;    
    }

    public void setForwardAgent(string forwardAgent){
        this.forwardAgent = forwardAgent;    
    }

    public string getProxyCommand(){
        return this.proxyCommand;    
    }

    public void setProxyCommand(string proxyCommand){
        this.proxyCommand = proxyCommand;    
    }

    public int getServerAliveInterval(){
        return this.serverAliveInterval;    
    }

    public void setServerAliveInterval(int serverAliveInterval){
        this.serverAliveInterval = serverAliveInterval;
    }

    public string getLogLevel(){
        return this.logLevel;    
    }

    public void setLogLevel(string logLevel){
        this.logLevel = logLevel;    
    }

    public string getStrictHostKeyChecking(){
        return this.strictHostKeyChecking;    
    }

    public void setStrictHostKeyChecking(string strictHostKeyChecking){
        this.strictHostKeyChecking = strictHostKeyChecking;    
    }

    public string getUserKnownHostsFile(){
        return this.userKnownHostsFile;    
    }

    public void setUserKnownHostsFile(string userKnownHostsFile){
        this.userKnownHostsFile = userKnownHostsFile;    
    }

    public string getVisualHostKey(){
        return this.visualHostKey;    
    }

    public void setVisualHostKey(string visualHostKey){
        this.visualHostKey = visualHostKey;    
    }

    public string getCompression(){
        return this.compression;    
    }

    public void setCompression(string compression){
        this.compression = compression;    
    }

    public string getLocalForward(){
        return this.localForward;    
    }

    public void setLocalForward(string localForward){
        this.localForward = localForward;    
    }

    public string getRemoteForward(){
        return this.remoteForward;    
    }

    public void setRemoteForward(string remoteForward){
        this.remoteForward = remoteForward;    
    }

    public string getDynamicForward(){
        return this.dynamicForward;    
    }

    public void setDynamicForward(string dynamicForward){
        this.dynamicForward = dynamicForward;    
    }

    public string getForwardX11(){
        return this.forwardX11;    
    }

    public void setForwardX11(string forwardX11){
        this.forwardX11 = forwardX11;    
    }

    public string getIdentityFile(){
        return this.identityFile;    
    }

    public void setIdentityFile(string identityFile){
        this.identityFile = identityFile;    
    }

    public string getIdentitiesOnly(){
        return this.identitiesOnly;    
    }

    public void setIdentitiesOnly(string identitiesOnly){
        this.identitiesOnly = identitiesOnly;
    }

    public string getControlMaster(){
        return this.controlMaster;
    }

    public void setControlMaster(string controlMaster){
        this.controlMaster = controlMaster;
    }

    public string getControlPath(){
        return this.controlPath;
    }

    public void setControlPath(string controlPath){
        this.controlPath = controlPath;
    }

    public string getControlPersist(){
        return this.controlPersist;
    }

    public void setControlPersist(string controlPersist){
        this.controlPersist = controlPersist;
    }
}
}
