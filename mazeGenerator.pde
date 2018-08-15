// Random Maze Generator
// rows and cols must be at least 2
int rows = 20;
int cols = 20;

Cell[][] maze;
Agent a;
Solver s;
boolean solve = false;

void setup()
{
   width = width - 200;
   size(1000, 700);

   a = new Agent();
   
   frameRate(30);
   generate();
   s = new Solver(a, maze);
   
}
void draw()
{
   if (solve && frameCount % 3 == 0)
      s.solve();
   background(255);
   fill(0);
   
   textSize(12);
   text("Use WASD to move", width - 10, 50);
   text("Press r to restart maze", width - 10, 100);
   text("Press n for new maze", width - 10, 150);
   text("Press l to toggle auto-solve", width - 10, 200);

   translate(20, 20);

   for (int i = 0; i < rows; i++)
   {
      for (int j = 0; j < cols; j++)
      {
         maze[i][j].display();
      }
   }

   fill(0, 255, 0);
   a.display(maze[a.i][a.j]);
   //println(a.i + " " + a.j + " " + cols + " " + rows);
   if (a.won)
   {
       textSize(48);
       //textMode(CENTER);
       fill(0);
       text("You Win!", width/2 - 100, height/2 - 20);
   }

}
void keyPressed()
{
   if(key == 'r'){
      a = new Agent();
      s = new Solver(a, maze);
      clearMeta();
      solve = false;
   }
   if(key == 'n'){
      generate();
      a = new Agent();
      s = new Solver(a, maze);
      solve = false;
   }
   if (!a.won)
   {
      if (key == 'l'){
         if (solve)
            clearMeta();
         solve = !solve;
         
      }
      if (!solve)
      {
         if (key == 'w' || key == 'W')
         {
      
            if (a.i > 0 && maze[a.i][a.j].walls[1] == false)
            {
               a.i--;
            }
         }
         if (key == 's' || key == 'S')
         {
      
            if (maze[a.i][a.j].walls[3] == false)
            {
               a.i++;
            }
         }
         if (key == 'a'  || key == 'A')
         {
      
            if (maze[a.i][a.j].walls[0] == false)
            {
               a.j--;
            }
         }
         if (key == 'd' || key == 'D')
         {
            if (a.j == cols - 1 && a.i == rows - 1)
            {
               a.won = true;
            }
            if (a.j < cols - 1 && maze[a.i][a.j].walls[2] == false)
            {
               a.j++;
            }
         }
      }
   }
}
   
void generate()
{
   maze = new Cell[rows][cols];
   for (int i = 0; i < rows; i++)
   {
      for (int j = 0; j < cols; j++)
      {
         maze[i][j] = new Cell(i, j);
         maze[i][j].size = min(width/(cols + 2), height/(rows + 2));
      }
   }
   int i = rows/2;
   int j = cols/2;
   int count = 1;
   
   while (i != rows/2 || j != cols/2 || maze[i][j].visited == false)
   {

      maze[i][j].visited = true;
      maze[i][j].path = count;
      count++;
      
      //if nothing to move to;
      if ((j == 0 || maze[i][j-1].visited == true) 
      && (j == cols - 1 || maze[i][j+1].visited == true)
      && (i == rows - 1 || maze[i + 1][j].visited == true) 
      && (i == 0 || maze[i - 1][j].visited == true)){
         count-=2;
         if (j > 0 && maze[i][j-1].path == count)
            j--;
         else if (j < cols - 1 && maze[i][j+1].path == count)
            j++;
         else if (i > 0 && maze[i-1][j].path == count)
            i--;
         else if (i < rows - 1 && maze[i+1][j].path == count)
            i++;
      }
      else{ //otherwise move
         boolean moved = false;
         while (!moved){ //choose randomly until valid move
            int rand = (int)random(4);
            if (rand == 0 && j > 0 && maze[i][j-1].visited == false){ //left
               maze[i][j].walls[0] = false;
               maze[i][j - 1].walls[2] = false;
               j--;
               moved = true;
            }
            else if (rand == 1 && i > 0 && maze[i-1][j].visited == false){ //up
               maze[i][j].walls[1] = false;
               maze[i - 1][j].walls[3] = false;
               i--;
               moved = true;
            }
            else if (rand == 2 && j < cols - 1 && maze[i][j+1].visited == false){ //right
               maze[i][j].walls[2] = false;
               maze[i][j + 1].walls[0] = false;
               j++;
               moved = true;
            }
            else if (rand == 3 && i < rows - 1 && maze[i+1][j].visited == false){ //down
               maze[i][j].walls[3] = false;
               maze[i + 1][j].walls[1] = false;
               i++;         
               moved = true;
            }
         }
      }
   }
   maze[0][0].walls[1] = false;
   maze[rows - 1][cols - 1].walls[2] = false;
   clearMeta();
}
void clearMeta()
{
   for (int i = 0; i < rows; i++)
   {
      for (int j = 0; j < cols; j++)
      {
         maze[i][j].visited = false;
         maze[i][j].path = 0;
      }
   }
         
}