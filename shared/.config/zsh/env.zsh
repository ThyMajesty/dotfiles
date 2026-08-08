# env.zsh

# Sane human locale for eng+metric
export LANG=en_DK.UTF-8
export LC_ALL=en_DK.UTF-8

# Add .local/bin to the PATH
export PATH="$HOME/.local/bin:$PATH"

# add direnv
eval "$(direnv hook zsh)"

# set vulkan evn
source ~/opt/vulkan-sdk/current/setup-env.sh --set-dep-ld