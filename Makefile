DEST    = $(HOME)
HOSTNAME := $(shell uname -n)

.PHONY: all
all: bin dotfiles dotdirs etc usr root ## Installs everything

.PHONY: bin
bin: ## symlinks everything in bin/ in /usr/local/bin
	for file in $(shell find $(CURDIR)/bin -type f -not -name ".*" -not name "xrandr.*"); do \
		f=$$(basename $$file); \
		sudo ln -sf $$file /usr/local/bin/$$f; \
	done;
	if [ -e "$(CURDIR)/bin/xrandr.$(HOSTNAME)" ]; then \
		sudo ln -sf $(CURDIR)/bin/xrandr.$(HOSTNAME) /usr/local/bin/xrandr.local; \
	fi;

.PHONY: dotfiles
dotfiles: ## symlinks .dotfiles in home directory to this location
	# .dotfiles first, excluding git stuff and those found in .profile, .config/, and submodules/
	for file in $(shell find $(CURDIR) -type f -name ".*" -not -path "*/.profile/*" -not -path "*/.config/*" -not -path "*/root/*" -not -path "*/submodules/*" -not -name ".git*" -not -name "*.swp"); do \
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
	# .profile
	ln -sfn $(CURDIR)/.profile/.profile $(DEST)/.profile
	if [ -e "$(CURDIR)/.profile/$(HOSTNAME)" ]; then \
		ln -sf $(CURDIR)/.profile/$(HOSTNAME) $(DEST)/.profile; \
	fi;

.PHONY: dotdirs
dotdirs: ## symlinks subdirectories and files in ~/.config to this location
	# Warns if target exists
	mkdir -p $(DEST)/.config
	find "$(CURDIR)/.config" -maxdepth 1 -not -path "*/.config" -print0 | \
		while IFS= read -r -d '' target; do \
			target_source="$$(echo $${target} | sed 's|$(CURDIR)/||')"; \
			target_dest="$(DEST)/$${target_source}"; \
			CONTINUE='y'; \
			if [ -e "$${target_dest}" ] && [ ! -L "$${target_dest}" ]; then \
				unset CONTINUE; \
				while [ -z "$${CONTINUE}" ]; do \
					read -r -p "$${target_dest} exists. Delete and create symlink? [y/N]: " CONTINUE </dev/tty; \
				done; \
			fi; \
			[[ "$${CONTINUE}" == [nN]* ]] && continue; \
			rm -rf "$${target_dest}"; \
			ln -sfn "$${target}" "$${target_dest}"; \
		done;
	# Dropbox fix: https://wiki.archlinux.org/title/Dropbox#Prevent_automatic_updates
	if [ -d "$(DEST)/.dropbox-dist/" ]; then \
		dropbox_stat="$$(stat -c "%A" $(DEST)/.dropbox-dist/)"; \
		if [[ "$${dropbox_stat}" != "d---------" ]]; then \
			rm -rf $(DEST)/.dropbox-dist; \
		fi; \
	fi
	install -dm0 $(DEST)/.dropbox-dist


.PHONY: etc
etc: ## Installs /etc files
	# lxdm
	sudo cp -R $(CURDIR)/etc/lxdm/* /etc/lxdm/

.PHONY: root
root: ## Installs root's dotfiles
	sudo cp -R $(CURDIR)/root/. /root

.PHONY: usr
usr: ## Installs /usr files
	# symlinks everything in usr/local/lib/ in /usr/local/lib
	for file in $(shell find $(CURDIR)/usr/local/lib -type f -not -name ".*"); do \
		f=$$(basename $$file); \
		sudo ln -sf $$file /usr/local/lib/$$f; \
	done
	# LXAppearance .icons
	sudo cp -R $(CURDIR)/usr/share/icons/* /usr/share/icons
	# Custom GTK .themes
	sudo cp -R $(CURDIR)/usr/share/themes/* /usr/share/themes

.PHONY: help
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
