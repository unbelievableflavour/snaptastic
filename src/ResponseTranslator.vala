namespace Application {
public class ResponseTranslator : Object{

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
            package.setDescription(Snap.description);
            package.setContact(Snap.contact);
            package.setIcon(Snap.icon);

            packages += package;
    	});

        return packages;
    }

    public Package[] getRefreshablePackages (){
        Package[] packages = {};

        GLib.GenericArray<weak Snapd.Snap> snaps = snapdHandler.getRefreshablePackages();

        snaps.foreach ((Snap) => {
            Package package = new Package();
            package.setName(Snap.name);
            package.setVersion(Snap.get_version());
            package.setRevision(Snap.revision);
            package.setDeveloper(Snap.get_developer());
            package.setSummary(Snap.summary);
            package.setDescription(Snap.description);
            package.setContact(Snap.contact);
            package.setIcon(Snap.icon);

            packages += package;
    	});

        return packages;
    }

    public Package getPackageByName (string searchWord = ""){

        Snapd.Snap snap = snapdHandler.getPackageByName(searchWord);

        Package package = new Package();
        package.setName(snap.name);
        package.setVersion(snap.get_version());
        package.setRevision(snap.revision);
        package.setDeveloper(snap.get_developer());
        package.setSummary(snap.summary);
        package.setDescription(snap.description);
        package.setContact(snap.contact);
        package.setIcon(snap.icon);
        return package;
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

        return "";
    }
}
}
