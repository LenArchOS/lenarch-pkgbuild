# Build packages automatically for export to a hosting site
OUTDIR ?= build

SCRIPTS_OUT := $(wildcard $(OUTDIR)/lenarch-scripts*.pkg.tar.zst)
WALLPAPERS_OUT := $(wildcard $(OUTDIR)/lenarch-wallpapers*.pkg.tar.zst)
CINNAMON_OUT := $(wildcard $(OUTDIR)/lenarch-cinnamon*.pkg.tar.zst)
PLASMA_OUT := $(wildcard $(OUTDIR)/lenarch-plasma*.pkg.tar.zst)
OPENBOX_OUT := $(wildcard $(OUTDIR)/lenarch-openbox*.pkg.tar.zst)
SKEL_OUT := $(wildcard $(OUTDIR)/lenarch-skel*.pkg.tar.zst)
AUR_OUT := $(wildcard aur/$(OUTDIR)/*.pkg.tar.zst)

.PHONY:all
all:SCRIPTS_OUT WALLPAPERS_OUT PLASMA_OUT CINNAMON_OUT OPENBOX_OUT SKEL_OUT

.PHONY:scripts
scripts:SCRIPTS_OUT

.PHONY:wm
wm:OPENBOX_OUT CINNAMON_OUT PLASMA_OUT

.PHONY:wallpapers
wallpapers:WALLPAPERS_OUT

.PHONY:skel
skel:SKEL_OUT

.PHONY:aur
aur:AUR_OUT

AUR_OUT:aur/*
	(cd aur && ./build_aur.sh $(OUTDIR))

SCRIPTS_OUT:lenarch-scripts/PKGBUILD
	mkdir -p $(OUTDIR)
	(cd lenarch-scripts && makepkg -fs)
	mv lenarch-scripts/*.pkg.tar.zst $(OUTDIR)/

WALLPAPERS_OUT:lenarch-wallpapers/PKGBUILD
	mkdir -p $(OUTDIR)
	(cd lenarch-wallpapers && makepkg -fs)
	mv lenarch-wallpapers/*.pkg.tar.zst $(OUTDIR)/

CINNAMON_OUT:lenarch-cinnamon/PKGBUILD
	mkdir -p $(OUTDIR)
	(cd lenarch-cinnamon && makepkg -fs)
	mv lenarch-cinnamon/*.pkg.tar.zst $(OUTDIR)/

PLASMA_OUT:lenarch-plasma/PKGBUILD
	mkdir -p $(OUTDIR)
	(cd lenarch-plasma && makepkg -fs)
	mv lenarch-plasma/*.pkg.tar.zst $(OUTDIR)/

OPENBOX_OUT:lenarch-openbox/PKGBUILD
	mkdir -p $(OUTDIR)
	(cd lenarch-openbox && makepkg -fs)
	mv lenarch-openbox/*.pkg.tar.zst $(OUTDIR)/

SKEL_OUT:lenarch-skel/PKGBUILD
	mkdir -p $(OUTDIR)
	(cd lenarch-skel && makepkg -fs)
	mv lenarch-skel/*.pkg.tar.zst $(OUTDIR)/

.PHONY:clean
clean:
	rm -rf build/
	rm -rf aur/build/
	rm -rf */pkg/
	rm -rf */src/
	rm -rf lenarch-scripts/lenarch-scripts
	rm -rf lenarch-wallpapers/lenarch-wallpapers
	rm -rf lenarch-openbox/lenarch-openbox
	rm -rf lenarch-cinnamon/lenarch-cinnamon
	rm -rf lenarch-plasma/lenarch-plasma
	rm -rf lenarch-skel/lenarch-skel
