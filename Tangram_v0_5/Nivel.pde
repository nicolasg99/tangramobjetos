public class Nivel{
  private ArrayList<Silueta> silueta;
  private ArrayList<Silueta> figuras;
  private String nombre;
  public Nivel(ArrayList<Silueta> silueta, String nombre){
    this.silueta = silueta;
    this.nombre = nombre;
    figuras = new ArrayList();
    for(int i = 0; i<this.silueta.size(); i++){
       figuras.add(this.silueta.get(i).GenerarReplica());
    }
  }
  public void dibujarNivel(){
    text(nombre, width/2, height/2);
    for(int i = 0; i< silueta.size(); i++){
      silueta.get(i).Dibujar();
    }
    for(int i = 0; i< silueta.size(); i++){
      figuras.get(i).Dibujar();
    }
  }
  public boolean validarNivel(){
     for(int i =0; i< this.silueta.size(); i++){
       if(!this.silueta.get(i).validar(figuras.get(i))){
         return false;
       }
     }
     return true;
  }
  public void moverFigura(int index, int vx, int vy){
    figuras.get(index).moveX(vx);
    figuras.get(index).moveY(vy);
  }
  public Silueta obtenerFigura(int index){
    return figuras.get(index);
  }
  public int getSize(){
    return figuras.size();
  }
  
}