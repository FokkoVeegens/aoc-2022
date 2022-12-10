using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Day9p2
{
    enum Direction
    {
        None = 0,
        U = 2,
        D = 4,
        L = 8,
        R = 16,
        UL = 10,
        UR = 18,
        DL = 12,
        DR = 20
    }

    internal class Rope
    {
        public Head head { get; set; }
        public List<Tail> tails { get; set; }
        public Rope(int tailLength)
        {
            tails = new List<Tail>();
            for (int i = 1; i <= tailLength; i++)
            {
                tails.Add(new Tail(i));
            }
            head = new Head();
        }
    }

    internal class Head
    {
        public Position Position { get; set; }
        public Head()
        {
            Position = new Position(0, 0);
        }
        public Position Move(Direction direction)
        {
            switch (direction)
            {
                case Direction.U:
                    Position.y++;
                    break;
                case Direction.D:
                    Position.y--;
                    break;
                case Direction.L:
                    Position.x--;
                    break;
                case Direction.R:
                    Position.x++;
                    break;
            }
            return Position;
        }
    }

    internal class Tail
    {
        public Position Position { get; set; }
        public int TailNum { get; set; }
        public Tail(int tailNum)
        {
            Position = new Position(0, 0);
            TailNum = tailNum;
        }

        public Position Move(Position parentOriginalPosition, Position parentNewPosition)
        {
            if (parentOriginalPosition.Equals(Position))
            {
                return Position;
            }
            Direction parentDirection = parentOriginalPosition.GetDirectionTo(parentNewPosition);
            int xOffset = Position.x - parentOriginalPosition.x;
            int yOffset = Position.y - parentOriginalPosition.y;
            switch (parentDirection)
            {
                case Direction.U:
                    if (yOffset == -1 )
                    {
                        Position.y++;
                        if (xOffset != 0)
                        {
                            Position.x += -xOffset;
                        }
                    }
                    break;
                case Direction.D:
                    if (yOffset == 1)
                    {
                        Position.y--;
                        if (xOffset != 0)
                        {
                            Position.x += -xOffset;
                        }
                    }
                    break;
                case Direction.L:
                    if (xOffset == 1)
                    {
                        Position.x--;
                        if (yOffset != 0)
                        {
                            Position.y += -yOffset;
                        }
                    }
                    break;
                case Direction.R:
                    if (xOffset == -1)
                    {
                        Position.x++;
                        if (yOffset != 0)
                        {
                            Position.y += -yOffset;
                        }
                    }
                    break;
                case Direction.UL:
                    if (xOffset == 1 || (xOffset == 0 && yOffset == -1))
                    {
                        Position.x--;
                    }
                    if (yOffset == -1 || (xOffset == 1 && yOffset == 0))
                    {
                        Position.y++;
                    }
                    break;
                case Direction.UR:
                    if (xOffset == -1 || (xOffset == 0 && yOffset == -1))
                    {
                        Position.x++;
                    }
                    if (yOffset == -1 || (xOffset == -1 && yOffset == 0))
                    {
                        Position.y++;
                    }
                    break;
                case Direction.DL:
                    if (xOffset == 1 || (xOffset == 0 && yOffset == 1))
                    {
                        Position.x--;
                    }
                    if (yOffset == 1 || (xOffset == 1 && yOffset == 0))
                    {
                        Position.y--;
                    }
                    break;
                case Direction.DR:
                    if (xOffset == -1 || (xOffset == 0 && yOffset == 1))
                    {
                        Position.x++;
                    }
                    if (yOffset == 1 || (xOffset == -1 && yOffset == 0))
                    {
                        Position.y--;
                    }
                    break;
            }
            return Position;
        }
    }

    internal class Position : IEquatable<Position>
    {
        public int x { get; set; }
        public int y { get; set; }
        public Position(int x, int y)
        {
            this.x = x;
            this.y = y;
        }

        public override int GetHashCode()
        {
            return x ^ y.GetHashCode();
        }

        public override bool Equals(object pos)
        {
            return base.Equals(pos as Position);
        }

        public bool Equals(Position pos)
        {
            return x == pos.x && y == pos.y;
        }

        public Direction GetDirectionTo(Position pos)
        {
            if (this.Equals(pos))
            {
                return Direction.None;
            }
            Direction yDir = Direction.None;
            Direction xDir = Direction.None;

            int xOffset = pos.x - x;
            int yOffset = pos.y - y;
            switch (xOffset)
            {
                case -1:
                    xDir = Direction.L;
                    break;
                case 0:
                    xDir = Direction.None;
                    break;
                case 1:
                    xDir = Direction.R;
                    break;
                default:
                    break;
            }
            switch (yOffset)
            {
                case -1:
                    yDir = Direction.D;
                    break;
                case 0:
                    yDir = Direction.None;
                    break;
                case 1:
                    yDir = Direction.U;
                    break;
                default:
                    break;
            }
            if (xDir != Direction.None && yDir != Direction.None)
            {
                return (Direction)((int)xDir + (int)yDir);
            }
            else if (xDir == Direction.None && yDir != Direction.None)
            {
                return yDir;
            }
            else if (xDir != Direction.None && yDir == Direction.None)
            {
                return xDir;
            }
            return Direction.None;
        }
    
        public Position GetCopy()
        {
            return new Position(x, y);
        }

    }

    internal class PositionComparer : IEqualityComparer<Position>
    {
        public bool Equals(Position x, Position y)
        {
            return x.x == y.x && x.y == y.y;
        }

        public int GetHashCode(Position obj)
        {
            return obj.x ^ obj.y.GetHashCode();
        }
    }
}
