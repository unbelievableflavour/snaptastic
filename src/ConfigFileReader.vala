namespace Application {
public class ConfigFileReader : Object{

    private StackManager stackManager = StackManager.get_instance();

    public Package[] getInstalledPackages (){
        Package[] packages = {};
        
        string result;
	    string error;
	    int status;

        try {
            Process.spawn_command_line_sync ("snap list",
								        out result,
								        out error,
								        out status);
            if(error != null && error != ""){
                new Alert("An error occured",error);
            }
        } catch (SpawnError e) {
            new Alert("An error occured", e.message);
        }

        string[] linesx = result.split("\n");
        foreach (string line in linesx) {
            var splittedLine = line.split(" ");
            string name = getPackageName(splittedLine);
            string version = getPackageVersion(splittedLine);
            string revision = getPackageRevision(splittedLine);
            string developer = getPackageDeveloper(splittedLine);
            string notes = getPackageNotes(splittedLine);

            if(name == null){continue;}
            if(name == "Name" && version == "Version"){continue;}

            Package package = new Package();
            package.setName(name);
            package.setVersion(version);
            package.setRevision(revision);
            package.setDeveloper(developer);
            package.setNotes(notes);
            packages += package;
        }
        return packages;
    }

    public Package[] getOnlinePackages (string searchWord){
        Package[] packages = {};
        
        string result;
	    string error;
	    int status;

        try {
            Process.spawn_command_line_sync ("snap search " + searchWord,
								        out result,
								        out error,
								        out status);

            if(error != null && error != ""){
                if("returned 0 snaps" in error){
                    stackManager.getStack().visible_child_name = "not-found-view";
                }else{
                    new Alert("An error occured",error);                
                }
                
            }

        } catch (SpawnError e) {
            new Alert("An error occured", e.message);
        }

        string[] linesx = result.split("\n");
        foreach (string line in linesx) {
            var splittedLine = line.split(" ");
            string name = getPackageName(splittedLine);
            string version = getPackageVersion(splittedLine);
            string developer = getPackageRevision(splittedLine);
            string notes = getPackageDeveloper(splittedLine);
            string summary = getPackageSummary(splittedLine);

            if(name == null){continue;}
            if(name == "Name" && version == "Version"){continue;}

            Package package = new Package();
            package.setName(name);
            package.setVersion(version);
            package.setDeveloper(developer);
            package.setNotes(notes);
            package.setSummary(summary);
            packages += package;
        }
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

    public string getPackageVersion(string[] splittedLine){
        var elementsCount = 0;

        foreach (string part in splittedLine) {
            if(part == ""){
                continue;  
            }          

            if(elementsCount == 1 ) {
                return part;
            }
            elementsCount++;
        }

        return "bla";
    }

    public string getPackageDeveloper(string[] splittedLine){
        var elementsCount = 0;

        foreach (string part in splittedLine) {
            if(part == ""){
                continue;  
            }          

            if(elementsCount == 3 ) {
                return part;
            }
            elementsCount++;
        }

        return "bla";
    }

    public string getPackageRevision(string[] splittedLine){
        var elementsCount = 0;

        foreach (string part in splittedLine) {
            if(part == ""){
                continue;  
            }          

            if(elementsCount == 2 ) {
                return part;
            }
            elementsCount++;
        }

        return "bla";
    }

    public string getPackageNotes(string[] splittedLine){
        var elementsCount = 0;

        foreach (string part in splittedLine) {
            if(part == ""){
                continue;  
            }          

            if(elementsCount == 1 ) {
                return part;
            }
            elementsCount++;
        }

        return "bla";
    }

    public string getPackageSummary(string[] splittedLine){
        var elementsCount = 0;

        foreach (string part in splittedLine) {
            if(part == ""){
                continue;  
            }          

            if(elementsCount == 4 ) {
                return part;
            }
            elementsCount++;
        }

        return "bla";
    }
}
}
