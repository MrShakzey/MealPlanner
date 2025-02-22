using DbUp;
using System.Reflection;

namespace MealPlanner.Server
{
   public static class MigrationScripts
   {
      public static bool Configure(string connectionString)
      {        
         var upgrader =
             DeployChanges.To
                 .SqlDatabase(connectionString)
                 .WithScriptsEmbeddedInAssembly(Assembly.GetExecutingAssembly())
                 .LogToConsole()
                 .Build();

         var result = upgrader.PerformUpgrade();

         if (!result.Successful)
         {
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine(result.Error);
            Console.ResetColor();
#if DEBUG
            Console.ReadLine();
#endif
            return false;
         }

         Console.ForegroundColor = ConsoleColor.Green;
         Console.WriteLine("Success!");
         Console.ResetColor();
         return true;
      }
   }
}
