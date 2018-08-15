class Solver
{
   Agent a;
   Cell[][] maze;
   int count;
   Solver(Agent a_, Cell[][] maze_)
   {
      a = a_;
      maze = maze_;
      count = 0;
   }
   void solve()
   {
      maze[a.i][a.j].visited = true;
      maze[a.i][a.j].path = count;
      if (a.i == maze.length - 1 && a.j == maze[0].length - 1){
         a.won = true;
         return;
      }
      if (maze[a.i][a.j].walls[2] == false && maze[a.i][a.j + 1].visited == false){
         a.j++;  
      }
      else if (maze[a.i][a.j].walls[3] == false && maze[a.i + 1][a.j].visited == false){
         a.i++;  
      }
      else if (maze[a.i][a.j].walls[0] == false && maze[a.i][a.j - 1].visited == false){
         a.j--;  
      }
      else if ((a.i != 0 || a.j != 0) && maze[a.i][a.j].walls[1] == false && maze[a.i - 1][a.j].visited == false){
         a.i--;  
      }
      else
      {
         if (maze[a.i][a.j].walls[2] == false && maze[a.i][a.j + 1].path == count - 1){
         a.j++;  
         }
         else if (maze[a.i][a.j].walls[3] == false && maze[a.i + 1][a.j].path == count - 1){
            a.i++;  
         }
         else if (maze[a.i][a.j].walls[0] == false && maze[a.i][a.j - 1].path == count - 1){
            a.j--;  
         }
         else if (maze[a.i][a.j].walls[1] == false && maze[a.i - 1][a.j].path == count - 1){
            a.i--;  
         }
         else
         {
            return;
         }
         count--;
         return;
      }
      
      count++;
      maze[a.i][a.j].path = count;
      maze[a.i][a.j].visited = true;
      
   }
}