int x, y, player_size, x2, y2,dot_size; 
boolean A=false;
boolean S=false;
boolean D=false;
boolean W=false;
boolean Up=false;
boolean Down=false;
boolean Left=false;
boolean Right=false;
int mycolor;
color ColorPlayer1, ColorPlayer2;
float map_pintat, pintat_1, pintat_2;
int heightUI;
int heightPis;
float timer, time;
float timer_final, time_final;
int RedScore;
int BlueScore;
int FinalRed;
int FinalBlue;
int state=0;
float partidaTemps;

void setup() {
  size(1920, 1080);
  //Posició jugador 
  x=width/2;
  y=height/2;
  x2=width/2+100;
  y2=height/2+100;
  //Mida jugador 
  player_size=50;
  dot_size=10;
  heightUI=int(height*0.2);
  heightPis=height-heightUI;
  partidaTemps=60;
  time= partidaTemps;//1 min
  background(0);
  noStroke();
  // INICI PLAYERS
  // PLAYER 1 i puntet
  ColorPlayer1 = color(255, 0, 0); 
  fill(ColorPlayer1);
  circle(x, y, player_size);
  fill(255);
  circle(x, y, dot_size);
  //PLAYER 2 i puntet
  ColorPlayer2 = color(20, 0, 255); 
  fill(ColorPlayer2);
  circle(x2, y2, player_size);
  fill(255);
  circle(x2, y2, dot_size);
  // FIN PLAYERS
  map_pintat=heightPis*width;
  timer=1000;
  
}

void draw() {
  //Pantalla inicial 
  if (state==0) {
    background(0);
    textSize(100);
    textAlign(CENTER);
    fill(255);
    text("Paint War", width*0.5, height*0.5);
    text("PLAY", width*0.5, height*0.9);  
    timer=millis();
  }
  //Pantalla final
  if (state==2) {
    
    background(0);
    textSize(100);
    textAlign(CENTER);
    if(FinalRed>FinalBlue){
      fill(255,0,0);
      text("TEAM RED WINS!!", width*0.5, height*0.4);      
    }else{
      fill(20,0,255);
      text("TEAM BLUE WINS!!", width*0.5, height*0.4);    
    }
    fill(255,0,0);
    text(RedScore+"%", width*0.4, height/2);
    fill(20,0,255);
    text(BlueScore+"%", width*0.6, height/2);
  }
//Pantalla joc
  if (state==1) {
    //Quan el temps s’acaba final del joc
    if (time==0) {
      timer_final=millis();
      time_final=3;
      FinalRed=RedScore;
      FinalBlue=BlueScore;
      state=2;
      //Conta enrere del temps 
    } else if(time!=0 && state==1) {
      if (millis() > timer) {
        time--;
        timer += 1000;
      }
   //Càlcul del tant per cent pintat per cada jugador 
      pintat_1=0;
      pintat_2=0;

      for (int i=0; i<width; i++) {
        for (int j=0; j<heightPis; j++) {
          if (red(get(i, j))==red(ColorPlayer1)) {
            pintat_1++;
          }
          if (red(get(i, j))==red(ColorPlayer2)) {
            pintat_2++;
          }
        }
      }
      RedScore=round((pintat_1/map_pintat)*100);
      BlueScore=round((pintat_2/map_pintat)*100);

//Pinta els jugador 
      noStroke();
      fill(ColorPlayer1);
      circle(x, y, player_size);
      fill(255);
      circle(x, y, dot_size);
      fill(ColorPlayer2);
      circle(x2, y2, player_size);
      fill(255);
      circle(x2, y2, dot_size);
      
//Controls jugadors
      //PLAYER 1
      if (A) {
        fill(ColorPlayer1);
        x=x-10;
        circle(x, y, player_size);
        fill(255);
        circle(x, y, dot_size);
      }
      if (S) {
        fill(ColorPlayer1);
        y=y+10;
        circle(x, y, player_size);
        fill(255);
        circle(x, y, dot_size);
      }
      if (D) {
        fill(ColorPlayer1);
        x=x+10;
        circle(x, y, player_size);
        fill(255);
        circle(x, y, dot_size);
      }
      if (W) {
        fill(ColorPlayer1);
        y=y-10;
        circle(x, y, player_size);
        fill(255);
        circle(x, y, dot_size);
      }

      //PLAYER 2    
      if (Left) {
        fill(ColorPlayer2);
        x2=x2-10;
        circle(x2, y2, player_size);
        fill(255);
        circle(x2, y2, dot_size);
      }
      if (Down) {
        fill(ColorPlayer2);
        y2=y2+10;
        circle(x2, y2, player_size);
        fill(255);
        circle(x2, y2, dot_size);
      }
      if (Right) {
        fill(ColorPlayer2);
        x2=x2+10;
        circle(x2, y2, player_size);
        fill(255);
        circle(x2, y2, dot_size);
      }
      if (Up) {
        fill(ColorPlayer2);
        y2=y2-10;
        circle(x2, y2, player_size);
        fill(255);
        circle(x2, y2, dot_size);
      }
      marges();
      ui();
    }
  }
}

void keyPressed() {
  if (state==0) {
    state=1;
  }
  if (state==2) {
    time= partidaTemps;
    if(millis() > timer_final){
      time_final--;
      timer_final+=1000;
    }
    if(time_final <= 0){
      
      state=1;
      timer=millis();
    }
    
  }
  // player1
  if (key == 'A' || key == 'a') {
    A=true;
  }
  if (key == 'S' || key == 's') {
    S=true;
  }
  if (key == 'D' || key == 'd') {
    D=true;
  }
  if (key == 'W' || key == 'w') {
    W=true;
  }


  //player2
  if (keyCode == LEFT) {
    Left=true;
  }
  if (keyCode == DOWN) {
    Down=true;
  }
  if (keyCode == RIGHT) {
    Right=true;
  }
  if (keyCode == UP) {
    Up=true;
  }

  
}

void keyReleased() {
  //player uno
  if (key == 'A' || key == 'a') {
    A=false;
  }
  if (key == 'S' || key == 's') {
    S=false;
  }
  if (key == 'D' || key == 'd') {
    D=false;
  }
  if (key == 'W' || key == 'w') {
    W=false;
  }


  //playero 2
  if (keyCode == LEFT) {
    Left=false;
  }
  if (keyCode == DOWN) {
    Down=false;
  }
  if (keyCode == RIGHT) {
    Right=false;
  }
  if (keyCode == UP) {
    Up=false;
  }
  
}
//Marges per la mostra de dades durant la partida 
void marges() {
  if (x>width)x=width;
  if (x<0)x=0;
  if (y<0)y=0;
  if (y>heightPis)y=heightPis;

  if (x2>width)x2=width;
  if (x2<0)x2=0;
  if (y2<0)y2=0;
  if (y2>heightPis)y2=heightPis;
}
//La mostra de dades durant la partida 
void ui() {///// Vermell  Blau 
  fill(100, 100, 100);
  rect(0, heightPis, width, heightPis);
  fill(255);
  textSize(64);
  textAlign(CENTER);
  int m=int(time/60);
  int s=int(time-(m*60));
  if (s<10) {
    text(m+":0"+s, width/2, heightPis+heightUI/2);
  } else {
    text(m+":"+s, width/2, heightPis+heightUI/2);
  }
  /////////PUNTUACIONS//////
  //Puntuacio RED
  fill(255, 0, 0);
  text(RedScore+"%", width*0.25, heightPis+heightUI/2);
  // Puntuacio BLUE
  fill(20, 0, 255);
  text(BlueScore+"%", width*0.75, heightPis+heightUI/2);
}
