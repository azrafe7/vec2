package shared.math
{
    /**
     * A "mutable" 2D Vector class.																										<p></p>
     *
     * Due to the lack of AS3 operator overloading most methods exists with different names.											<p></p>
     * All methods that end with "Self" actually modify the object itself (including obvious ones like copy, copyXY and zero).			
     * For example v1 += v2; is written as v1.addSelf(v2);																				<p></p>
     *
     * Notes:																															<p></p>
	 * 
	 * 		There's an object pooling system in place, so if you're using a lot of Vec2 objects it might be convenient to get rid
	 * 		of no more used Vec2s by calling their dispose() method and instantiate new ones with Vec2.getNew().						<p></p>
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
    public class Vec2 extends Vec2Const
    {
		/** @private */
		protected static const POOL_INITIAL_SIZE:int = 0;
        
		/** @private */
		protected static var _pool:Vector.<Vec2> = new Vector.<Vec2>(POOL_INITIAL_SIZE);
        
        /** Zero vector */
		public static const Zero:Vec2Const = new Vec2Const;
        

		
		public function Vec2(x:Number = 0, y:Number = 0) { super(x, y); }
 
		/** X component */
        public function set x(x:Number):void { _x = x; }

		/** X component */
        public function set y(y:Number):void { _y = y; }
 
		/** Copies x and y components from "p" (where "p" is any object exposing x, y properties) */
        public function copy(p:*):Vec2
        {
            _x = p.x;
            _y = p.y;
            return this;
        }
		
		/** Copies x and y components from passed arguments */
        public function copyXY(x:Number, y:Number):Vec2
        {
            _x = x;
            _y = y;
            return this;
        }
		
		/** Sets x and y components to 0 */
        public function zero():Vec2
        {
            _x = 0;
            _y = 0;
            return this;
        }
 
		/** Adds "pos" vector */
        public function addSelf(pos:Vec2Const):Vec2
        {
            _x += pos._x;
            _y += pos._y;
            return this;
        }

		/** Adds ("x", "y") */
		public function addXYSelf(x:Number, y:Number):Vec2
        {
            _x += x;
            _y += y;
            return this;
        }
 
		/** Subtracts "pos" vector */
        public function subSelf(pos:Vec2Const):Vec2
        {
            _x -= pos._x;
            _y -= pos._y;
            return this;
        }

		/** Subtracts ("x", "y") */
        public function subXYSelf(x:Number, y:Number):Vec2
        {
            _x -= x;
            _y -= y;
            return this;
        }
 
		/** Multiplies by "vec" vector */
        public function mulSelf(vec:Vec2Const):Vec2
        {
            _x *= vec._x;
            _y *= vec._y;
            return this;
        }

		/** Multiplies by ("x", "y") */
        public function mulXYSelf(x:Number, y:Number):Vec2
        {
            _x *= x;
            _y *= y;
            return this;
        }
 
 		/** Divides by "vec" vector */
        public function divSelf(vec:Vec2Const):Vec2
        {
            _x /= vec._x;
            _y /= vec._y;
            return this;
        }

		/** Divides by ("x", "y") */
        public function divXYSelf(x:Number, y:Number):Vec2
        {
            _x /= x;
            _y /= y;
            return this;
        }
 
        /** Scales by the scalar "s" */
        public function scaleSelf(s:Number):Vec2
        {
            _x *= s;
            _y *= s;
            return this;
        }
 
        /** Normalizes the vector */
        public function normalizeSelf():Vec2
        {
            const nf:Number = 1 / Math.sqrt(_x * _x + _y * _y);
            _x *= nf;
            _y *= nf;
            return this;
        }
 
		/** Sets components converting from polar coords */
		public function fromPolarSelf(rads:Number, length:Number):Vec2 
		{
            const s:Number = Math.sin(rads);
            const c:Number = Math.cos(rads);
			_x = c * length;
			_y = s * length;
			
			return this;
		}

		
		
        /** Rotates by "rads" radians */
        public function rotateSelf(rads:Number):Vec2
        {
            const s:Number = Math.sin(rads);
            const c:Number = Math.cos(rads);
            const xr:Number = _x * c - _y * s;
            _y = _x * s + _y * c;
            _x = xr;
            return this;
        }

        /** Sets components to be right-perpendicular to this vector */
        public function normalRightSelf():Vec2
        {
            const xr:Number = _x;
            _x = -_y
            _y = xr;
            return this;
        }

		/** Sets components to be left-perpendicular to this vector */
        public function normalLeftSelf():Vec2
        {
            const xr:Number = _x;
            _x = _y
            _y = -xr;
            return this;
        }
        
		/** Negates components */
		public function negateSelf():Vec2
        {
            _x = -_x;
            _y = -_y;
            return this;
        }

	
		
        /** Rotate using spinor "vec" */
        public function rotateSpinorSelf(vec:Vec2Const):Vec2
        {
            const xr:Number = _x * vec._x - _y * vec._y;
            _y = _x * vec._y + _y * vec._x;
            _x = xr;
            return this;
        }
 
		/** Linear interpolation from this vector to "to" vector */
        public function lerpSelf(to:Vec2Const, t:Number):Vec2
        {
            _x = _x + t * (to._x - _x);
            _y = _y + t * (to._y - _y);
            return this;
        }
 
		
		/** Disposes this vector by adding it to the pool */
		public function dispose():void
		{
			_pool[_pool.length] = this;
		}

		/** Creates a Vec2 from an AS3 Point (or any "p" object exposing x, y properties) */
		public static function fromPoint(p:*):Vec2 
		{
			return Vec2.getNew(p.x, p.y);
		}

		/** Sets components converting from polar coords (returns a new Vec2) */
		public static function fromPolar(rads:Number, length:Number):Vec2 
		{
            const s:Number = Math.sin(rads);
            const c:Number = Math.cos(rads);
			return Vec2.getNew(c * length, s * length);
		}
		
        /** Swaps vectors */
		public static function swap(a:Vec2, b:Vec2):void
        {
            const x:Number = a._x;
            const y:Number = a._y;
            a._x = b._x;
            a._y = b._y;
            b._x = x;
            b._y = y;
        }
 
		/** Gets a new Vec2 (possibly from the pool) */
		public static function getNew(x:Number = 0, y:Number = 0):Vec2 
		{
			var len:int = _pool.length;
			return len ? _pool.pop().copyXY(x, y) : new Vec2(x, y);
		}
		
		/** Removes all vectors from the pool */
		public static function clearPool():void 
		{
			_pool.length = 0;
		}
    }
}
