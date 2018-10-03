# forked from yangwao/omf-theme-slavic-cat https://github.com/yangwao/omf-theme-slavic-cat
# which is also forked from Toaster https://github.com/oh-my-fish/theme-toaster

set __slavic_color_orange FD971F
set __slavic_color_blue 6EC9DD
set __slavic_color_green A6E22E
set __slavic_color_yellow E6DB7E
set __slavic_color_pink F92672
set __slavic_color_grey 554F48
set __slavic_color_white F1F1F1
set __slavic_color_purple 9458FF
set __slavic_color_lilac AE81FF


function __slavic_color_echo
  set_color $argv[1]
  if test (count $argv) -eq 2
    echo -n $argv[2]
  end
end

function __slavic_current_folder
  if test $PWD = '/'
    echo -n '/'
  else
    echo -n $PWD | grep -o -E '[^\/]+$'
  end
end

function __slavic_git_status_codes
  echo (git status --porcelain ^/dev/null | sed -E 's/(^.{3}).*/\1/' | tr -d ' \n')
end

function __slavic_git_branch_name
  echo (git rev-parse --abbrev-ref HEAD ^/dev/null)
end

function __slavic_rainbow
  if echo $argv[1] | grep -q -e $argv[3]
    __slavic_color_echo $argv[2] "彡ミ"
  end
end

function __slavic_git_status_icons
  set -l git_status (__slavic_git_status_codes)

  __slavic_rainbow $git_status $__slavic_color_pink 'D'
  __slavic_rainbow $git_status $__slavic_color_orange 'R'
  __slavic_rainbow $git_status $__slavic_color_white 'C'
  __slavic_rainbow $git_status $__slavic_color_green 'A'
  __slavic_rainbow $git_status $__slavic_color_blue 'U'
  __slavic_rainbow $git_status $__slavic_color_lilac 'M'
  __slavic_rainbow $git_status $__slavic_color_grey '?'
end

function __slavic_git_status
  # In git
  if test -n (__slavic_git_branch_name)

    __slavic_color_echo $__slavic_color_blue " ☭ "
    __slavic_color_echo $__slavic_color_white (__slavic_git_branch_name)

    if test -n (__slavic_git_status_codes)
      __slavic_color_echo $__slavic_color_pink ' ●'
      __slavic_color_echo $__slavic_color_white ' (^._.^)ﾉ'
      __slavic_git_status_icons
    else
      __slavic_color_echo $__slavic_color_green ' ○'
    end
  end
end

function fish_prompt
  __slavic_color_echo $__slavic_color_purple (prompt_pwd)
  __slavic_git_status

  echo
  __slavic_color_echo $__slavic_color_pink '∫  '
end

function fish_right_prompt
    echo ' ['(date +%H:%M:%S)'] '
end
