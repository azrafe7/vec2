package shared.math
{
	import flash.geom.Point;
	
    /**
     * A 2D Vector class to perform constant operations. 																				<p></p>
	 * 
	 * Use this class to make sure that objects stay const, e.g.:
     * public function getPos():Vec2Const { return _pos; } // _pos is not allowed to change outside (cannot assing to its x and y)		<p></p>
     *
     * Many methods have a postfix "XY" - this allows you to operate on the components directly i.e.
     * instead of writing add(new Vec2(1, 2)) you can directly write addXY(1, 2);														<p></p>
     *
     * For performance reasons I am not using an interface for read only specification since internally it should be possible
     * to use direct access to x and y. Externally x and y is obtained via getters which are a bit slower than direct access of
     * a public variable. I suggest you stick with this during development. If there is a bottleneck you can just remove the get
     * accessors and directly expose _x and _y (rename it to x and replace all _x and _y to this.x, this.y internally).					<p></p>
     *
     * Notes:																															<p></p>
	 * 
	 * 		Uses Vec2Const.Epsilon as max error in comparisons.																			<p></p>
	 * 		
     *
	 * Original work by playchilla, slightly reworked by azrafe7.																		<p></p>
	 * 
     * License: Use it as you wish and if you like it - link back!
	 * 
	 * @see http://www.playchilla.com/vector-2d-for-as3
	 * @see https://github.com/azrafe7/vec2
	 * 
     * @author playchilla.com
     * @author azrafe7
     */
    public class Vec2Const
    {
        /** Constant to convert from radians to degrees */
		public static const RAD2DEG:Number = 180 / Math.PI;

        /** Zero vector */
		public static const Zero:Vec2Const = new Vec2Const;
        
		/** Epsilon (maximum error for comparisons) */
		public static const Epsilon:Number = 0.0000001;
		
		/** Epsilon squared */
        public static const EpsilonSqr:Number = Epsilon * Epsilon;
 
		/** X component (read-only) */
        public function get x():Number { return _x; }
		
		/** Y component (read-only) */
        public function get y():Number { return _y; }
 
		
		/** @private */
		internal var _x:Number;

		/** @private */
        internal var _y:Number;
 
        
		public function Vec2Const(x:Number = 0, y:Number = 0)
        {
            _x = x;
            _y = y;
        }
 
		/** Returns a new Vec2, replica of this instance */
        public function clone():Vec2 { return Vec2.getNew(_x, _y); }
 
		
		
		/** Adds "pos" vector (returns a new Vec2) */
        public function add(pos:Vec2Const):Vec2 { return Vec2.getNew(_x + pos._x, _y + pos._y); }

		/** Adds ("x", "y") (returns a new Vec2) */
        public function addXY(x:Number, y:Number):Vec2 { return Vec2.getNew(_x + x, _y + y); }
 
		/** Subtracts "pos" vector (returns a new Vec2) */
        public function sub(pos:Vec2Const):Vec2 { return Vec2.getNew(_x - pos._x, _y - pos._y); }

		/** Subtracts ("x", "y") (returns a new Vec2) */
        public function subXY(x:Number, y:Number):Vec2 { return Vec2.getNew(_x - x, _y - y); }
 
		/** Multiplies by "vec" vector (returns a new Vec2) */
        public function mul(vec:Vec2Const):Vec2 { return Vec2.getNew(_x * vec._x, _y * vec._y); }

		/** Multiplies by ("x", "y") (returns a new Vec2) */
        public function mulXY(x:Number, y:Number):Vec2 { return Vec2.getNew(_x * x, _y * y); }
 
 		/** Divides by "vec" vector (returns a new Vec2) */
        public function div(vec:Vec2Const):Vec2 { return Vec2.getNew(_x / vec._x, _y / vec._y); }

		/** Divides by ("x", "y") (returns a new Vec2) */
         public function divXY(x:Number, y:Number):Vec2 { return Vec2.getNew(_x / x, _y / y); }
 
        /** Scales by the scalar "s" (returns a new Vec2) */
        public function scale(s:Number):Vec2 { return Vec2.getNew(_x * s, _y * s); }
 
        /** Normalizes the vector (returns a new Vec2) */
        public function normalize(length:Number = 1):Vec2
        {
            const nf:Number = length / Math.sqrt(_x * _x + _y * _y);
            return Vec2.getNew(_x * nf, _y * nf);
        }
 
		
		
		/** Computes the length of the vector */
		public function length():Number { return Math.sqrt(_x * _x + _y * _y); }

		/** Computes the squared length of the vector */
        public function lengthSqr():Number { return _x * _x + _y * _y; }

		/** Computes the distance from "vec" vector */
        public function distance(vec:Vec2Const):Number
        {
            const xd:Number = _x - vec._x;
            const yd:Number = _y - vec._y;
            return Math.sqrt(xd * xd + yd * yd);
        }
		
		/** Computes the distance from ("x", "y") */
        public function distanceXY(x:Number, y:Number):Number
        {
            const xd:Number = _x - x;
            const yd:Number = _y - y;
            return Math.sqrt(xd * xd + yd * yd);
        }

		/** Computes the squared distance from "vec" vector */
        public function distanceSqr(vec:Vec2Const):Number
        {
            const xd:Number = _x - vec._x;
            const yd:Number = _y - vec._y;
            return xd * xd + yd * yd;
        }

		/** Computes the distance from ("x", "y") */
        public function distanceXYSqr(x:Number, y:Number):Number
        {
            const xd:Number = _x - x;
            const yd:Number = _y - y;
            return xd * xd + yd * yd;
        }
 
		
		
		/** Returns true if this vector's components equal the ones of "vec" */
		public function equals(vec:Vec2Const):Boolean { return _x == vec._x && _y == vec._y; }

		/** Returns true if this vector's components equal ("x", "y") */
        public function equalsXY(x:Number, y:Number):Boolean { return _x == x && _y == y; }
        
		/** Returns true if this vector is normalized */
		public function isNormalized():Boolean { return Math.abs((_x * _x + _y * _y)-1) < EpsilonSqr; }

		/** Returns true if this vector's components are 0 */
        public function isZero():Boolean { return _x == 0 && _y == 0; }
		
		/** Returns true if this vector is near "vec2" */
        public function isNear(vec2:Vec2Const):Boolean { return distanceSqr(vec2) < EpsilonSqr; }

		/** Returns true if this vector is near ("x", "y") */
		public function isNearXY(x:Number, y:Number):Boolean { return distanceXYSqr(x, y) < EpsilonSqr; }

		/** Returns true if the distance from "vec2" vector is lesser than "epsilon" */
        public function isWithin(vec2:Vec2Const, epsilon:Number):Boolean { return distanceSqr(vec2) < epsilon*epsilon; }

		/** Returns true if the distance from ("x", "y") vector is lesser than "epsilon" */
		public function isWithinXY(x:Number, y:Number, epsilon:Number):Boolean { return distanceXYSqr(x, y) < epsilon*epsilon; }

		/** Returns true if is a valid vector (has finite components) */
        public function isValid():Boolean { return !isNaN(_x) && !isNaN(_y) && isFinite(_x) && isFinite(_y); }
        
		/** Vector angle in degrees */
		public function getDegrees():Number { return getRads() * RAD2DEG; }

		/** Vector angle in radians */
        public function getRads():Number { return Math.atan2(_y, _x); }
 
		/** Angle between this vector and "vec" in radians */
        public function getRadsBetween(vec:Vec2Const):Number { return Math.atan2(x - vec.x, y - vec.y); }

		
		
		/** Computes the dot product with "vec" vector */
		public function dot(vec:Vec2Const):Number { return _x * vec._x + _y * vec._y; }

		/** Computes the dot product with "vec" vector */
        public function dotXY(x:Number, y:Number):Number { return _x * x + _y * y; }
 
        /** Computes the cross product (determinant) with "vec" */
        public function crossDet(vec:Vec2Const):Number { return _x * vec._y - _y * vec._x; }

        /** Computes the cross product (determinant) with ("x", "y")) */
        public function crossDetXY(x:Number, y:Number):Number { return _x * y - _y * x; }
 
        /** Rotates by "rads" radians (returns a new Vec2) */
        public function rotate(rads:Number):Vec2
        {
            const s:Number = Math.sin(rads);
            const c:Number = Math.cos(rads);
            return Vec2.getNew(_x * c - _y * s, _x * s + _y * c);
        }

        /** Returns a new Vec2 right-perpendicular to this vector */
        public function normalRight():Vec2 { return Vec2.getNew(-_y, _x); }
        
		/** Returns a new Vec2 left-perpendicular to this vector */
        public function normalLeft():Vec2 { return Vec2.getNew(_y, -_x); }
        
		/** Returns a new Vec2 with negated components */
		public function negate():Vec2 { return Vec2.getNew( -_x, -_y); }
 
		
		
        /** Rotates using spinor "vec" (returns a new Vec2) */
        public function rotateSpinor(vec:Vec2Const):Vec2 { return Vec2.getNew(_x * vec._x - _y * vec._y, _x * vec._y + _y * vec._x); }

		/** Gets spinor between this vector and "vec" (returns a new Vec2) */
        public function spinorBetween(vec:Vec2Const):Vec2
        {
            const d:Number = lengthSqr();
            const r:Number = (vec._x * _x + vec._y * _y) / d;
            const i:Number = (vec._y * _x - vec._x * _y) / d;
            return Vec2.getNew(r, i);
        }
 

		/** Linear interpolation from this vector to "to" vector (returns a new Vec2) */
        public function lerp(to:Vec2Const, t:Number):Vec2 { return Vec2.getNew(_x + t * (to._x - _x), _y + t * (to._y - _y)); }
 
		/** Spherical linear interpolation from this vector to "to" vector (returns a new Vec2) - not thoroughly tested */
        public function slerp(vec:Vec2Const, t:Number):Vec2
        {
            const cosTheta:Number = dot(vec);
            const theta:Number = Math.acos(cosTheta);
            const sinTheta:Number = Math.sin(theta);
            if (sinTheta <= Epsilon)
                return vec.clone();
            const w1:Number = Math.sin((1 - t) * theta) / sinTheta;
            const w2:Number = Math.sin(t * theta) / sinTheta;
            return scale(w1).add(vec.scale(w2));
        }
 
		/** Reflect this vector in plane whose normal is "normal" (returns a new Vec2) */
		public function reflect(normal:Vec2Const):Vec2
        {
            const d:Number = 2 * (_x * normal._x + _y * normal._y);
            return Vec2.getNew(_x - d * normal._x, _y - d * normal._y);
        }

		/** Returns a new Vec2 which is the minimum between this vector and "vec" (component-wise) */
        public function getMin(vec:Vec2Const):Vec2 { return Vec2.getNew(Math.min(vec._x, _x), Math.min(vec._y, _y)); }

		/** Returns a new Vec2 which is the maximum between this vector and "vec" (component-wise) */
        public function getMax(vec:Vec2Const):Vec2 { return Vec2.getNew(Math.max(vec._x, _x), Math.max(vec._y, _y)); }

		
		
		/** Creates an AS3 Point from this vector */
		public function toPoint():Point 
		{
			return new Point(_x, _y);
		}
		
        /** String representation of this vector */
        public function toString():String { return "[" + _x + ", " + _y + "]"; }
    }
}