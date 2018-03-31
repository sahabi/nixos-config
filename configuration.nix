# Edit this configuration file which defines what would be installed on the
# system.  To Help while choosing option value, you can watch at the manual
# page of configuration.nix or at the last chapter of the manual available
# on the virtual console 8 (Alt+F8).

{ pkgs, ... }:

{
  require = [
    ./hardware-configuration.nix
  ];

  environment = {

    # To also get the header files in the system environment. You only need
    # this if you want compile non-nixos stuff against the system environment.
    # You would only want that as a part of temporary solution to continue on
    # whatever you were working before christmas. However, there are better
    # ways. See https://github.com/chaoflow/nixos-configurations for more on
    # that.
    #pathsToLink = ["include"];

    # shellInit = ''
    #   export GEM_PATH=/var/run/current-system/sw/${pkgs.ruby.gemPath}
    #   export RUBYLIB=/var/run/current-system/sw/lib
    #   export RUBYOPT=rubygems
    # '';

    systemPackages = with pkgs; [
      acpitool
      alsaLib
      alsaPlugins
      (import ./vim.nix)
      (import ./mem.nix)
      (import ./usb.nix)
      (import ./bitcoin-price.nix)
      (import ./lnd.nix)
      (import ./trezor-bridge.nix)
      alsaUtils
      cpufrequtils
      cryptsetup
      ddrescue
      dmenu
      file
      haskellPackages.hlint
      bashmount
      hdparm
      htop
      jq
      keychain
      sdparm
      xscreensaver
      zsh
          ant
          autoconf
          automake
          bazaar
          bazaarTools
          bc
          cmake
          colordiff
          cvs
          cvsps
          firefox
          gcc
          gdb
          geeqie
          ghostscript
          gimp
          gitAndTools.gitFull
          gitAndTools.svn2git
          gitAndTools.tig
          gnome3.gnome_terminal
          gnupg
          gnupg1
          gnumake
          gperf
          graphviz
          guile
          imagemagick
          i3status
          io
          irssi
          jscoverage
          jwhois
          links2
          lsof
          lua5
          lxdvdrip
          lynx
          man
          mdbtools
          mercurial
          ncftp
          netcat
          nmap
          openvpn
          p7zip
          parted
          pinentry
          powertop
          pwgen
          qrencode
          rtorrent
          ruby
          screen
          stdmanpages
          subversion
          taskwarrior
          tcpdump
          telnet
          tmux
          units
          unzip
          vim
          vlc
          w3m
          wget
          zip
          gv
          glxinfo
          mplayer
          rxvt_unicode
          qemu_kvm
          scrot
          unetbootin
          xlockmore
          xorg.xkill
          xpdf

      haskellPackages.xmonad
      haskellPackages.xmonad-contrib
      haskellPackages.xmobar
      stalonetray
      stack
      thunderbird
      wpa_supplicant_gui
      xfontsel
      xlibs.xev
      xlibs.xinput
      xlibs.xmessage
      xlibs.xmodmap
    ];
  };
  services.udev = {
    extraRules = ''
    SUBSYSTEM=="usb", ATTR{idVendor}=="534c", ATTR{idProduct}=="0001", MODE="0666", GROUP="dialout", SYMLINK+="trezor%n"
    KERNEL=="hidraw*", ATTRS{idVendor}=="534c", ATTRS{idProduct}=="0001",  MODE="0666", GROUP="dialout"
    '' ;
  };
  # XXX: add more fonts!
  fonts = {
    enableCoreFonts = true;
    enableFontDir = true;
    enableGhostscriptFonts = false;

    # terminus I use for rxvt-unicode
    # see https://github.com/chaoflow/chaoflow.skel.home/blob/master/.Xdefaults
    fonts = [
       #pkgs.cantarell_fonts
       #pkgs.dejavu_fonts
       #pkgs.dosemu_fonts
       #pkgs.freefont_ttf
       #pkgs.liberation_ttf
       pkgs.terminus_font
       #pkgs.ubuntu_font_family
       #pkgs.ucsFonts
       #pkgs.unifont
       #pkgs.vistafonts
       #pkgs.xlibs.fontadobe100dpi
       #pkgs.xlibs.fontadobe75dpi
       #pkgs.xlibs.fontadobeutopia100dpi
       #pkgs.xlibs.fontadobeutopia75dpi
       #pkgs.xlibs.fontadobeutopiatype1
       #pkgs.xlibs.fontarabicmisc
       pkgs.xlibs.fontbh100dpi
       pkgs.xlibs.fontbh75dpi
       pkgs.xlibs.fontbhlucidatypewriter100dpi
       pkgs.xlibs.fontbhlucidatypewriter75dpi
       pkgs.xlibs.fontbhttf
       pkgs.xlibs.fontbhtype1
       pkgs.xlibs.fontbitstream100dpi
       pkgs.xlibs.fontbitstream75dpi
       pkgs.xlibs.fontbitstreamtype1
       #pkgs.xlibs.fontcronyxcyrillic
       pkgs.xlibs.fontcursormisc
       pkgs.xlibs.fontdaewoomisc
       pkgs.xlibs.fontdecmisc
       pkgs.xlibs.fontibmtype1
       pkgs.xlibs.fontisasmisc
       pkgs.xlibs.fontjismisc
       pkgs.xlibs.fontmicromisc
       pkgs.xlibs.fontmisccyrillic
       pkgs.xlibs.fontmiscethiopic
       pkgs.xlibs.fontmiscmeltho
       pkgs.xlibs.fontmiscmisc
       pkgs.xlibs.fontmuttmisc
       pkgs.xlibs.fontschumachermisc
       pkgs.xlibs.fontscreencyrillic
       pkgs.xlibs.fontsonymisc
       pkgs.xlibs.fontsunmisc
       pkgs.xlibs.fontwinitzkicyrillic
       pkgs.xlibs.fontxfree86type1
    ];
  };

  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.systemWide = true;
  boot.extraModprobeConfig = ''options snd slots=snd-hda-intel'';
  hardware.trackpoint.enable = true;
  hardware.trackpoint.sensitivity = 255;
  #hardware.trackpoint.speed = 255;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  services.locate.enable = true;
  services.nixosManual.showManual = false;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/Regina";

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  nixpkgs.config = {
    allowUnfree = true;
    };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  programs.mtr.enable = true;
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };
  programs.fish.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable touchpad support.
  # services.xserver.libinput.enable = true;

  services.xserver.windowManager = {
    xmonad.enable = true;
    default = "xmonad";
    xmonad.enableContribAndExtras = true;
    xmonad.extraPackages = self: [ self.xmonad-contrib ];
  };
  services.xserver.displayManager.slim.enable = true;
  services.xserver.displayManager.slim.defaultUser = "sahabi";
  services.xserver.displayManager.sessionCommands = "xscreensaver -no-splash &";
  # services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.sahabi = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio"];
    shell = pkgs.fish;
#   uid = 1000;
  };
  # users.extraUsers.root.shell = pkgs.fish;
  services.xserver.videoDrivers = [ "nvidia" ];

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "17.09"; # Did you read the comment?

}
