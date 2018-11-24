DEST    = $(HOME)

.PHONY: all
all: bin dotfiles dotdirs etc usr root ## Installs everything

.PHONY: bin
bin: ## symlinks everything in bin/ in /usr/local/bin
	for file in $(shell find $(CURDIR)/bin -type f -not -name ".*"); do \
		f=$$(basename $$file); \
		sudo ln -sf $$file /usr/local/bin/$$f; \
	done

.PHONY: dotfiles
dotfiles: ## symlinks .dotfiles in home directory to this location
	# .dotfiles first, excluding git stuff and those found in .config/ and submodules/
	for file in $(shell find $(CURDIR) -type f -name ".*" -not -path "*/.config/*" -not -path "*/root/*" -not -path "*/submodules/*" -not -name ".git*" -not -name "*.swp"); do \
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
dotdirs: ## symlinks subdirectories of .config in home directory to this location
	# .config subdirectories, symlinked wholesale
	# Warns if target exists as a directory
	mkdir -p $(DEST)/.config
	for directory in $(shell find $(CURDIR)/.config -maxdepth 1 -type d -not -path "*/.config"); do \
		dir_source=$$(echo $$directory | sed "s|$(CURDIR)/||"); \
		dir_dest="$(DEST)/$${dir_source}"; \
		CONTINUE='y'; \
		if [ ! -L $$dir_dest ] && [ -d $$dir_dest ]; then \
			unset CONTINUE; \
			while [ -z "$$CONTINUE" ]; do \
				read -r -p "Directory $${dir_dest} exists. Delete and create symlink? [y/N]: " CONTINUE; \
			done; \
		fi; \
		[ $$CONTINUE = "y" ] || [ $$CONTINUE = "Y" ] || continue; \
		rm -rf $$dir_dest; \
		ln -sfn $$directory $$dir_dest; \
	done

.PHONY: etc
etc: ## Installs /etc files
	# lxdm
	sudo cp -R $(CURDIR)/etc/lxdm/* /etc/lxdm/

.PHONY: usr
usr: ## Installs /usr files
	# gtk override: this is dumb and I hate it
	gtk_css='/usr/share/themes/SolArc-Dark/gtk-3.0/gtk.css'; \
	if [ ! -f "$${gtk_css}.orig" ]; then \
		sudo cp $$gtk_css $$gtk_css.orig; \
	fi; \
	sudo sed -i 's/657b83/cbd5d8/g' $$gtk_css
	# Bash color vars
	sudo install -Dm0755 $(CURDIR)/usr/local/lib/bash_colors.sh /usr/local/lib/bash_colors.sh

.PHONY: root
root: ## Installs root's dotfiles
	sudo cp -R $(CURDIR)/root/. /root

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
