project('com.github.bartzaalberg.snaptastic', 'vala', 'c')

gnome = import('gnome')
i18n = import('i18n')

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name()), language:'c')

asresources = gnome.compile_resources(
    'as-resources', 'data/icons/icons.gresource.xml',
    source_dir: 'data/icons',
    c_name: 'as'
)

executable(
    meson.project_name(),
    'src/Application.vala',
    'src/MainWindow.vala',
    'src/ListBoxRow.vala',
    'src/InstalledPackageRow.vala',
    'src/IconHandler.vala',
    'src/ListBox.vala',
    'src/ResponseTranslator.vala',
    'src/FileManager.vala',
    'src/Constants.vala',
    'src/Package.vala',
    'src/CommandHandler.vala',
    'src/SnapdHandler.vala',
    'src/SnapdURIHandler.vala',
    'src/StackManager.vala',
    'src/Dialogs/DeleteConfirm.vala',
    'src/Dialogs/Alert.vala',
    'src/Views/ListView.vala',
    'src/Views/NotFoundView.vala',
    'src/Views/WelcomeView.vala',
    'src/Views/ProgressView.vala',
    'src/Views/DetailView.vala',
    'src/Components/HeaderBar.vala',
    'src/Components/HeaderLabel.vala',
    'src/Components/DetailViewBanner.vala',
    asresources,
    dependencies: [
        dependency('gtk+-3.0'),
        dependency('granite'),
        dependency('snapd-glib')
    ],
    install: true
)

executable(
    'com.github.bartzaalberg.snaptastic-wizard',
    'src/InstallApplication/DesktopFileApplication.vala',
    'src/SnapdURIHandler.vala',
    asresources,
    dependencies: [
        dependency('gtk+-3.0'),
        dependency('snapd-glib')
    ],
    install: true
)

subdir('data')
subdir('po')

python3 = import('python3').find_python()
run_command(python3, '-c', 'import shutil; shutil.copy("hooks/pre-commit.hook", ".git/hooks/pre-commit")')
