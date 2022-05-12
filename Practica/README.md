# Projecte de compiladors 2021-2022 de LP Q2 - [El doble intèrpret de JSBach](https://github.com/jordi-petit/lp-jsbach-2022)

### Adrian Cristian Crisan

El codi conté totes les funcionalitats proposades en l'enunciat.

## Contingut:
  - **jsbach.g4**: fitxer amb la gramàtica del LP.
  - **jsbach.py**: és el main del intèrpret del llenguatge, és on es troba la crida a l'arbre visitador.
  - **TreeVisitor.py**: és l'arbre visitador.
  - **Makefile**: genera el programa i permet esborrar els seus fitxers.

              clean: esborra els fitxers necessaris per executar el programa, però deixa les sortides d'aquest.
              distclean: esborra tots els fitxers per executar el programa, a excepció dels .jsb.
              
## Com executar el programa:

Si s'executa un programa amb la funció Main com a punt d'inici:

    python3 jsbach.py musica.jsb
    
Si s'executa un programa amb una altra funció com a punt d'inici, com per exemple **Hanoi**:

    python3 jsbach.py musica.jsb Hanoi
    
## Excepcions del LP:
  - Divisió entre 0.
  - Funció donada com a punt d'inici donat errònia.
  - Variable no definida.
  - Operador no acceptat.
  - Error en assignar un valor a una variable, perquè no és un element acceptat pel LP.
  - Error en llegir un valor pel canal estàndard d'entrada, perquè no és un valor enter o una nota.
  - En escriure pel canal estàndard de sortida no donar paràmetres acceptats pel LP.
  - Si s'intenta reproduir un valor que no sigui una nota.
  - S'intenta assignar a una llista un element no acceptat pel LP.
  - S'intenta accedir a una llista no definida.
  - L'índex donat per accedir a una posició de la llista es troba fora dels límits, és 0 o major que la mida de la llista.
  - S'intenta definir un nou procediment que ja existeix.
  - S'intenta fer la crida a un procediment que no existeix.
  - El nombre de paràmetres d'un procediment cridat no és el mateix que el del procediment.
