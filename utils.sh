#
# Utility functions and variables to be used in the shell scripts.
#

# Read user input
prompt() {
  local prompt_string="$1"
  local default_value="$2"
  if test -n "$default_value"; then
    prompt_string="$prompt_string [$default_value]"
  fi
  read -p "${prompt_string}: " input
  if test -z "$input"; then
    local input=$default_value
  fi

  echo "$input"
}

# Check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Print information message
info() {
  local blue='\033[0;34m'
  local nc='\033[0m'
  printf "${blue}[INFO]${nc} $1\n"
}

# Print warning message
warn() {
  local blue='\033[0;33m'
  local nc='\033[0m'
  printf "${blue}[WARN]${nc} $1\n"
}

# Print error message and exit with an optional error code
error() {
  local errcode=$2
  test -z ${errcode} && errcode=1

  local red='\033[0;31m'
  local nc='\033[0m'
  printf "${red}[ERROR]${nc} $1\n"
  exit $errcode
}

result() {
  local errcode=$?
  if test $errcode -gt 0; then
    error "Command failed: $errcode" $errcode
  fi
}

# Set platform variables
PLATFORM_LINUX=0
PLATFORM_MAC=0
__platform="$(uname)"
case "$__platform" in
"Linux") PLATFORM_LINUX=1 ;;
"Darwin") PLATFORM_MAC=1 ;;
esac

# Set package manager command
if test $PLATFORM_MAC -eq 1; then
  command_exists "brew" &&
    PKG_INSTALL="brew install" ||
    error "No package manager found: Install homebrew: https://brew.sh/"
elif test $PLATFORM_LINUX -eq 1; then
  # Try to
  if command_exists "yay"; then
    PKG_INSTALL="yay -S --needed --noconfirm"
  elif command_exists "pacman"; then
    PKG_INSTALL="pacman -S --needed --noconfirm"
  elif command_exists "apt"; then
    PKG_INSTALL="apt install"
  else
    error "No supported package manager found"
  fi
else
  error "Unsupported platform: ${__platform}"
fi
