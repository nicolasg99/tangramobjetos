public class Archivo{
  //private FileOutputStream salida;
  private FileInputStream entrada;
  private File archivo;
  
  public Nivel generarNivel(File pArchivo){
     archivo = pArchivo;
     ArrayList<Silueta> siluetas = new ArrayList();
     String nombre = "";
     try{
       entrada = new FileInputStream(archivo);
       int ascci;
       AccionLectura accion = AccionLectura.INICIO;
       Figura figura = Figura.INDEFINIDA;
       ArrayList<Vertice> vertices = new ArrayList();
       String x = "", y = "";
       
       while((ascci = entrada.read())!= -1){
         char lectura = (char)ascci;
           switch(accion){
             case INICIO:
               if(lectura=='\n'){
                 accion= AccionLectura.NUEVO;
               }
               else
                 nombre += lectura;
               break;
             case NUEVO:
               if(lectura=='('){
                 accion = AccionLectura.X;
               }
               else
                 figura = obtenerFigura(lectura);
               break;
             case X:
               if(lectura==','){
                 accion = AccionLectura.Y;
               }
               else
                 x += lectura;
               break;
             case Y:
               if(lectura==')'){
                 accion = AccionLectura.FIN_VERTICE;
                 try{
                   vertices.add(new Vertice(Integer.parseInt(x), Integer.parseInt(y)));
                 }catch(Exception ex){}
                 x = "";
                 y = "";
               }
               else{
                 y += lectura;
               }
               break;
             case FIN_VERTICE:
               if(lectura=='('){
                 accion = AccionLectura.X;
               }
               else if(lectura==']'){
                 siluetas.add(new Silueta(figura, vertices));
                 vertices = new ArrayList();
                 accion = AccionLectura.NUEVO;
               }
               break;
           }
         
       }
     }
     catch(Exception ex){
     }
     return new Nivel(siluetas, nombre);
  }
  private Figura obtenerFigura(char f){
    Figura retorno = Figura.INDEFINIDA;
    switch(f){
      case 'r':
        retorno = Figura.RECTANGULO;
        break;
      case 't':
        retorno = Figura.TRIANGULO;
        break;
    }
    return retorno;
  }
}
private enum AccionLectura{
  INICIO,
  NUEVO,
  X,
  Y,
  FIN_VERTICE
}