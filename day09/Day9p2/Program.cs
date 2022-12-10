using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Day9p2
{
    internal class Program
    {
        static void Main(string[] args)
        {
            List<string> rows = GetInput(args[0]);
            Rope rope = new Rope(9);
            List<Position> visitedPositions = new List<Position>();
            foreach (string row in rows)
            {
                Direction dir = (Direction)Enum.Parse(typeof(Direction), row.Substring(0, 1));
                int amount = int.Parse(row.Substring(2));
                for (int i = 0; i < amount; i++)
                {
                    Position parentOriginalPos = rope.head.Position.GetCopy();
                    Position parentNewPos = rope.head.Move(dir);
                    foreach (Tail tail in rope.tails)
                    {
                        Position tempOriginalPosition = tail.Position.GetCopy();
                        parentNewPos = tail.Move(parentOriginalPos, parentNewPos);
                        parentOriginalPos = tempOriginalPosition.GetCopy();
                        if (tail.TailNum == 9)
                        {
                            visitedPositions.Add(tail.Position.GetCopy());
                        }
                    }
                }
            }
            List<Position> uniquePositions = visitedPositions.Distinct(new PositionComparer()).ToList();
            int Count = uniquePositions.Count();

            Console.WriteLine("Visited positions: {0}", Count);
            Console.ReadKey();
        }

        private static List<string> GetInput(string path)
        {
            return File.ReadAllLines(path).ToList();
        }
    }
}
