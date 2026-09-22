# install-indigomagic

One-shot installer for the [IndigoMagic SGI theme](https://www.xfce-look.org/p/1371886), a workstation theme that turns a modern Linux desktop into something that looks like IRIX.

The upstream page ships a single tarball plus a page of manual instructions: extract into `/usr/share/themes`, link into `~/.themes`, then click through roughly a dozen Settings dialogs, as your user and again as root. This script does all of it, and the parts the instructions leave out.

Tested on Linux Mint 22 Cinnamon. Targets Debian, Ubuntu and Mint (apt) on Xfce, Cinnamon, MATE or GNOME.

<img width="1908" height="1072" alt="image" src="https://github.com/user-attachments/assets/cdf3edb3-0ae2-4794-9c2b-63ee112a7769" />


## Quick start

```shell
bash install-indigomagic.sh
```

That fetches the archive, installs every component, applies the settings for whichever desktop you are running, and prints a summary. Log out and back in afterwards to pick up the Qt5 environment variable, the bitmap font rendering and the autostart entries.

To see what it would do without touching anything:

```shell
bash install-indigomagic.sh --dry-run
```

To undo everything:

```shell
bash install-indigomagic.sh --uninstall
```

## What it installs

| Component | Destination |
| --- | --- |
| GTK 2/3 and xfwm4 theme | `/usr/share/themes/IndigoMagic` |
| Icon theme | `/usr/share/icons/sgi-elementary-xfce` |
| Cursor theme | `/usr/share/icons/Bibata-Modern-Ice` (archive ships `redSGI`) |
| Bitmap fonts | `/usr/share/fonts/indigomagic` |
| Wallpapers | `/usr/share/backgrounds/indigomagic` |
| Startup sound | `/usr/share/sounds/indigomagic` |
| Plank dock theme | `~/.local/share/plank/themes` |
| Plymouth boot splash | `/usr/share/plymouth/themes/sgi` |
| Generated Cinnamon shell theme | `/usr/share/themes/IndigoMagic/cinnamon/cinnamon.css` |

It also links the theme and icon sets into `~/.themes` and `~/.icons`, writes `/root/.config/gtk-3.0/settings.ini` and `/root/.gtkrc-2.0` so root-launched GTK apps match, enables bitmap fonts, installs `qt5-style-plugins` and exports `QT_QPA_PLATFORMTHEME=gtk2`, and sets up xosview docked in the tray via kdocker.

## How it works

### Getting the archive

xfce-look and pling hand out per-request download URLs that are IP-pinned and expire in about 48 hours, so no literal file URL can be baked into a script. Instead the content ID is hardcoded and a fresh link is minted from the OCS API at runtime:

```
https://api.opendesktop.org/ocs/v1/content/download/1371886/1
```

The script also picks up `IndigoMagic.tar.gz` if it is already sitting in the current directory or `~/Downloads`, and `--archive PATH` skips the network entirely.

### Finding the components

The tarball's layout is not documented and changes between releases, so nothing about it is hardcoded. The script walks the extracted tree breadth-first, starting at the tarball root itself, and classifies each directory by what is inside it:

- `gtk-2.0/`, `gtk-3.0/` or `xfwm4/` means a GTK theme
- `index.theme` containing `[Icon Theme]` means an icon theme
- `cursors/` means a cursor theme (a directory can be both)
- `dock.theme` means a Plank theme
- `*.plymouth` means a boot splash

A directory that classifies is claimed and not descended into, which stops an icon theme's own subfolders from being misread as more themes. There is no depth limit, directory names with spaces are fine, and nested archives inside the tarball are unpacked first.

If detection comes up empty, the script prints the archive layout so you can see why. `--list` does that on its own without installing anything.

### Applying the settings

This is the part the upstream instructions handle with a list of Settings dialogs to click. Xfce keeps appearance in xfconf, while Cinnamon, MATE and GNOME keep it in gsettings. Writing to the wrong one succeeds silently and does nothing, so the script detects every backend present and writes to all of them:

- **Xfce**: `xsettings`, `xfwm4`, `xfce4-desktop` and `xfce4-panel` channels, including the desktop backdrop per connected monitor, the panel background image, and the Applications or Whisker menu button icon
- **Cinnamon**: `org.cinnamon.desktop.interface`, `org.cinnamon.theme`, `org.cinnamon.desktop.wm.preferences`, `org.cinnamon.desktop.background`
- **MATE**: `org.mate.interface`, `org.mate.Marco.general`, `org.mate.background`
- **GNOME**: the `org.gnome.*` equivalents

Every gsettings write is guarded by a schema and key existence check, so a missing key is skipped rather than raising an error.

### The Cinnamon shell theme

IndigoMagic ships GTK widgets and an xfwm4 window border, but no Cinnamon shell theme. On Cinnamon that leaves every app window SGI grey while the panel, menu and applets stay stock dark.

So the script generates `<theme>/cinnamon/cinnamon.css`: mid grey chrome, hard 1px bevels that invert on press, black text, IRIX blue selection. It covers the panel in all four orientations, window list buttons, the Mint menu with its search box and category list, popup menus, tooltips, the calendar and the workspace switcher.

The palette is a commented block at the top of the generated file. Edit it in place and re-run: the script detects that you changed it and restores your version instead of overwriting. If the archive ever ships its own `cinnamon.css`, that wins. `--skip cinnamon-css` opts out.

Cinnamon's CSS is a St/Clutter subset, so `background-color`, `color`, `border` and `padding` work while gradients and most shadows do not. The result is flat bevels, which suits SGI, but it is not pixel-exact against the GTK widgets.

### The desktop background

The default is a solid `#7393B3` (htmlcolorcodes' "blue gray") applied as a backdrop colour rather than an image: `image-style 0` plus `color-style 0` and an `rgba1` array on Xfce, `picture-options none` plus `primary-color` on the others. No file, no download, nothing to break.

On Mint, `slideshow-enabled` is turned off first, because the background slideshow rewrites `picture-uri` on a timer and silently undoes whatever you set.

`--bg` takes a URL or a local file instead. Downloads are checked for PNG, JPEG, GIF or SVG magic bytes before anything becomes your wallpaper, since a URL ending in `.png` is perfectly capable of returning an HTML error page.

### The boot splash

Plymouth is installed if it is missing. The upstream instructions run `plymouth-set-default-theme -R` before renaming `sgi.script` to `startup.script` and `shutdown.script` to `sgi.script`, which bakes the wrong script into the initrd. The script does the renames first, then rebuilds once.

It also adds `quiet splash` to `GRUB_CMDLINE_LINUX_DEFAULT` and runs `update-grub`, because plymouth installed and themed still shows nothing at boot if the kernel cmdline does not ask for it. Only that one line is touched and only appended to, so `nomodeset` becomes `nomodeset quiet splash`. `--skip grub` leaves the bootloader alone.

On a VM the splash often will not render regardless, because of the virtual display driver. To confirm the theme itself works: `sudo plymouthd; sudo plymouth --show-splash`.

## Options

| Flag | Effect |
| --- | --- |
| `--archive PATH` | Use a local tarball instead of downloading |
| `--list`, `-l` | Print the archive layout and exit, installing nothing |
| `--dry-run`, `-n` | Print every action, change nothing |
| `--uninstall` | Undo the install using the manifest |
| `--skip a,b,c` | Skip components (see below) |
| `--font "Screen 12"` | Override the detected UI font |
| `--cursor NAME` | Cursor theme, or `archive` to keep `redSGI` |
| `--bg URL\|PATH` | Background image, or `archive` for the theme's own |
| `--bg-color '#RRGGBB'` | Solid backdrop colour (the default) |
| `--bg-style 0-5` | Xfce image style: 0 none, 1 centered, 2 tiled, 3 stretched, 4 scaled, 5 zoomed |
| `--help`, `-h` | Usage |

Values for `--skip`: `fonts`, `qt5`, `xosview`, `plank`, `plymouth`, `grub`, `root`, `cinnamon-css`.

## Re-running and undoing

Re-running is safe. Theme directories are replaced, settings are re-applied, and the things that append to files are all guarded: the `~/.Xdefaults` xosview block is stripped before being re-added, and `~/.profile` only ever gets one `QT_QPA_PLATFORMTHEME` line.

Every file the script edits is backed up first to a timestamped directory, and everything it creates is recorded:

```
~/.local/share/indigomagic-install/manifest.tsv
~/.local/share/indigomagic-install/backup-YYYYmmdd-HHMMSS/
```

`--uninstall` reads that manifest in reverse, removes what was installed, restores the backups, resets the xfconf and gsettings keys, puts `/etc/default/grub` back and regenerates it, and re-enables `70-no-bitmaps.conf`.

## Notes and caveats

- `qt5-style-plugins` was dropped in Debian 12 and Ubuntu 23.04. If apt cannot find it the script says so and suggests `qt5ct` rather than failing.
- On Cinnamon, window borders come from Muffin, not xfwm4, so titlebars will not be fully SGI even once the app widgets are. A real Xfce session gets the complete look.
- Bibata is not in the Mint or Ubuntu repos. The script checks whether it is already installed, tries apt in case your distro packages it, then falls back to the latest [Bibata release](https://github.com/ful1e5/Bibata_Cursor) asset via the GitHub API.
- Bitmap fonts need `70-no-bitmaps.conf` removed, which the script does after backing it up. Antialiasing is turned off so the bitmap fonts render crisply.
- The script refuses to run as root. It calls `sudo` itself where it needs to.

## Credits

Theme by its author on [xfce-look.org](https://www.xfce-look.org/p/1371886). This installer just automates the instructions on that page.
