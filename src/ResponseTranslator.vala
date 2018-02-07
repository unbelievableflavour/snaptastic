namespace Application {
public class ResponseTranslator : Object{

    private CommandHandler commandHandler = new CommandHandler();
    private SnapdHandler snapdHandler = new SnapdHandler();

    public Package[] getInstalledPackages (){
        Package[] packages = {};

        GLib.GenericArray<weak Snapd.Snap> snaps = snapdHandler.getInstalledPackages();

        snaps.foreach ((Snap) => {
            Package package = new Package();
            package.setName(Snap.name);
            package.setVersion(Snap.get_version());
            package.setRevision(Snap.revision);
            package.setDeveloper(Snap.get_developer());
            package.setSummary(Snap.summary);
            package.setNotes("classic");
            packages += package;
    	});

        return packages;
    }

    public string getPackageName(string[] splittedLine){
        foreach (string part in splittedLine) {
            if(part == ""){
                continue;
            }
            return part;
        }
        return splittedLine[0];
    }

    public string getStringByIndex(string[] splittedLine, int index){
        var elementsCount = 0;

        foreach (string part in splittedLine) {
            if(part == ""){
                continue;  
            }          

            if(elementsCount == index ) {
                return part;
            }
            elementsCount++;
        }

        return "bla";
    }
}
}
