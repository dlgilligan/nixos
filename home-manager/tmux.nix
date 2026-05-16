{
  ...
}: {
  programs.tmux = {
    enable = true;
    prefix = "C-b";
    mouse = true;
    keyMode = "vi";
    historyLimit = 102400;
    escapeTime = 10;

    extraConfig = ''
      unbind-key -T copy-mode-vi v
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi 'C-v' send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
      bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel "pbcopy"
      
      bind c new-window -c '#{pane_current_path}'
      bind S command-prompt -p "Enter session name: " "new-session -s '%%'"
      bind '|' split-window -h -c '#{pane_current_path}'
      bind - split-window -v -c '#{pane_current_path}'
      bind d break-pane -d
      
      set-option -g status-justify left
      set-option -g status-bg colour235
      set-option -g status-fg colour250
      set-option -g status-left-length 20
      set-option -g status-left '#[fg=colour5,bold]#S#[fg=colour250] '
      set-option -g status-right '#[fg=colour3]%a %R#[fg=colour250] #[fg=colour4,bold]#H#[default]'
      set-option -g status-interval 60
      set-option -g pane-active-border-style fg=colour5
      set-option -g pane-border-style fg=colour238
      set-window-option -g window-status-format '#[fg=colour250]#I:#W#[fg=colour1]#F'
      set-window-option -g window-status-current-format '#[fg=colour5,bold]#I:#[fg=colour3,bold]#W#[fg=colour4]#F'
'';
  };
}
