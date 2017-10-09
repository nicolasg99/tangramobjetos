import java.io.*;
import java.util.ArrayList;
import java.lang.Math;

private final String PATH = "C:\\Users\\usuario\\Downloads\\Tangram_v0_5\\niveles"; 
 private ArrayList<Nivel> niveles;
 private File[] listOfFiles;
 private int nivelActual;
 private int currentFile;
 private int has;
 private boolean start = false;
 private boolean ini = true;
 private boolean win = false;
 private boolean fin = false;
 private boolean errorShape = false;
 private boolean errorPath = false;
 
 
public enum Figura{
  RECTANGULO, TRIANGULO, INDEFINIDA
};

void setup(){
  size(800,800);
  noStroke();
}
void falsear(){
  start = ini = win = fin = errorShape = errorPath = false;
}
void reinicio(){
  File folder = new File(PATH);
  listOfFiles = folder.listFiles(); 
  niveles = new ArrayList();
  currentFile = 0;
  sigNivel();
  this.nivelActual = 0;
  has = -1;
}
void sigNivel(){
  if(currentFile>=listOfFiles.length){
    falsear();
    fin = true;
    return;
  }
  for(; currentFile < listOfFiles.length; ){   
    if (listOfFiles[currentFile].isFile()){
        niveles.add(new Archivo().generarNivel(listOfFiles[currentFile]));
        currentFile++;
        break;
    }
  }
}
void draw(){
  loadPixels();
  background(0);
  if(start){
    niveles.get(nivelActual).dibujarNivel();
    if( mousePressed && (has != -1) ){
      niveles.get(nivelActual).moverFigura(has, mouseX-pmouseX, mouseY-pmouseY);
      validar();
    }
  }
  else if(ini){
    text("Bienvenido, \n-P para iniciar o pausar, \n-Click derecho para girar, -Mouse para mover, \n-1 para reiniciar", width/2-100, height/2-40);
  }
  else if(win){
    text("Has ganado, oprime p para continuar", width/2-100, height/2-20);
  }
  else if(fin){
    text("Felicidades, has completado el juego, oprime p para reiniciar.", width/2-100, height/2-20);
  }
  else if(errorShape){
    text("Ha ocurrido un error al leer el nivel, revisa tu.", width/2-100, height/2-20);
  }
  else{
    text("Pausa, oprime p para iniciar", width/2-100, height/2-20);
  }
}
void validar(){
    if(niveles.get(nivelActual).validarNivel()){
       userWIN();
    }
}
void userWIN(){
  falsear();
  nivelActual++;
  win = true;
  sigNivel();
}
void mousePressed(){
  if( start && mouseButton == LEFT ){
     color mouseC = get(mouseX,mouseY);
     for(int j=0;j<niveles.get(nivelActual).getSize();j++){
        if( niveles.get(nivelActual).obtenerFigura(j).getColor() == mouseC ){
          has = j;
        }
     }   
  }
}

void mouseReleased(){
  if(start){
    has = -1;
    for(int i=0;i<niveles.get(nivelActual).getSize();i++){
      int px = niveles.get(nivelActual).obtenerFigura(i).getX();
      int py = niveles.get(nivelActual).obtenerFigura(i).getY();
      if( px < 0 || px > width || py < 0 || py > height ){
        niveles.get(nivelActual).obtenerFigura(i).reubicar();
      }
    }
  }
}

void mouseClicked(){
  if(start && mouseButton == RIGHT ){
    color mouseC = get(mouseX,mouseY);
    
    for(int j=0;j<7;j++){
      if( niveles.get(nivelActual).obtenerFigura(j).getColor() == mouseC ){
        niveles.get(nivelActual).obtenerFigura(j).rotar();
        validar();
      }
    }   
  }  
}

void keyReleased(){
  if( start && key == '1'){
    reinicio();
  }
  else if(key == 'p'){
    if(ini || fin)
      reinicio();
    if(win)
      win = false;
    start = !start;
    ini = false;
  }
}
void ShapeError(){

}