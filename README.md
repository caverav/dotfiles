
# Mis configuraciones

Este repositorio git contiene las configuraciones que considero importantes que uso en mi computador.


## Instalación

1) Clonar el repositorio: 

```bash
  git clone https://github.com/caverav/dotfiles.git
  cd dotfiles
```

2) Incorporar las configuraciones (Debe estar en el directorio clonado dotfiles):



    1\) Crear los enlaces simbólicos con GNU Stow (Recomendada, es más simple y al ser enlaces simbólicos no se duplican archivos):
    ```bash
    stow *
    ```

    > **_NOTA:_** requiere GNU stow, para instalarlo en distribuciones basadas en debian debe ejecutar:```sudo apt install stow``` (en otras distribuciones sólo debe reemplazar apt con su gestor de paquetes)
    
    
    
    2\) Copiar manualmente los archivos:
    
    ```bash
    cp kitty/.config/kitty ~/.config/kitty && cp compton/.config/.compton ~/.config/kitty && cp nvim/.config/nvim ~/.config/nvim && cp vim/.vimrc ~/.vimrc && cp bashrc/.bashrc ~/.bashrc
    ```
    
    
