#!/usr/bin/perl

# menutray - configuration file
# This file will be updated automatically every time when is needed.
# Any additional comment and/or indentation will be lost.

=for comment

|| FILTERING
    | skip_filename_re    : Skip a .desktop file if its name matches the regex.
                            Name is from the last slash to the end. (filename.desktop)
                            Example: qr/^(?:gimp|urxvt)\b/,    # skips 'gimp' and 'urxvt'

    | skip_entry          : Skip a destkop file if the value from a given key matches the regex.
                            Example: [
                                {key => 'Name', re => qr/(?:about|terminal)/i},
                                {key => 'Exec', re => qr/^urxvt/},
                            ],

    | substitutions       : Substitute, by using a regex, in the values of the desktop files.
                            Example: [
                                {key => 'Exec', re => qr/urxvt/, value => 'sakura'},
                                {key => 'Exec', re => qr/\\\\/,  value => '\\', global => 1},    # for wine apps
                            ],


|| ICON SETTINGS
    | icon_type           : Menu icon type (menu, small-toolbar, large-toolbar, button, dialog)
    | icon_size           : Icon size in pixels (only for absolute icon paths) (default: [16, 16])
    | missing_image       : Use this icon for missing icons (default: gtk-missing-image)


|| KEYS
    | tooltip_keys        : Valid keys for the tooltip text.
                            Example: ['Comment[es]', 'Comment'],

    | name_keys           : Valid keys for the item names.
                            Example: ['Name[fr]', 'GenericName[fr]', 'Name'],   # french menu


|| PATHS
    | desktop_files_paths   : Absolute paths which contains .desktop files.
                              Example: [
                                '/usr/share/applications',
                                '~/.local/share/applications',
                              ],


|| NOTES
    | Regular expressions:
        * use qr/RE/ instead of 'RE'
        * use qr/RE/i for case insenstive mode

=cut

our $CONFIG = {
  "editor"                 => "gvim",
  "gdk_interpolation_type" => "hyper",
  "icon_size"              => [22, 22],
  "icon_type"              => "menu",
  "Linux::DesktopFiles"    => {
                                desktop_files_paths     => ["/usr/share/applications", "/home/faruk/Desktop"],
                                keep_unknown_categories => 1,
                                skip_entry              => [
                                                             {
                                                               key => "Name",
                                                               re  => qr/(?^ui:(?:about|lxsession|lxsession-xdg-autostart|lxsession-xsettings|lxsession-default-apps|lxsession-edit|CMake|Caffeine|Autokey|Clipit|Redshift|Caja Dropbox|7-zip*|Avahi*|Root Terminal|urxvt|compton|Feh|Qt4 *|Qt As*|Qt Di*|Qt Li*|Qt QD*))/,
                                                             },
                                                             { key => "Exec", re => qr/(?^u:^nmcli_dmenu)/ },
                                                             { key => "Exec", re => qr/(?^u:^yelp)/ },
                                                             { key => "Exec", re => qr/(?^u:^lxsession)/ },
                                                             { key => "Exec", re => qr/(?^u:^gksu-properties)/ },
                                                             { key => "Exec", re => qr/(?^u:^ffado-mixer)/ },
                                                             { key => "Exec", re => qr/(?^u:^fluid)/ },
                                                           ],
                                skip_filename_re        => undef,
                                substitutions           => [
                                                             {
                                                               key => "Exec",
                                                               re => qr/(?^u:frogatto)/,
                                                               value => "/usr/bin/frogatto  --height 768 --width 1366 --widescreen --fullscreen",
                                                             },
                                                           ],
                                terminal                => "xterm-256color",
                                terminalization_format  => "%s -e '%s'",
                                terminalize             => 1,
                                unknown_category_key    => "other",
                              },
  "missing_image"          => "gtk-missing-image",
  "name_keys"              => ["Name[nl]", "Name"],
  "set_tooltips"           => 1,
  "tooltip_keys"           => ["Comment[nl]", "Comment"],
  "VERSION"                => 0.43,
}
