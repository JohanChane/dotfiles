source ~/.config/bash/configs/basic.bash
source ~/.config/bash/configs/fzf.bash
source ~/.config/bash/configs/zoxide.bash
source ~/.config/bash/configs/asdf.bash
source ~/.config/bash/configs/file_mgr.bash
source ~/.config/bash/configs/tmux.bash
source ~/.config/bash/configs/utils.bash

dedup_path() {
    PATH=$(printf '%s\n' "${PATH//:/$'\n'}" | awk '!seen[$0]++' | paste -sd:)
    export PATH
}
dedup_path