class Cell
{
   int i;
   int j;
   float size = 30;
   float offset = 10;
   boolean[] walls = {true, true, true, true};
   boolean visited;
   int path;
   
   public Cell(int i_, int j_)
   {
      i = i_;
      j = j_;
      path = 0;
      visited = false;
   }
   
   void display()
   {   
       if (visited)
       {
          fill(200);
          noStroke();
          
          rect(size * j, size * i, size, size); 
          
          
       }
       /*fill(0);
       stroke(0);
          text(path, size * j, size * i + size);*/
       stroke(0);
       if (walls[0])
          line(size * j, size * i, size * j, size * i + size);
       if (walls[1])
          line(size * j, size * i, size * j + size, size * i);
       if (walls[2])
          line(size * j + size, size * i, size * j + size, size * i + size);
       if (walls[3])
          line(size * j, size * i + size, size * j + size, size * i + size);
       textSize(12);
       fill(0);

   }
}