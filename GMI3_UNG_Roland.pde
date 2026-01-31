/////////////////////////////////////////////////////
//
// Démineur
// DM "UED 131 - Programmation impérative" 2023-2024
// NOM         : UNG
// Prénom      : Roland
// N° étudiant : 20231933
//
// Collaboration avec :
//
/////////////////////////////////////////////////////

//déclaration de variables
int cote, bandeau, colonnes, lignes, etat, time, start, score;
final int INIT=0, STARTED=1, OVER=2, BLOC=1, EMPTY=0, FLAG=2;
PFont myFont;
int [][] paves, nb_bombes;
boolean [][] bombes;


void settings() { //initialise le programme

cote=20;
bandeau = 50;
colonnes = 30;
lignes = 16;
size(colonnes*cote, lignes*cote+bandeau); //30*20=600 et 16*20+50=370

etat = INIT;

//appel ici pour pas créer des bombes à l'infini et réinitialiser les tableaux
init();
}

void draw() { //appelle les fonctions en permanent

display();
drawTime();
drawScore();
}


void init() { //initialise le jeu

//tableaux définis
paves = new int[colonnes][lignes];
bombes = new boolean[colonnes][lignes];
nb_bombes = new int[colonnes][lignes];

//initialisation des tableaux
for (int x=0; x<colonnes; x++) {
for (int y=0; y<lignes; y++) {
paves[x][y]=BLOC;
bombes[x][y]=false; 
nb_bombes[x][y]=0; 
}}

//bombes aléatoires
for (int i=0; i<100; i++) {
int x= int(random(colonnes));
int y= int(random(lignes));
bombes[x][y]=true; 
}

//calculer le nombre de bombes autour
for (int x=0; x<colonnes; x++) {
for (int y=0; y<lignes; y++) {
if ((x-1)>0 && (y-1)>0) { //d'abord savoir si c'est dans la limite
  if (bombes[x-1][y-1]==true) { //vérification bombes
    nb_bombes[x][y] +=1 ; }}
if ((x-1)>0) {
  if (bombes[x-1][y]==true) {
    nb_bombes[x][y] +=1 ; }}
if ((x-1)>0 && (y+1)<lignes) {
  if (bombes[x-1][y+1]==true) {
    nb_bombes[x][y] +=1 ; }}
if ((y-1)>0) {
  if (bombes[x][y-1]==true) {
    nb_bombes[x][y] +=1 ; }}
if ((y+1)<lignes) {
  if (bombes[x][y+1]==true) {
    nb_bombes[x][y] +=1 ; }}
if ((x+1)<colonnes && (y-1)>0) {
  if (bombes[x+1][y-1]==true) {
    nb_bombes[x][y] +=1 ; }}
if ((x+1)<colonnes) {
  if (bombes[x+1][y]==true) {
    nb_bombes[x][y] +=1 ; }}
if ((x+1)<colonnes && (y+1)<lignes) {
  if (bombes[x+1][y+1]==true) {
    nb_bombes[x][y] +=1 ; }}

//calculer le nombres de bombes TOTAL
if (bombes[x][y]==true) {
  score += 1 ; }

}}
}


void display() { //affiche le jeu

//fond du jeu
background(57, 59, 51);

//afficher bandeau
fill(192,192,192);
rect(0,0,width,bandeau);

//afficher smiley et son bloc dans le bandeau
drawBlocSmiley(); 
if (etat==INIT || etat==STARTED) {
drawHappyFace(); }
else { drawSadFace();  }


//grille
for (int x=0; x<colonnes; x++) {
for (int y=0; y<lignes; y++) {

//afficher TOUTES les bombes si c'est perdu
if (etat==OVER && bombes[x][y]==true) {
paves[x][y]=EMPTY; }

//afficher des blocs
if (paves[x][y]==BLOC || paves[x][y]==FLAG) {
drawBloc(x,y); }

//afficher des drapeaux
if (paves[x][y]==FLAG) {
drawFlag(x,y); }

//afficher des bombes
if (paves[x][y]==EMPTY && bombes[x][y]==true) {
drawBomb(x,y); }

//afficher le nombre de bombes autour
if (bombes[x][y]==false && nb_bombes[x][y]!=0 && paves[x][y]==EMPTY) {
myFont = createFont("mine-sweeper.ttf",13);
textFont(myFont);
textSize(10);
if (nb_bombes[x][y]==1) {
  fill(0,35,245); }
else if (nb_bombes[x][y]==2) {
  fill(55,125,35); }
else if (nb_bombes[x][y]==3) {
  fill(235,50,35); }
else if (nb_bombes[x][y]==4) {
  fill(120,25,120); }
else if (nb_bombes[x][y]==5) {
  fill(115,20,10); }
else if (nb_bombes[x][y]==6) {
  fill(55,125,125); }
else { fill(0,0,0); }
text(nb_bombes[x][y],x*cote+6,y*cote+bandeau+16); }

//si vide, faire découvrir les vides autour
if (paves[x][y]==EMPTY && nb_bombes[x][y]==0 && etat!=OVER) {
decouvre(x,y); }

}}
}


void drawBloc(int x, int y) { //dessine un bloc

pushMatrix();
translate(x*cote, y*cote+bandeau);
strokeWeight(0);

//grand carré
fill(128, 128, 128);
rect(2, 2, 16, 16);

//lignes horizontales blanches
fill(255);
stroke(255);
rect(0, 0, 19, 1);
rect(0, 1, 18, 1);

//lignes verticales blanches
rect(0, 2, 1, 17);
rect(1, 2, 1, 16);

//lignes horizontales grises
fill(104, 106, 93);
stroke(104, 106, 93);
rect(1, 18, 19, 1);
rect(0, 19, 20, 1);

//lignes verticales grises
rect(18, 1, 1, 17);
rect(19, 0, 1, 18);

popMatrix();
}

void drawFlag(int x, int y) { //dessin un drapeau

pushMatrix();
translate(x*cote, y*cote+bandeau);
strokeWeight(0);

//embleme rouge
fill(255, 0, 0);
stroke(255, 0, 0);
rect(9, 4, 1, 1);
rect(7, 5, 3, 1);
rect(5, 6, 5, 1);
rect(7, 7, 3, 1);
rect(9, 8, 1, 1);

//verticale noire
fill(0);
stroke(0);
rect(10, 4, 1, 9);
rect(6, 13, 9, 1);
rect(6, 14, 9, 1);
rect(4, 15, 13, 1);
rect(4, 16, 13, 1);

popMatrix();
}

void drawBomb(int x, int y) { //dessine une bombe

pushMatrix();
translate(x*cote, y*cote+bandeau);
strokeWeight(0);

//rond blanc
fill(255);
stroke(255);
rect(7, 9, 1, 2);
rect(8, 8, 2, 4);
rect(10, 9, 1, 2);

//remplissage noir
fill(0);
stroke(0);

//trait diagonale haut gauche
rect(5, 5, 1, 1);
rect(6, 6, 1, 1);

//trait diagonale haut droite
rect(15, 5, 1, 1);
rect(14, 6, 1, 1);

//trait diagonale bas gauche
rect(6, 14, 1, 1);
rect(5, 15, 1, 1);

//trait diagonale bas droite
rect(14, 14, 1, 1);
rect(15, 15, 1, 1);

//trait horizontale
rect(4, 10, 2, 1);
rect(15, 10, 2, 1);

//rond noir
rect(6, 8, 1, 5);
rect(7, 7, 1, 2);
rect(7, 11, 1, 3);
rect(8, 6, 2, 2);
rect(8, 12, 2, 3);
rect(10, 4, 1, 5);
rect(10, 11, 1, 6);
rect(11, 6, 2, 9);
rect(13, 7, 1, 7);
rect(14, 8, 1, 5);

popMatrix();
}

void drawBlocSmiley() { //dessine le bloc du smiley

pushMatrix();
translate(270, 5);
strokeWeight(0);

//grand carré
fill(128, 128, 128);
rect(2, 2, 38, 38);

//lignes horizontales blanches
fill(255);
stroke(255);
rect(0, 0, 38, 2);
rect(0, 2, 36, 2);

//lignes verticales blanches
rect(0, 2, 2, 34);
rect(1, 4, 2, 32);

//lignes horizontales grises
fill(104, 106, 93);
stroke(104, 106, 93);
rect(1, 36, 38, 2);
rect(0, 38, 40, 2);

//lignes verticales grises
rect(36, 2, 2, 34);
rect(38, 0, 2, 36);

popMatrix();
}

void drawHappyFace() { //dessine un visage content

pushMatrix();
translate(190,5);
strokeWeight(2);

//tête
fill(255, 255, 0);
ellipse(100, 20, 30, 30);

//yeux
fill(0);
ellipse(94, 16, 3, 3);
ellipse(106, 16, 3, 3);

//bouche
noFill();
arc(100, 25, 15, 10, PI/6, 5*PI/6);

popMatrix();
}

void drawSadFace() { //dessine un visage mécontent

pushMatrix();
translate(190,5);
strokeWeight(2);

//tête
fill(255, 255, 0);
ellipse(100, 20, 30, 30);

//oeil gauche
line(91, 13, 97, 18);
line(97, 13, 91, 18);

//oeil droite
line(102, 13, 108, 18);
line(108, 13, 102, 18);

//bouche
noFill();
arc(100, 30, 15, 10, 7*PI/6, 11*PI/6);

popMatrix();
}


void mouseClicked() { //interaction entre la souris et le programme

int i = mouseX/cote ;
int j = (mouseY-bandeau)/cote ;

if (etat==INIT) {
  start=millis();
  
  //cliquer pour démarrer
  if (mouseY>bandeau)  {
  etat=STARTED; }
  //clique sur bandeau
  else
  etat= INIT;
}

 

else if (etat==STARTED) {
  
  if(mouseButton==37 && paves[i][j]==BLOC) {    
    paves[i][j]=EMPTY; //passage de BLOC à EMPTY
      if(bombes[i][j]==true) {       
      etat=OVER; }} //jeu terminé                 
  else if(mouseButton==39) {
    if (paves[i][j]==BLOC) {
      paves[i][j]=FLAG; //passage de BLOC à FLAG
      score -= 1 ; } // décrémentation
    else if(paves[i][j]==FLAG) {   
      paves[i][j]=BLOC;  // passage de FLAG à BLOC
      score += 1 ; }} // incrémentation
}

  //smiley cliqué
  if (mouseX>270 && mouseX<310 && mouseY>5 && mouseY<45) {
  etat=INIT; 
  score=0;
  init(); }
}



void decouvre(int x, int y) { //affiche les cases vides voisines

if ((x-1)>0 && (y-1)>0) {
  paves[x-1][y-1]=EMPTY; }
if ((x-1)>0) {
  paves[x-1][y]=EMPTY; }
if ((x-1)>0 && (y+1)<lignes) {
  paves[x-1][y+1]=EMPTY; }
if ((y-1)>0) {
  paves[x][y-1]=EMPTY; }
if ((y+1)<lignes) {
  paves[x][y+1]=EMPTY; }
if ((x+1)<colonnes && (y-1)>0) {
  paves[x+1][y-1]=EMPTY; }
if ((x+1)<colonnes) {
  paves[x+1][y]=EMPTY; }
if ((x+1)<colonnes && (y+1)<lignes) {
  paves[x+1][y+1]=EMPTY; }
}


void drawTime() { //affiche et défini le chrono
  
//rectangle noir
fill(0);
rect(510,5,80,40);
myFont = createFont("DSEG7Classic-Bold.ttf",32);
textFont(myFont);
fill(90,10,10);
textSize(32);
text("888",512,40);

//définir le temps
if (etat==INIT) {
time=0; }
else if (etat==STARTED) {
time=int(millis()-start)/1000; }

//afficher les secondes
fill(255,0,0);
if (time<10) {
text("00",512,40);
text(time,562,40); }
else if (time<100) {
text("0",512,40);
text(time,537,40); }
else if (time<1000) {
text(time,512,40); }
else text("000",512,40);
}

void drawScore() { //affiche le nombre de mine à trouver
  
//rectangle noir
fill(0);
rect(5,5,80,40);
myFont = createFont("DSEG7Classic-Bold.ttf",32);
textFont(myFont);
fill(90,10,10);
textSize(32);
text("888",7,40);

//afficher le score
fill(255,0,0);
if (score<10) {
text("00",7,40);
text(score,57,40); }
else if (score<100) {
text("0",7,40);
text(score,32,40); }
else if (score<1000) {
text(score,7,40); }

}
