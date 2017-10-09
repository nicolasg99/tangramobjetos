public class Vertice{
  private int x;
  private int y;
  public Vertice(int x, int y){
    this.x = x;
    this.y = y;
  }
  public int getX(){
    return this.x;
  }
  public int getY(){
    return this.y;
  }
  public void sumarVertice(int scale, Vertice v){
    x += scale*v.getX();
    y += scale*v.getY();
  }
  public void setX(int value){
    this.x =value;
  }
  public void setY(int value){
    this.y =value;
  }
  public void sumarX(int value){
    this.x +=value;
  }
  public void sumarY(int value){
    this.y +=value;
  }
  public boolean iguales(Vertice v){
    return (x == v.getX() && y == v.getY());
  }
  public boolean cercanos(Vertice v, int delta){
    return (x+delta>v.x && x-delta <v.x && y+delta > v.y && y-delta < v.y);
  }
  public String toString(){
    return "("+x+","+y+")";
  }
}