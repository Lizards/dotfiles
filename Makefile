DEST    = $(HOME)

.PHONY: all
all: bin dotfiles dotdirs etc usr ## Installs everything

.PHONY: bin
bin: ## symlinks everything in bin/ in /usr/local/bin
	for file in $(shell find $(CURDIR)/bin -type f -not -name ".*"); do \
		f=$$(basename $$file); \
		sudo ln -sf $$file /usr/local/bin/$$f; \
	done

.PHONY: dotfiles
dotfiles: ## symlinks .dotfiles in home directory to this location
	# .dotfiles first, excluding git stuff and those found in .config/ and submodules/
	for file in $(shell find $(CURDIR) -type f -name ".*" -not -path "*/.config/*" -not -path "*/submodules/*" -not -name ".git*" -not -name "*.swp"); do \
		f=$$(basename $$file); \
		ln -sfn $$file $(DEST)/$$f; \
	done;
	# OK, do .git things
	ln -sfn $(CURDIR)/.gitconfig $(DEST)/.gitconfig
	ln -sfn $(CURDIR)/.gitignore $(DEST)/.gitignore
	# git submodules included in .bashrc (z, git prompt, git completion)
	ln -sfn $(CURDIR)/submodules $(DEST)/.submodules
	# .private_aliases
	ln -sfn $(DEST)/Dropbox/.private_aliases $(DEST)/.private_aliases || echo "Could not symlink .private_aliases; run make again after installing Dropbox"
	# Samba
	ln -sfn /run/user/1000/gvfs $(DEST)/samba
	# .vim colors
	mkdir -p $(DEST)/.vim
	ln -sfn $(CURDIR)/.vim/colors $(DEST)/.vim/colors
	# .Xresources.d overrides (included by .Xresources)
	ln -sfn $(CURDIR)/.Xresources.d $(DEST)/.Xresources.d

.PHONY: dotdirs
dotdirs: ## symlinks subdirectories of .config in home directory to this location (warning: removes existing dirs if found)
	# .config subdirectories, symlinked wholesale
	mkdir -p $(DEST)/.config
	for directory in $(shell find $(CURDIR)/.config -maxdepth 1 -type d -not -path "*/.config"); do \
		# TODO:  Test if it's already a directory, and if so, ask for confirmation before deleting.
		d=$$(echo $$directory | sed "s|$(CURDIR)/||"); \
		rm -rf $(DEST)/$$d; \
		ln -sfn $$directory $(DEST)/$$d; \
	done

.PHONY: etc
etc: ## Installs /etc files (lxdm)
	sudo cp -R $(CURDIR)/etc/lxdm/* /etc/lxdm/

.PHONY: usr
usr: ## Installs /usr files (gtk overrides)
	sudo cp -R $(CURDIR)/usr/share/themes/SolArc-Dark/gtk-3.0/* /usr/share/themes/SolArc-Dark/gtk-3.0/

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
