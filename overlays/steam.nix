{ ... }: final: prev: {
  steam = prev.steam.override {
    extraBwrapArgs = [
      "--bind $HOME/.local/share/steam_home $HOME"
      "--unsetenv XDG_CACHE_HOME"
      "--unsetenv XDG_CONFIG_HOME"
      "--unsetenv XDG_DATA_HOME"
      "--unsetenv XDG_STATE_HOME"
    ]; 
  };
}

