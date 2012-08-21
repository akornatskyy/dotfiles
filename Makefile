
DOTDIR=`pwd`

install: install-vim

install-csh:
	rm -f ~/.cshrc
	ln -s $(DOTDIR)/csh/cshrc ~/.cshrc

install-sh:
	rm -f ~/.shrc
	ln -s $(DOTDIR)/sh/shrc ~/.shrc

install-vim:
	rm -rf ~/.vim ~/.vimrc
	ln -s $(DOTDIR)/vim ~/.vim
	ln -s $(DOTDIR)/vim/vimrc ~/.vimrc
