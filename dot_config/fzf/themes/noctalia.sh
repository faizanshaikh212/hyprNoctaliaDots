fzf_theme_opts="\
--color=bg+:#17293b
--color=bg:#111e2c
--color=spinner:#f2f2f3
--color=hl:#fd4663
--color=fg:#f2f2f3
--color=header:#fd4663
--color=info:#67bbe4
--color=pointer:#f2f2f3
--color=marker:#afb4b6
--color=fg+:#f2f2f3
--color=prompt:#67bbe4
--color=hl+:#fd4663
--color=selected-bg:#17293b
--color=border:#17293b
--color=label:#f2f2f3"

export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:+$FZF_DEFAULT_OPTS
}$fzf_theme_opts"
