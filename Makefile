# Build packages automatically for export to a hosting site
OUTDIR ?= build

SCRIPTS_OUT := $(wildcard $(OUTDIR)/lenarch-scripts*.pkg.tar.zst)
WALLPAPERS_OUT := $(wildcard $(OUTDIR)/lenarch-wallpapers*.pkg.tar.zst)

.PHONY:all
all:SCRIPTS_OUT WALLPAPERS_OUT


SCRIPTS_OUT:lenarch-scripts/PKGBUILD
	mkdir -p $(OUTDIR)
	(cd lenarch-scripts && makepkg -fs)
	mv lenarch-scripts/*.pkg.tar.zst $(OUTDIR)/

WALLPAPERS_OUT:lenarch-wallpapers/PKGBUILD
	mkdir -p $(OUTDIR)
	(cd lenarch-wallpapers && makepkg -fs)
	mv lenarch-wallpapers/*.pkg.tar.zst $(OUTDIR)/

.PHONY:clean
clean:
	rm -rf build/
	rm -rf */pkg/
	rm -rf */src/
	rm -rf lenarch-scripts/lenarch-scripts
	rm -rf lenarch-wallpapers/lenarch-wallpapers
