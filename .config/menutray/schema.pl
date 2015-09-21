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

    #          COMMAND             LABEL                ICON
    {item => ['rofi -show run',  'Uitvoeren..',       'system-run']},
    {item => ['i3-sensible-terminal',         'Terminalvenster',          'terminal']},
    {item => ['gvim',        'Tekstverwerker', 'medit']},
    {item => ['chromium',      'Webbrowser',       'web-browser']},
    {item => ['geary',        'E-mailprogramma', 'internet-mail']},
    {item => ['xdotool key Super_L+backslash', 'Chromium-apps', 'chromium-app-list']}, 
    {item => ['caja --browser --no-desktop',       'Bestandsbeheerder',      'file-manager']},
    {item => ['mate-search-tool',         'Zoek bestanden..',    'tracker']},

#    {sep        => line},      
    {sep        => line},      

    #          NAME            LABEL                ICON
    {cat => ['utility',     'Hulpapps', 'gnome-util']},
    {cat => ['development', 'Ontwikkeling', 'applications-ide']},
    {cat => ['education',   'Educatie',   'applications-education']},
    {cat => ['game',        'Games',       'applications-games']},
    {cat => ['graphics',    'Grafisch',    'applications-photography']},
    {cat => ['audiovideo',  'Multimedia',  'gnome-multimedia']},
    {cat => ['network',     'Internet',     'gnome-globe']},
    {cat => ['office',      'Kantoor',      'package_office']},
    {cat => ['system',      'Systeem',      'package_system']},
#    {tree => [[
#              { Name => "name", Exec => "exec", Icon => "icon", },
#              ], 'Configuratie', 'code']},
    {cat => ['other',       'Instellingen',      'package_settings']},

    #{cat => ['qt',          'QT Applications',    'qtlogo']},
    #{cat => ['gtk',         'GTK Applications',   'gnome-applications']},
    #{cat => ['x_xfce',      'XFCE Applications',  'applications-other']},
    #{cat => ['gnome',       'GNOME Applications', 'gnome-applications']},
    #{cat => ['consoleonly', 'CLI Applications',   'applications-utilities']},
        
    {tree => [[
	     { Name => "Menu", Exec => "gvim ~/.config/menutray/menu.pl", Icon => "gtk-edit", },
             { Name => "Config", Exec => "gvim ~/.config/menutray/config.pl", Icon => "gtk-edit", },
             { Name => "Schema", Exec => "gvim ~/.config/menutray/schema.pl", Icon => "gtk-edit", },
             { Name => "Menutray", Exec => "gvim ~/.local/bin/menutray", Icon => "gtk-edit", },   
             { Name => "Reload", Exec => "pkill perl; menutray -r -i -u", Icon => "reload", },
	     { Name => "Exit", Exec => "pkill perl", Icon => "exit", },
	     ], 'Hoofdmenu', 'menutray']},
	     
    #{tree => [[
    #          { Name => "i3 Configuratiebestand", Exec => "gvim ~/.i3/config", Icon => "wmtweaks", },
	  #    { Name => "i3 Paneel instellen", Exec => "gvim ~/.i3status.conf", Icon => "panel", },              
	  #    { Name => "i3 Handleiding", Exec => "i3-msg workspace $WS2; exec chromium http://i3wm.org/docs/userguide.html", Icon => "help-browser", },
    #          ], 'i3 Vensterbeheer', 'window-manager']},

 #   {sep        => line},      
 # {sep        => line},      
    
    # {item => ['i3-msg workspace $WS2; exec chromium https://www.archlinux.org/', 'Over Arch Linux®', 'info']},    
   # {item => ['i3-msg workspace $WS2; exec chromium https://bbs.archlinux.org/', 'Arch Forums', 'users']},
   # {item => ['i3-msg workspace $WS2; exec chromium https://wiki.archlinux.org/', 'Arch Wiki','help-browser']},
     
  #  {sep        => line},      
    {sep        => line},      

  #  {regenerate => ['Opnieuw laden', 'reload']},
   # {exit       => ['Menu sluiten', 'exit']},
    {item => ['xdotool getactivewindow windowraise windowunmap',         'Sluiten ',          'gtk-close']},
    
    #{tree => [[
     #        { Name => "Afmelden", Exec => "i3-msg exit", Icon => "system-log-out", },
      #       { Name => "Vergrendelen", Exec => "i3lock -i /home/faruk/Afbeeldingen/lockscreen.png && sleep 1", Icon => "system-lock-screen", },
       #      { Name => "Pauzestand", Exec => "systemctl suspend", Icon => "system-suspend", },
        #     { Name => "Herstarten", Exec => "systemctl reboot", Icon => "system-reboot", },
         #    { Name => "Afsluiten", Exec => "systemctl poweroff", Icon => "system-shutdown", },
	     #], 'Afmelden..', 'system-log-out']},

    {item => ['yad_logout', 'Afsluiten..', 'window-close']},


]
