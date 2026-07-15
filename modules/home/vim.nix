{ inputs, ... }:

{
  home.file.".vimrc".source = "${inputs.my-mvc-vim}/.vimrc";
}
