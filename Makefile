
DOTDIR=`pwd`

install: install-hg install-vim

install-csh:
	rm -f ~/.cshrc ; ln -s $(DOTDIR)/csh/cshrc ~/.cshrc

install-sh:
	rm -f ~/.shrc ; ln -s $(DOTDIR)/sh/shrc ~/.shrc

install-hg:
	rm -f ~/.hgrc ; ln -s $(DOTDIR)/hg/hgrc ~/.hgrc
	rm -f ~/.hgignore ; ln -s $(DOTDIR)/hg/hgignore ~/.hgignore

install-vim:
	rm -rf ~/.vim ; ln -s $(DOTDIR)/vim ~/.vim
	rm -f ~/.vimrc ; ln -s $(DOTDIR)/vim/vimrc ~/.vimrc
