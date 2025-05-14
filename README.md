 <html>
  <body>
    <p align="center">
     <img src='https://i.postimg.cc/QVG9YXWr/coollogo-com-9206501.gif'>
   </p>
    <img src='https://i.postimg.cc/HsQv4mnw/portada.png'>
   <br/>
   <h3>¡Hola! ¡Gracias por venir! 🩷</h3>
   <p>
    ¡Bienvenid@ a mis archivos de configuración de Hyprland!<br>
    En este repositorio encontrarás todos mis archivos de configuración<br>
    Siéntete libre de tomar cualquier cosa de aquí, ¡solo recuerda darme crédito por ello! :)<br><br>
    En esta versión de Hyprland podréis disfrutar de un diseño más clásico pero con algunos detalles modernos.
   </p>
   <hr>
   <h3>‼️ Importante tener en cuenta!!</h3>
    <p>No es compatible con Nvidia ni con Máquinas virtuales.</p>
    <p>Es muy importante entender que dependiendo del hardware donde realices la instalación, el proceso será más o menos rápido.</p>
   <hr>
   <h3>🍧 Información</h3>
    <ul>
     <li>Sistema operativo: Arch Linux</li>
     <li>WM: Hyprland</li>
     <li>Terminal: wezterm</li>
     <li>Shell: zsh</li>
     <li>Editor: neovim / vscode</li>
     <li>Barra: waybar + eww</li>
     <li>Lanzador de aplicaciones: eww launcher</li>
    </ul>
   <hr>
   <h3>🔧 Instalación</h3>
   <p>Aplica permisos de ejecución a 'setup.sh' e inicialo. Posteriormente debes esperar hasta que finalice.</p>
   <p>Te dejo por aquí un vídeo por si quieres realizar la instalación de una forma más guiada: https://www.youtube.com/watch?v=f4rUgk1rmyc&ab_channel=f3l3p1n0</p>
   <hr>
   <h3>🔴 Posibles problemas y soluciones</h3>
  <h4>En esta sección se abarcarán los posibles problemas y soluciones que vayan surgiendo:</h4>
  <h5><ins>◻️ El wallpaper no se aplica al iniciar sesión</ins></h5>
  <p>Debes ir a la configuración de hyprpaper: <strong>nano .config/hypr/hyprpaper.conf</strong></p>
   <p>Posteriormente, cambia el nombre del monitor que hay establecido por el nombre de tu monitor</p>
   <p>Para saber el nombre de tu monitor debes escribir en la terminal: <strong>hyprctl monitors</strong></p>
   <h5><ins>◻️ Waybar no carga al iniciar sesión</ins></h5>
   <p>Debes abrir la configuración de waybar: <strong>nano .config/waybar/config.jsonc</strong></p>
   <p>En el archivo debes modificar el apartado <strong>output</strong> para cambiar el nombre del monitor.</p>
   <h5><ins>◻️ El powermenu no funciona</ins></h5>
   <p>Debes editar el archivo 'nano ~/.config/eww/yuck/windows/powermenu.yuck'</p>
   <p>En este archivo encuentra la linea donde haya escrito lo siguiente: ':onclick "${EWW_CONFIG_DIR}/scripts/launcher toggle_menu powermenu && ${action}"'</p>
   <p>En esta linea debes cambiar la parte de '&& ${action}' la cual debe quedar de la siguiente forma '& ${action}"'</p>
   <p>Básicamente lo que habrás realizado es eliminar uno de los símbolos '&'</p>
   <hr>
   <h3>👤 Autor</h3>
   <p><a href="https://github.com/f3l3p1n0">f3l3p1n0</a></p>
  </body>
  </html>

