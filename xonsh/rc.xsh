#! /usr/bin/env xonsh

### XONSH WIZARD START ###

# ENV VARIABLES
# $XONSH_COLOR_STYLE = 'material'
# $STARSHIP_CONFIG = '~/.config/starship_xonsh.toml'
$XONSH_SHOW_TRACEBACK = True
$MANPAGER="sh -c 'col -bx | bat -l man -p'"
$MANROFFOPT="-c"

### LOADING XONTRIBS ###
xontrib load abbrevs
xontrib load conda
xontrib load jedi
# xontrib load prompt_starship

### SETTING THE PROMPT ###

def my_cwd() -> str:
  """Returns a fancy string representing the current work directory."""
  cwd_lst = $(pwd).replace(f'/home/{$USER}', '~').strip().split('/')
  if len(cwd_lst) > 2:
    return __bold(f'🖿  …/{cwd_lst[-1]}  ')
  else:
    return __bold(f'🖿  {"/".join(cwd_lst)}  ')

def __get_git_status() -> str:
  git_sym = {'M': '', 'A': '', '?': '?', 'D': ''}
  iter = set(
    [git_sym[i.lstrip()[0]] for i in $(git status --porcelain).split('\n') if i]
  )
  return ' '.join(iter)

def my_curr_branch() -> str:
  """Returns a fancy string representing the current git repository."""
  cb = $PROMPT_FIELDS['curr_branch']()
  if cb:
    cb = '' if cb in {'main', 'dev'} else f' {cb} '
    if $(git rev-parse --is-inside-work-tree).strip() == 'true':
      status = __get_git_status()
      if status:
        return __bold(f'{__fg(__colors["red"])}{cb} {status} {__reset()} ')
      else:
        return __bold(f'{cb}  ')
    else:
      msg = __italic('outside-work-tree')
      return __bold(f'{__fg(__colors["yellow"])}{cb} {msg} {__reset()} ')
  else:
    return ''

def my_env_name() -> str:
  """Returns a fancy string representing the conda environment."""
  if $CONDA_SHLVL == '1':
    return __bold(f' 󰌠 {$CONDA_DEFAULT_ENV}')
  else:
    return ''

def __get_time_hour_min() -> tuple[str, int, int]:
  time = $PROMPT_FIELDS['localtime']()
  hour = int(time[:2]) % 12
  min = int(time[3:])
  return time, hour, min

def my_localtime() -> str:
  """Returns a fancy string representing the current time."""
  clocks = {
    0:  ['🕛','🕧'],
    1:  ['🕐','🕜'],
    2:  ['🕑','🕝'],
    3:  ['🕒','🕞'],
    4:  ['🕓','🕟'],
    5:  ['🕔','🕠'],
    6:  ['🕕','🕡'],
    7:  ['🕖','🕢'],
    8:  ['🕗','🕣'],
    9:  ['🕘','🕤'],
    10: ['🕙','🕥'],
    11: ['🕚','🕦'],
  }
  time, hour, min = __get_time_hour_min()
  clock = clocks[hour][0 if min < 30 else 1]
  return __bold(f'  {clock} {time}')

def my_memory() -> str:
  mems = [i.replace(',', '.').split() for i in $(free).strip().split('\n')]
  used_ram = int(mems[1][2]) / int(mems[1][1]) * 100
  used_swap = int(mems[2][2]) / int(mems[2][1]) * 100
  return __bold(f'   𝑟{used_ram:.0f}% 𝑠{used_swap:.0f}%')

def my_temperature() -> str:
  temp = int($(cat /sys/class/thermal/thermal_zone2/temp).strip()) / 1000
  if temp <= 60.0:
    prompt = f' {temp:.1f}°C'
  elif 60.0 < temp <= 85.0:
    prompt = f' {temp:.1f}°C'
  else:
    prompt = f'{__fg(__colors["red"])} {temp:.1f}°C{__reset()}'
  return __bold(f'  {prompt}')

my_prompt_fields = {
  'env_postfix': '',
  'env_prefix': '',
  'time_format': '%R',
  'my_curr_branch': my_curr_branch,
  'my_cwd': my_cwd,
  'my_env_name': my_env_name,
  'my_localtime': my_localtime,
  'my_memory': my_memory,
  'my_temperature': my_temperature,
}
$PROMPT_FIELDS.update(my_prompt_fields)

### DEFINING AUXILIAR FUNCTIONS ###

### AUXILIAR FUNCTIONS TO SET FORE AND BACKGROUND COLORS USING ASCII CODE ###

def __hex2rgb(hex: str) -> list[int]:
  """Return a RGB list of integers from a hexadecimal string."""
  rgb = []
  hex = hex.strip('#')
  for i in (0, 2, 4):
    rgb.append(
      int(f'0x{hex[i: i + 2]}', 16)
    )
  return rgb

def __bg(hex: str) -> str:
  """Return a strip containing the ASCII code to set a foreground color from a
     hexadecimal string."""
  rgb = __hex2rgb(hex)
  return f'\x1b[48;2;{rgb[0]};{rgb[1]};{rgb[2]}m'

def __fg(hex: str) -> str:
  """Return a strip containing the ASCII code to set a background color from a
     hexadecimal string."""
  rgb = __hex2rgb(hex)
  return f'\x1b[38;2;{rgb[0]};{rgb[1]};{rgb[2]}m'

### AUXILIAR FUNCTIONS TO STYLE STRINGS USING ASCII CODE ###
#
def __bold(s: str) -> str:
  """Bold a given string using ASCII code."""
  return f'\x1b[1m{s}'

def __darker(s: str) -> str:
  """Darkens a given string using ASCII code."""
  return f'\x1b[2m{s}'

def __italic(s: str) -> str:
  """Bold a given string using ASCII code."""
  return f'\x1b[3m{s}'

def __underlined(s: str) -> str:
  """Italicize a given string using ASCII code."""
  return f'\x1b[4m{s}'

def __reverse(s: str) -> str:
  """Reverse a given string using ASCII code."""
  return f'\x1b[7m{s}'

def __strikethrough(s: str) -> str:
  """Strikethrough a given string using ASCII code."""
  return f'\x1b[9m{s}'

def __reset() -> str:
  """Reset the ASCII code."""
  return '\x1b[0m'

def __make_prompt(*fields) -> str:
  """Build a prompt from a given fiels and its string styles."""
  prompt = ''
  for field in fields:
    if len(field) > 2:
      prompt += f'{__bg(field[2])}{__fg(field[1])}{field[0]}{__reset()}'
    else:
      prompt += f'{__fg(field[1])}{field[0]}{__reset()}'
  return prompt

### A DICTIONARY OF CUSTOM COLORS ###
__colors = {
  'black':      '#000000',
  'blue':       '#87afff',
  'green':      '#87ffd7',
  'green_dark': '#5fafaf;',
  'grey':       '#8787af',
  'orange':     '#ffaf5f',
  'red':        '#ff87af',
  'white':      '#ffffff',
  'yellow':     '#ffd787',
  'magenta':    '#af87ff'
}

$RIGHT_PROMPT = (
  __make_prompt(
    # ( PROMPT FIELD, FOREGROUND COLOR [, BACKGROUND COLOR] )
    ( '\n{my_env_name}', __colors['magenta'] ),
    ( '{my_memory}', __colors['magenta'] ),
    ( '{my_temperature}', __colors['magenta'] ),
    ( '{my_localtime}', __colors['magenta'] ),
  )
)

$PROMPT = (
  __make_prompt(
    # ( PROMPT FIELD, FOREGROUND COLOR [, BACKGROUND COLOR] )
    ( '\n{my_cwd}', __colors['blue'] ),
    ( '{my_curr_branch}', __colors['green'] ),
  )
)

# DEFINING CUSTOM ALIASES ###
def run_ping(num_ping: int = 6) -> None:
  servers = {'www.unicamp.br', 'www.uol.com.br', 'www.google.com'}
  $[clear]
  for server in servers:
    title = __bold(__italic(f'\nPing at "{server}"\n{"-" * 40}\n'))
    print(f'{title}{__reset()}')
    $[ping -vc @(num_ping) @(server)]

# abbrevs['rp'] = '__run_ping(3)'

my_aliases = {
  'cl':   'clear',
  'cls':  'cl && exa --long --icons',
  'cld':  'cl && exa --long --icons --only-dirs',
  'cla':  'cl && exa --long --icons --all',
  'clda':  'cl && exa --long --icons --all --only-dirs',
  'q':    'quit',
  'moc':  'mocp',
}
aliases.update(my_aliases)

### XONSH WIZARD END ###
