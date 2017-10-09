public class Silueta{
  private ArrayList<Vertice> vertices;
  private Figura figura;
  private color colorSilueta;
  private int rotacion;
  private boolean movible;
  private Vertice posicion;
  private Vertice baricentro;
  private boolean equilatero;
  
  
  public Silueta(Figura figura, ArrayList<Vertice> vertices){
    this.figura = figura;
    this.vertices = vertices;
    this.colorSilueta = color(255, 255, 255);
    this.movible = false;
    localizar();
    equilatero = comprobarEquilatero();
  }
  public Silueta(Figura figura, ArrayList<Vertice> vertices,color colorSilueta, int rotacion, Vertice baricentro, boolean equilatero){
    this.figura = figura;
    this.vertices = vertices;
    this.colorSilueta = colorSilueta;
    this.rotacion = rotacion;
    this.movible = true;
    this.posicion = new Vertice((int)random(450,550), (int)random(50,250));
    this.baricentro = baricentro;
    this.equilatero = equilatero;
  }
  
  public ArrayList<Vertice> getVertices(){
    return this.vertices;
  }
  public Figura getFigura(){
    return this.figura;
  }
  public color getColor(){
    return this.colorSilueta;
  }
  public boolean getMovible(){
    return this.movible;
  }
  public int getRotacion(){
    return this.rotacion;
  }
  public int getX(){
    return this.posicion.getX();
  }
  public int getY(){
    return this.posicion.getY();
  }
  public boolean getEquilatero(){
    return this.equilatero;
  }
  public Vertice getPosicion(){
    return posicion;
  }
  public void rotar(){
    if(movible)
      this.rotacion = (this.rotacion+1)%8;
  }
  public void moveX(int value){
    if(movible){
      this.posicion.sumarX(value);
    }
  }
  public void moveY(int value){
    if(movible){
      this.posicion.sumarY(value);
    }
  }
  public void reubicar(){
    this.posicion = new Vertice((int)random(450,550), (int)random(50,250));
  }
  private boolean comprobarEquilatero(){
    double d1,d2,d3,d4;
    switch(figura){
      case TRIANGULO:
        d1 = distanciaPuntos(vertices.get(0), vertices.get(1)); 
        d2 = distanciaPuntos(vertices.get(1), vertices.get(2)); 
        d3 = distanciaPuntos(vertices.get(2), vertices.get(0));
        return  d1== d2&& d2 ==d3 ;
      case RECTANGULO:
         int lx[]= {vertices.get(0).getX(),vertices.get(1).getX(),vertices.get(2).getX(),vertices.get(3).getX()};
         int px[]= {0,1,2,3};
         ordenarMenorMayor(lx, px);
         int ly[]= {vertices.get(0).getY(),vertices.get(1).getY(),vertices.get(2).getY(),vertices.get(3).getY()};
         int py[]= {0,1,2,3};
         ordenarMenorMayor(ly, py);
         int iD1 = devolverUltimo(px[0],px[1], py);
         int iD2 = devolverPrimero(px[2],px[3], py);
         int iD3 = (iD1 == px[0]? px[1] : px[0]);
         int iD4 = (iD2 == px[2]? px[3] : px[2]);
         d1 = distanciaPuntos(vertices.get(iD1), vertices.get(iD3));
         d2 = distanciaPuntos(vertices.get(iD1), vertices.get(iD4));
         d3 = distanciaPuntos(vertices.get(iD2), vertices.get(iD3));
         d4 = distanciaPuntos(vertices.get(iD2), vertices.get(iD4));
         System.out.println("dist: "+d1);
         System.out.println(d2);
         System.out.println(d3);
         System.out.println(d4);
         return d1 == d2 && d2==d3 && d3 == d4;
    }
    return false;
  }
  private double distanciaPuntos(Vertice v1, Vertice v2){
    return Math.sqrt(Math.pow(v1.getX()-v2.getX(),2)+Math.pow(v1.getY()-v2.getY(),2));
  }
  public Silueta GenerarReplica(){
    
    ArrayList<Vertice> verticesRetorno = new ArrayList();
    for(int i = 0; i< this.vertices.size(); i++){
      verticesRetorno.add(new Vertice(this.vertices.get(i).getX(), this.vertices.get(i).getY()));
    }
    int rotacionRetorno = int(random(0,8));
    color colorSiluetaRetorno = color( random(128,204),random(128,204),random(128,204));
    Figura figuraRetorno = this.figura;
    
    return new Silueta(figuraRetorno, verticesRetorno, colorSiluetaRetorno, rotacionRetorno, this.baricentro, this.equilatero);
  
  }
  public void Dibujar(){
    pushMatrix();
    fill(colorSilueta);
      translate(this.posicion.getX(),this.posicion.getY());
    if(movible){
      rotate(this.rotacion*radians(45));
    }  
    
    switch(figura){
      case RECTANGULO: // Big ones.
        beginShape(QUADS);
        vertex(vertices.get(0).getX(), vertices.get(0).getY());
        vertex(vertices.get(1).getX(), vertices.get(1).getY());
        vertex(vertices.get(2).getX(), vertices.get(2).getY());
        vertex(vertices.get(3).getX(), vertices.get(3).getY());
        endShape();
        break;
      case TRIANGULO: // Small ones.
        beginShape(TRIANGLES);
        vertex(vertices.get(0).getX(), vertices.get(0).getY());
        vertex(vertices.get(1).getX(), vertices.get(1).getY());
        vertex(vertices.get(2).getX(), vertices.get(2).getY());
        endShape();
        break;
      } 
    popMatrix();
  }
  public void localizar(){
     switch(figura){
       case RECTANGULO:
         baricentro = generarBaricentroCuadrilatero(this.vertices.get(0),this.vertices.get(1),this.vertices.get(2), this.vertices.get(3));
         for(int i = 0; i<4; i++){
           this.vertices.get(i).sumarVertice(-1,baricentro);
         }
         posicion = baricentro;
       break;
       case TRIANGULO:
         baricentro =  generarBaricentro(this.vertices.get(0),this.vertices.get(1),this.vertices.get(2));
         for(int i = 0; i<3; i++){
           this.vertices.get(i).sumarVertice(-1,baricentro);
         }
         posicion = baricentro;
       break;
     }
  }
  private Vertice generarBaricentroCuadrilatero(Vertice v1, Vertice v2, Vertice v3, Vertice v4){
    System.out.println("Cuadrado: "+v1.toString()+ v2.toString()+v3.toString()+v4.toString()
    );
     if(!validarCuadrilatero(v1,v2,v3,v4)){
        System.out.println("error cuadri");
        return new Vertice(0,0);
     }
     ArrayList<Vertice> vlst = new ArrayList();
     vlst.add(v1);
     vlst.add(v2);
     vlst.add(v3);
     vlst.add(v4);
     int lx[]= {v1.getX(),v2.getX(),v3.getX(),v4.getX()};
     int px[]= {0,1,2,3};
     ordenarMenorMayor(lx, px);
     int ly[]= {v1.getY(),v2.getY(),v3.getY(),v4.getY()};
     int py[]= {0,1,2,3};
     ordenarMenorMayor(ly, py);
     int iD1 = devolverUltimo(px[0],px[1], py);
     int iD2 = devolverPrimero(px[2],px[3], py);
     int iD3 = (iD1 == px[0]? px[1] : px[0]);
     int iD4 = (iD2 == px[2]? px[3] : px[2]);
     
    System.out.println("\tDiagonales: "+vlst.get(iD1).toString()+vlst.get(iD2).toString());
     if(vlst.get(iD1).getX() == vlst.get(iD2).getX()){
        int aux = iD1;
        iD1 = iD3;
        iD3 = aux;
        aux = iD2;
        iD2= iD4;
        iD4 = aux;
     }
     Vertice 
     C1 = generarBaricentro(vlst.get(iD1),vlst.get(iD2),vlst.get(iD3)),
     C2 = generarBaricentro(vlst.get(iD1),vlst.get(iD2),vlst.get(iD4)),
     D1 = vlst.get(iD1),
     D2 = vlst.get(iD2);
     float
       C1X = C1.getX(), C2X = C2.getX(), C1Y = C1.getY(), C2Y = C2.getY(), D1X = D1.getX(), D2X = D2.getX(), D1Y = D1.getY(), D2Y = D2.getY();
     System.out.println("Linea1:"+C1.toString()+C2.toString()+" linea2:"+D1.toString()+ D2.toString());
     float
        Dm = (D2Y-D1Y)/(D2X-D1X),
        b2 = D2Y-Dm*D2X;
     int CX=0,CY = 0;
     if(C1X== C2X){
       
       CX = round(C1X);
       CY = round(Dm*C1X+b2);
     }
     else if(C1Y == C2Y){
       CY = round(C1Y);
       CX = round((C1Y-b2)/Dm);
       
     }
     else{
       float 
          Cm = (C2Y-C1Y)/(C2X-C1X),
          b1 = C1Y-Cm*C1X;
       if(D1Y == D2Y){
         CY = round(D1Y);
         CX = round((D1Y-b1)/Cm);
       }
       else{
         CX =round(b2/(Cm-Dm));
         CY = round(Cm*(b2/(Cm-Dm))+b1);
       }
     }
     System.out.println("\tBaricentro: "+CX+","+CY);
     return new Vertice(CX,CY);
  }
  private boolean validarCuadrilatero(Vertice v1, Vertice v2, Vertice v3, Vertice v4){
     return validarTriangulo(v1,v2,v3) &&
     validarTriangulo(v2,v3,v4) &&
     validarTriangulo(v3,v4,v1) &&
     validarTriangulo(v4,v1,v2);
  }
  private int devolverPrimero(int x1, int x2, int v[]){
    for(int i = 0; i<v.length; i++){
      if(x1 == v[i])
        return x1;
      if(x2 == v[i])
        return x2;
    }
    return 0;
  }
  private int devolverUltimo(int x1, int x2, int v[]){
    for(int i = v.length-1; i>=0; i--){
      if(x1 == v[i])
        return x1;
      if(x2 == v[i])
        return x2;
    }
    return 0;
  }
  private void ordenarMenorMayor(int l[], int p[]){
    int aux = 0;
    for(int i = 0; i < l.length; i++){
      for(int j=i+1; j < l.length; j++){
        if(l[i] > l[j]){
          aux = p[i];
          p[i] = p[j];
          p[j] = aux;
          aux = l[i];
          l[i] = l[j];
          l[j] = aux;
        }
      }
    }
  }
  private Vertice generarBaricentro(Vertice v1, Vertice v2, Vertice v3){
    if (!validarTriangulo(v1,v2,v3)){
      System.out.println("error trian");
      return new Vertice(0,0);
    }
    float 
      xa = v1.getX(),xb = v2.getX(),xc = v3.getX(),ya = v1.getY(),yb = v2.getY(),yc = v3.getY();
    if((xa+xb-2*xc)==0)
      return generarBaricentro(v2,v3,v1);
    if((xb+xc-2*xa) == 0)
      return generarBaricentro(v3,v1,v2);
    float
      A = (ya+yb-2*yc)/(xa+xb-2*xc), 
      B = (yc*(xa+xb)-xc*(ya+yb))/(xa+xb-2*xc), 
      C = (yb+yc-2*ya)/(xb+xc-2*xa), 
      D = (ya*(xb+xc)-xa*(yb+yc))/(xb+xc-2*xa);
    int 
      CX =round(((D-B)/(A-C))),
      CY = round(A*CX+B);
    return new Vertice(CX,CY);
  }
  private boolean validarTriangulo(Vertice v1, Vertice v2, Vertice v3){
    int 
      xa = v1.getX(),xb = v2.getX(),xc = v3.getX(),ya = v1.getY(),yb = v2.getY(),yc = v3.getY();
    return !(v1.iguales(v2) || v1.iguales(v3) || v2.iguales(v3) ||
    (xa == xb && xb == xc)||(ya == yb && yb == yc)|| evaluarPendiente(v1,v2,v3));
  }
  private boolean evaluarPendiente(Vertice v1, Vertice v2, Vertice v3){
    if(v1.getX() == v2.getX() || v1.x == v3.getX() || v3.x == v2.getX())
      return false;
    return (ontenerPendiente(v1, v2)+"" == ontenerPendiente(v2, v3)+"");
  
  }
  private double ontenerPendiente(Vertice v1, Vertice v2){
    double y1 = v1.getY(), y2 = v2.getY(), x1 = v1.getX(), x2= v2.getX();
    return (y2-y1)/(x2-x1);
  }
  public boolean validar(Silueta s){
    boolean retorno = (figura == s.figura && baricentro.cercanos(s.getPosicion(), 5) && validarRotacion(s) && validarVertices(s));
    if(retorno)
      System.out.println("Bien: "+s.figura+"("+s.getX()+","+ s.getY()+")");
     return retorno;
  }
  private boolean validarRotacion(Silueta s){
    if(!equilatero || s.figura == Figura.TRIANGULO)
      return (s.rotacion == 0||s.rotacion ==8);
     
     return (s.rotacion == 0||s.rotacion ==2||s.rotacion ==4||s.rotacion ==6||s.rotacion ==8);
  }
  private boolean validarVertices(Silueta s){
    boolean pertenece;
    for(Vertice v: vertices){
      pertenece = false;;
      for(Vertice vs: s.getVertices()){
        if(v.iguales(vs)){
          pertenece = true;
          break;
        }
      }
      if(!pertenece)
        return false;
    }
    return true;
  }
}