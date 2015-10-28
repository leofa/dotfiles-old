#!/usr/bin/perl

# menutray - schema file

=for comment
----------------------------------------------------------------------------------------------------
    item:       add an item inside the menu               {item => ['command', 'label', 'icon']},
    cat:        add a category inside the menu             {cat => ['name', 'label', 'icon']},
    sep:        horizontal line separator                  {sep => undef}
    raw:        any valid Perl code                        {raw => q(...)},
    tree:       custom category with items                {tree => [[{...}], 'label', 'icon']},
    begin_cat:  begin of a category                  {begin_cat => ['$var', 'name', 'icon']},
    end_cat:    end of a category                      {end_cat => '$var'},
    menutray:   generic menu settings                 {menutray => ['label', 'icon']},
    regenerate: regenerate menu                     {regenerate => ['label', 'icon']},
    exit:       quit menu                                 {exit => ['label', 'icon']},
    
    {tree => [[
              { Name => "name", Exec => "exec", Icon => "icon", },
              ], 'label', 'icon']},
----------------------------------------------------------------------------------------------------
=cut

# NOTE:
#    * Keys and values are case sensitive. Keep all keys lowercase.
#    * ICON can be a either a direct path to an icon or a valid icon name
#    * Category names are case insensitive. (X-XFCE and x_xfce are equivalent)


require "$ENV{HOME}/.config/menutray/config.pl";

our $SCHEMA = [

    #          COMMAND                  LABEL                ICON
    {item => ['rofi -show run',       'Uitvoeren..',       'system-run']},
    {item => ['i3-sensible-terminal', 'Terminalvenster',   'terminal']},
    {item => ['subl3',                'Tekstverwerker',    'text-editor']},
    {item => ['chromium',             'Webbrowser',        'web-browser']},
    {item => ['geary',                'E-mailprogramma',   'evolution']},
    {item => ['caja',                 'Bestandsbeheerder', 'system-file-manager']},
    {item => ['mate-search-tool',     'Zoek bestanden..',  'tracker']},

    {sep        => line},      

    #          NAME            LABEL                ICON
    {cat => ['utility',     'Hulpapps',     'gnome-util']},
    {cat => ['development', 'Ontwikkeling', 'applications-ide']},
    {cat => ['education',   'Educatie',     'applications-education']},
    {cat => ['game',        'Games',        'applications-arcade']},
    {cat => ['graphics',    'Grafisch',     'applications-photography']},
    {cat => ['audiovideo',  'Multimedia',   'gnome-multimedia']},
    {cat => ['network',     'Internet',     'gnome-globe']},
    {cat => ['other',       'Web-apps',     'applications-utilities']},
    {cat => ['office',      'Kantoor',      'package_office']},
    {cat => ['system',      'Systeem',      'package_system']},
    {cat => ['settings',    'Instellingen', 'package_settings']},
    
    # menutray submenu
    {tree => [[
                { Name => "Menu", Exec => "gvim ~/.config/menutray/menu.pl", Icon => "gtk-edit", },
                { Name => "Config", Exec => "gvim ~/.config/menutray/config.pl", Icon => "gtk-edit", },
                { Name => "Schema", Exec => "gvim ~/.config/menutray/schema.pl", Icon => "gtk-edit", },
                { Name => "Menutray", Exec => "gvim ~/.local/bin/menutray", Icon => "gtk-edit", },   
                # be warned killing all perl instances here
                { Name => "Reload", Exec => "pkill perl; menutray -r -i -u", Icon => "reload", }, 
	            { Name => "Exit", Exec => "pkill perl", Icon => "exit", },     
            ], 'Hoofdmenu', 'start-here']},
    
    # more menu's if you need them
    # i3 submenu    
    #{tree => [[
    #            { Name => "i3 Website", Exec => "chromium http://i3wm.org", Icon => "window-manager", },
    #            { Name => "i3 Config", Exec => "gvim ~/.i3/config", Icon => "wmtweaks", },
    #            { Name => "i3 Bar Config", Exec => "gvim ~/.i3blocks.conf", Icon => "panel", },              
    #            { Name => "i3 Userguide", Exec => "chromium http://i3wm.org/docs/userguide.html", Icon => "help-browser", },
    #        ], 'i3wm', 'window-manager']},

    #{sep        => line},      
    
    # arch submenu
    #{tree => [[
    #            { Name => "Arch Linux website", Exec => "chromium https://www.archlinux.org/", Icon => "archlinux", },    
    #            { Name => "Arch Forums", Exec => "chromium https://bbs.archlinux.org/", Icon => "users", },
    #            { Name => "Arch Wiki", Exec => "chromium https://wiki.archlinux.org/", Icon => "help-browser" },
    #            { Name => "Arch AUR", Exec => "chromium https://aur.archlinux.org/", Icon => "package" },
    #        ], 'Arch Linux', 'info']},
     
    {sep        => line},      

    # close window
    # {item => ['xdotool getactivewindow windowraise windowunmap', 'Sluiten ', 'gtk-close']},
    # reload inplace
    {item => ['sh -c "i3-msg restart; pkill perl && menutray -r -i -u"', 'Vernieuwen', 'reload']},
    # logout dialog
    {item => ['yad_logout', 'Afsluiten..', 'window-close']},

]
