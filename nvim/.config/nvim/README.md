
# NvimTree for exploring files
![image](https://user-images.githubusercontent.com/66751764/213718922-a8b8170e-f5af-4cd4-bb59-c29327760e31.png)

# Telescope (i.e. for grepping files)
![image](https://user-images.githubusercontent.com/66751764/213720585-90345584-2cbb-425a-b6dd-7c1e930f70d0.png)

# Git integration
![image](https://user-images.githubusercontent.com/66751764/213735532-063aa34b-2b1e-4163-8498-ccc359e36ab4.png)

# LSP integration riced
![image](https://user-images.githubusercontent.com/66751764/213736363-29c48128-d3eb-4603-a0f0-a044a0ae3dce.png)

# Install

1. Install dependencies

```sh
npm install -g prettier eslint tree-sitter neovim
```

2. Install nvim (Press enter if error):

```sh
rm -rf ~/.config/nvim ~/.local/share/nvim ~/.cache/nvim && git clone https://github.com/kidp2h/lazynvim.git ~/.config/nvim --depth 1 && nvim

```

**_Note_**: for some reason, if step 2 fails and you cannot run step 3, try using neovim 0.7.2, run all the commands and then install a newer version (>= 0.8) to use all the functionality

3. Run this command in nvim (Press enter if error):

```sh
:MasonInstallAll
```

4. Reboot nvim and run:

```
:PackerSync
```
