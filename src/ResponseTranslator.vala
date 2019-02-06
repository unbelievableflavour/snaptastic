namespace Application {
public class ResponseTranslator : Object {

    private SnapdHandler snapd_handler = new SnapdHandler ();

    public Package[] get_installed_packages () {
        Package[] packages = {};

        GLib.GenericArray<weak Snapd.Snap> snaps = snapd_handler.get_installed_packages ();

        snaps.foreach ((snap) => {
            packages += to_package (snap);
        });

        return packages;
    }

    public Package[] get_refreshable_packages () {
        Package[] packages = {};

        GLib.GenericArray<weak Snapd.Snap> snaps = snapd_handler.get_refreshable_packages ();

        snaps.foreach ((snap) => {
            packages += to_package (snap);
        });

        return packages;
    }

    public Package get_package_by_name (string search_word = "") {
        Snapd.Snap snap = snapd_handler.get_package_by_name (search_word);
        return to_package (snap);
    }

    public Package to_package (Snapd.Snap snap) {
        Package package = new Package ();
        package.set_name (snap.name);
        package.set_channel (snap.get_channel ());
        package.set_version (snap.get_version ());
        package.set_revision (snap.revision);
        package.set_developer (snap.get_publisher_username ());
        package.set_summary (snap.summary);
        package.set_description (snap.description);
        package.set_contact (snap.contact);
        if (snap.get_icon () != "" && snap.get_icon () != null) {
            package.set_icon (snap.get_icon ());
        }
        if ( snap.get_screenshots ().length != 0) {
            package.set_screenshots (snap.get_screenshots ());
        }
        return package;
    }
}
}
