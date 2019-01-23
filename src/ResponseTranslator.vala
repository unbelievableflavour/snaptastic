namespace Application {
public class ResponseTranslator : Object {

    private SnapdHandler snapd_handler = new SnapdHandler ();

    public Package[] get_installed_packages () {
        Package[] packages = {};

        GLib.GenericArray<weak Snapd.Snap> snaps = snapd_handler.get_installed_packages ();

        snaps.foreach ((Snap) => {
            Package package = new Package ();
            package.set_name (Snap.name);
            package.set_channel (Snap.get_channel ());
            package.set_version (Snap.get_version ());
            package.set_revision (Snap.revision);
            package.set_developer (Snap.get_publisher_username ());
            package.set_summary (Snap.summary);
            package.set_description (Snap.description);
            package.set_contact (Snap.contact);

            var snap = snapd_handler.get_package_by_name (Snap.get_name ());
            if ( snap.get_icon () != "" && snap.get_icon () != null) {
                package.set_icon (snap.get_icon ());
            }

            if ( snap.get_screenshots ().length != 0) {
                package.set_screenshots (snap.get_screenshots ());
            }
            packages += package;
        });

        return packages;
    }

    public Package[] get_refreshable_packages () {
        Package[] packages = {};

        GLib.GenericArray<weak Snapd.Snap> snaps = snapd_handler.get_refreshable_packages ();

        snaps.foreach ((snap) => {
            Package package = new Package ();
            package.set_name (snap.name);
            package.set_version (snap.get_version ());
            package.set_revision (snap.revision);
            package.set_developer (snap.get_publisher_username ());
            package.set_summary (snap.summary);
            package.set_description (snap.description);
            package.set_contact (snap.contact);
            if ( snap.get_icon () != "" && snap.get_icon () != null) {
                package.set_icon (snap.get_icon ());
            }
            if ( snap.get_screenshots ().length != 0) {
                package.set_screenshots (snap.get_screenshots ());
            }
            packages += package;
        });

        return packages;
    }

    public Package get_package_by_name (string search_word = "") {

        Snapd.Snap snap = snapd_handler.get_package_by_name (search_word);

        Package package = new Package ();
        package.set_name (snap.name);
        package.set_version (snap.get_version ());
        package.set_revision (snap.revision);
        package.set_developer (snap.get_publisher_username ());
        package.set_summary (snap.summary);
        package.set_description (snap.description);
        package.set_contact (snap.contact);
        if (snap.get_icon () != "" || snap.get_icon () != null) {
            package.set_icon (snap.get_icon ());
        }
        if ( snap.get_screenshots ().length != 0) {
            package.set_screenshots (snap.get_screenshots ());
        }
        return package;
    }
}
}
