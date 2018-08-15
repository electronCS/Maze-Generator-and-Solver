class Agent
{
   int i;
   int j;
   boolean won;
   
   public Agent()  
   {
      i = 0;
      j = 0;
   }
   void display(Cell c)
   {
       if (!won)
          ellipse(c.size * j + c.size/2, c.size * i + c.size/2, c.size, c.size);
       else
          ellipse(c.size * j + 3 * c.size/2, c.size * i + c.size/2, c.size, c.size);
   }
   
}