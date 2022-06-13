#
# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{profile,prompt,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Enable some Bash features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * `globstar`, recursive globbing, e.g. `echo **/*.txt`
# * `nocaseglob`, case-insensitive globbing (used in pathname expansion)
# * `cdspell`, autocorrect typos in path names when using `cd`
# * `histappend`, append to the Bash history file, rather than overwriting it
# * `checkwinsize`, checks the window size after each command and, if necessary, updates the values of LINES and COLUMNS
# * `expand_aliases`, aliases are not expanded when the shell is not interactive, unless the expand_aliases shell option is set
for option in autocd globstar nocaseglob cdspell histappend checkwinsize expand_aliases; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "alacritty" killall;

# Completion with sudo
complete -cf sudo

# Anaconda specific configuration
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh

# FZF specific configuration
[ -f /usr/share/fzf/key-bindings.bash ] && source  /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash

# One-dark color scheme, generate with vivid
export LS_COLORS="su=0:sg=0:di=0;38;2;97;175;239:fi=0:tw=0:ca=0:mi=0;38;2;0;0;0;48;2;224;108;117:ow=0:pi=0;38;2;0;0;0;48;2;97;175;239:mh=0:st=0:bd=0;38;2;86;182;194;48;2;51;51;51:*~=0;38;2;102;102;102:ex=1;38;2;224;108;117:no=0:ln=0;38;2;255;106;193:cd=0;38;2;255;106;193;48;2;51;51;51:do=0;38;2;0;0;0;48;2;255;106;193:rs=0:or=0;38;2;0;0;0;48;2;224;108;117:so=0;38;2;0;0;0;48;2;255;106;193:*.o=0;38;2;102;102;102:*.z=4;38;2;86;182;194:*.r=0;38;2;152;195;121:*.h=0;38;2;152;195;121:*.c=0;38;2;152;195;121:*.d=0;38;2;152;195;121:*.t=0;38;2;152;195;121:*.p=0;38;2;152;195;121:*.a=1;38;2;224;108;117:*.m=0;38;2;152;195;121:*.py=0;38;2;152;195;121:*.cr=0;38;2;152;195;121:*.jl=0;38;2;152;195;121:*.ll=0;38;2;152;195;121:*.ex=0;38;2;152;195;121:*.ko=1;38;2;224;108;117:*.pl=0;38;2;152;195;121:*.so=1;38;2;224;108;117:*.sh=0;38;2;152;195;121:*.md=0;38;2;229;192;123:*.cs=0;38;2;152;195;121:*.vb=0;38;2;152;195;121:*.bz=4;38;2;86;182;194:*.gv=0;38;2;152;195;121:*.di=0;38;2;152;195;121:*.pp=0;38;2;152;195;121:*.la=0;38;2;102;102;102:*css=0;38;2;152;195;121:*.rs=0;38;2;152;195;121:*.kt=0;38;2;152;195;121:*.mn=0;38;2;152;195;121:*.el=0;38;2;152;195;121:*.ts=0;38;2;152;195;121:*.td=0;38;2;152;195;121:*.rm=0;38;2;255;106;193:*.ps=0;38;2;224;108;117:*.hh=0;38;2;152;195;121:*.xz=4;38;2;86;182;194:*.nb=0;38;2;152;195;121:*.bc=0;38;2;102;102;102:*.cp=0;38;2;152;195;121:*.js=0;38;2;152;195;121:*.gz=4;38;2;86;182;194:*.lo=0;38;2;102;102;102:*.hi=0;38;2;102;102;102:*.ui=0;38;2;229;192;123:*.hs=0;38;2;152;195;121:*.rb=0;38;2;152;195;121:*.ml=0;38;2;152;195;121:*.cc=0;38;2;152;195;121:*.as=0;38;2;152;195;121:*.7z=4;38;2;86;182;194:*.fs=0;38;2;152;195;121:*.wv=0;38;2;255;106;193:*.go=0;38;2;152;195;121:*.pm=0;38;2;152;195;121:*.erl=0;38;2;152;195;121:*.epp=0;38;2;152;195;121:*.aux=0;38;2;102;102;102:*.flv=0;38;2;255;106;193:*.git=0;38;2;102;102;102:*.pod=0;38;2;152;195;121:*.pyc=0;38;2;102;102;102:*.def=0;38;2;152;195;121:*.htc=0;38;2;152;195;121:*.nix=0;38;2;229;192;123:*.vim=0;38;2;152;195;121:*.zst=4;38;2;86;182;194:*.php=0;38;2;152;195;121:*.hxx=0;38;2;152;195;121:*.yml=0;38;2;229;192;123:*.xmp=0;38;2;229;192;123:*.pdf=0;38;2;224;108;117:*.tgz=4;38;2;86;182;194:*.kts=0;38;2;152;195;121:*.tsx=0;38;2;152;195;121:*.bak=0;38;2;102;102;102:*.toc=0;38;2;102;102;102:*.gif=0;38;2;255;106;193:*TODO=1:*.xlr=0;38;2;224;108;117:*.dox=0;38;2;152;195;121:*.pyo=0;38;2;102;102;102:*.zip=4;38;2;86;182;194:*.iso=4;38;2;86;182;194:*.bin=4;38;2;86;182;194:*.dmg=4;38;2;86;182;194:*.cfg=0;38;2;229;192;123:*.jpg=0;38;2;255;106;193:*.pid=0;38;2;102;102;102:*.bib=0;38;2;229;192;123:*.mli=0;38;2;152;195;121:*.aif=0;38;2;255;106;193:*.bag=4;38;2;86;182;194:*.avi=0;38;2;255;106;193:*.mpg=0;38;2;255;106;193:*.ps1=0;38;2;152;195;121:*.vob=0;38;2;255;106;193:*.inl=0;38;2;152;195;121:*.gvy=0;38;2;152;195;121:*.c++=0;38;2;152;195;121:*.dpr=0;38;2;152;195;121:*.sbt=0;38;2;152;195;121:*.ipp=0;38;2;152;195;121:*.apk=4;38;2;86;182;194:*.pbm=0;38;2;255;106;193:*.m4a=0;38;2;255;106;193:*.csx=0;38;2;152;195;121:*.tbz=4;38;2;86;182;194:*.idx=0;38;2;102;102;102:*.xcf=0;38;2;255;106;193:*.xls=0;38;2;224;108;117:*.inc=0;38;2;152;195;121:*.rpm=4;38;2;86;182;194:*.ods=0;38;2;224;108;117:*.fon=0;38;2;255;106;193:*.deb=4;38;2;86;182;194:*.bbl=0;38;2;102;102;102:*.m4v=0;38;2;255;106;193:*.exs=0;38;2;152;195;121:*.otf=0;38;2;255;106;193:*.hpp=0;38;2;152;195;121:*.cxx=0;38;2;152;195;121:*.mir=0;38;2;152;195;121:*.pkg=4;38;2;86;182;194:*.tcl=0;38;2;152;195;121:*.pgm=0;38;2;255;106;193:*.htm=0;38;2;229;192;123:*.pro=0;38;2;152;195;121:*.lua=0;38;2;152;195;121:*.sxi=0;38;2;224;108;117:*.txt=0;38;2;229;192;123:*.elm=0;38;2;152;195;121:*.wav=0;38;2;255;106;193:*.tar=4;38;2;86;182;194:*.exe=1;38;2;224;108;117:*.fnt=0;38;2;255;106;193:*.pyd=0;38;2;102;102;102:*.mkv=0;38;2;255;106;193:*.swp=0;38;2;102;102;102:*.ico=0;38;2;255;106;193:*.doc=0;38;2;224;108;117:*.wma=0;38;2;255;106;193:*.ttf=0;38;2;255;106;193:*.awk=0;38;2;152;195;121:*.ind=0;38;2;102;102;102:*.rar=4;38;2;86;182;194:*.bcf=0;38;2;102;102;102:*.ppt=0;38;2;224;108;117:*.dll=1;38;2;224;108;117:*.odt=0;38;2;224;108;117:*.mid=0;38;2;255;106;193:*.swf=0;38;2;255;106;193:*.tif=0;38;2;255;106;193:*.fsx=0;38;2;152;195;121:*.png=0;38;2;255;106;193:*.cpp=0;38;2;152;195;121:*.cgi=0;38;2;152;195;121:*.odp=0;38;2;224;108;117:*.sty=0;38;2;102;102;102:*.zsh=0;38;2;152;195;121:*.ogg=0;38;2;255;106;193:*.tml=0;38;2;229;192;123:*.pps=0;38;2;224;108;117:*.xml=0;38;2;229;192;123:*.blg=0;38;2;102;102;102:*.ini=0;38;2;229;192;123:*.mp4=0;38;2;255;106;193:*.bmp=0;38;2;255;106;193:*.asa=0;38;2;152;195;121:*.vcd=4;38;2;86;182;194:*.pas=0;38;2;152;195;121:*.dot=0;38;2;152;195;121:*.tex=0;38;2;152;195;121:*.img=4;38;2;86;182;194:*.eps=0;38;2;255;106;193:*.h++=0;38;2;152;195;121:*hgrc=0;38;2;152;195;121:*.rtf=0;38;2;224;108;117:*.bst=0;38;2;229;192;123:*.bsh=0;38;2;152;195;121:*.clj=0;38;2;152;195;121:*.arj=4;38;2;86;182;194:*.kex=0;38;2;224;108;117:*.fsi=0;38;2;152;195;121:*.ltx=0;38;2;152;195;121:*.log=0;38;2;102;102;102:*.com=1;38;2;224;108;117:*.sql=0;38;2;152;195;121:*.bat=1;38;2;224;108;117:*.ppm=0;38;2;255;106;193:*.ics=0;38;2;224;108;117:*.tmp=0;38;2;102;102;102:*.rst=0;38;2;229;192;123:*.svg=0;38;2;255;106;193:*.wmv=0;38;2;255;106;193:*.jar=4;38;2;86;182;194:*.ilg=0;38;2;102;102;102:*.fls=0;38;2;102;102;102:*.csv=0;38;2;229;192;123:*.mov=0;38;2;255;106;193:*.mp3=0;38;2;255;106;193:*.bz2=4;38;2;86;182;194:*.psd=0;38;2;255;106;193:*.sxw=0;38;2;224;108;117:*.out=0;38;2;102;102;102:*.less=0;38;2;152;195;121:*.rlib=0;38;2;102;102;102:*.yaml=0;38;2;229;192;123:*.conf=0;38;2;229;192;123:*.java=0;38;2;152;195;121:*.fish=0;38;2;152;195;121:*.tbz2=4;38;2;86;182;194:*.xlsx=0;38;2;224;108;117:*.diff=0;38;2;152;195;121:*.tiff=0;38;2;255;106;193:*.jpeg=0;38;2;255;106;193:*.flac=0;38;2;255;106;193:*.epub=0;38;2;224;108;117:*.lock=0;38;2;102;102;102:*.webm=0;38;2;255;106;193:*.orig=0;38;2;102;102;102:*.dart=0;38;2;152;195;121:*.toml=0;38;2;229;192;123:*.docx=0;38;2;224;108;117:*.pptx=0;38;2;224;108;117:*.make=0;38;2;152;195;121:*.html=0;38;2;229;192;123:*.psd1=0;38;2;152;195;121:*.bash=0;38;2;152;195;121:*.opus=0;38;2;255;106;193:*.hgrc=0;38;2;152;195;121:*.purs=0;38;2;152;195;121:*.mpeg=0;38;2;255;106;193:*.h264=0;38;2;255;106;193:*.lisp=0;38;2;152;195;121:*.psm1=0;38;2;152;195;121:*.json=0;38;2;229;192;123:*.cache=0;38;2;102;102;102:*.shtml=0;38;2;229;192;123:*.cmake=0;38;2;152;195;121:*.dyn_o=0;38;2;102;102;102:*.xhtml=0;38;2;229;192;123:*passwd=0;38;2;229;192;123:*.ipynb=0;38;2;152;195;121:*.toast=4;38;2;86;182;194:*.class=0;38;2;102;102;102:*.cabal=0;38;2;152;195;121:*.mdown=0;38;2;229;192;123:*.scala=0;38;2;152;195;121:*.swift=0;38;2;152;195;121:*.patch=0;38;2;152;195;121:*README=0;38;2;40;44;52;48;2;229;192;123:*shadow=0;38;2;229;192;123:*COPYING=0;38;2;153;153;153:*.gradle=0;38;2;152;195;121:*LICENSE=0;38;2;153;153;153:*INSTALL=0;38;2;40;44;52;48;2;229;192;123:*.config=0;38;2;229;192;123:*.matlab=0;38;2;152;195;121:*.flake8=0;38;2;152;195;121:*TODO.md=1:*.groovy=0;38;2;152;195;121:*.ignore=0;38;2;152;195;121:*.dyn_hi=0;38;2;102;102;102:*setup.py=0;38;2;152;195;121:*TODO.txt=1:*Makefile=0;38;2;152;195;121:*Doxyfile=0;38;2;152;195;121:*.gemspec=0;38;2;152;195;121:*.desktop=0;38;2;229;192;123:*.kdevelop=0;38;2;152;195;121:*COPYRIGHT=0;38;2;153;153;153:*README.md=0;38;2;40;44;52;48;2;229;192;123:*.DS_Store=0;38;2;102;102;102:*.markdown=0;38;2;229;192;123:*configure=0;38;2;152;195;121:*.rgignore=0;38;2;152;195;121:*.cmake.in=0;38;2;152;195;121:*.fdignore=0;38;2;152;195;121:*.scons_opt=0;38;2;102;102;102:*.gitconfig=0;38;2;152;195;121:*.gitignore=0;38;2;152;195;121:*README.txt=0;38;2;40;44;52;48;2;229;192;123:*SConscript=0;38;2;152;195;121:*SConstruct=0;38;2;152;195;121:*INSTALL.md=0;38;2;40;44;52;48;2;229;192;123:*Dockerfile=0;38;2;229;192;123:*CODEOWNERS=0;38;2;152;195;121:*.localized=0;38;2;102;102;102:*.travis.yml=0;38;2;152;195;121:*.synctex.gz=0;38;2;102;102;102:*MANIFEST.in=0;38;2;152;195;121:*.gitmodules=0;38;2;152;195;121:*LICENSE-MIT=0;38;2;153;153;153:*Makefile.in=0;38;2;102;102;102:*INSTALL.txt=0;38;2;40;44;52;48;2;229;192;123:*Makefile.am=0;38;2;152;195;121:*appveyor.yml=0;38;2;152;195;121:*.applescript=0;38;2;152;195;121:*configure.ac=0;38;2;152;195;121:*CONTRIBUTORS=0;38;2;40;44;52;48;2;229;192;123:*.fdb_latexmk=0;38;2;102;102;102:*.clang-format=0;38;2;152;195;121:*CMakeLists.txt=0;38;2;152;195;121:*CMakeCache.txt=0;38;2;102;102;102:*.gitattributes=0;38;2;152;195;121:*LICENSE-APACHE=0;38;2;153;153;153:*CONTRIBUTORS.md=0;38;2;40;44;52;48;2;229;192;123:*.sconsign.dblite=0;38;2;102;102;102:*requirements.txt=0;38;2;152;195;121:*CONTRIBUTORS.txt=0;38;2;40;44;52;48;2;229;192;123:*package-lock.json=0;38;2;102;102;102:*.CFUserTextEncoding=0;38;2;102;102;102"
