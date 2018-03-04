with import <nixpkgs> {};

vim_configurable.customize {
    name = "vim";
    vimrcConfig.customRC = ''
        filetype plugin indent on
        nmap OA k
        nmap OB j
        nmap 0C l
        nmap OD h
        filetype on
        syntax on
        set colorcolumn=90
        set number
        let mapleader=" "
        set hidden
        filetype indent on
        set nowrap
        set tabstop=2
        set expandtab
        set smartindent
        set autoindent
        colorscheme  wombat256
        let g:lightline = {
              \ 'colorscheme': 'wombat',
              \ }
        autocmd BufWritePre * :%s/\s\+$//e
        set laststatus=2
        set hlsearch
        set mouse=a
        set showmatch
        imap jj <ESC>
        set t_Co=256
        nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>
				set statusline+=%#warningmsg#
				set statusline+=%{SyntasticStatuslineFlag()}
				set statusline+=%*
			  set tabstop=2
				set softtabstop=2
        set shiftwidth=2

        set backspace=2
        let g:syntastic_always_populate_loc_list = 1
				let g:syntastic_auto_loc_list = 1
  			let g:syntastic_check_on_open = 1
				let g:syntastic_check_on_wq = 0
          set pastetoggle=<F2>
    '';
        # Use the default plugin list shipped with nixpkgs
    vimrcConfig.vam.knownPlugins = pkgs.vimPlugins;
    vimrcConfig.vam.pluginDictionaries = [
        { names = [
            "Syntastic"
            "ctrlp"
            "lightline-vim"
            "haskell-vim"
            "vim-colorschemes"
        ]; }
    ];
}
