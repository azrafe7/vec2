package  
{
	import shared.math.Vec2;
	
	// Test basic Vec2 functionalities
	public class Vec2Test 
	{
		public static function testBasic():void
		{
			var v1:Vec2 = new Vec2;
			assert(v1.isZero());
			 
			// add sub mul div
			v1.addSelf(new Vec2(1, 2)).subSelf(new Vec2(3, 4)).mulSelf(new Vec2(2, -3)).divSelf(new Vec2(2, 3));
			assert(v1.isNearXY( -2, 2));
		 
			v1 = new Vec2().addXY(1, 2).subXY(3, 4).mulXY(2, -3).divXY(2, 3);
			assert(v1.isNearXY( -2, 2));
		 
			v1 = new Vec2().add(new Vec2(1, 2)).sub(new Vec2(3, 4)).mul(new Vec2(2, -3)).div(new Vec2(2, 3));
			assert(v1.isNearXY( -2, 2));
			 
			// scale
			assert(v1.copyXY(1, 2).scaleSelf(3).equalsXY(3, 6));
			assert(v1.copyXY(1, 2).scale(3).equalsXY(3, 6));
			 
			// normalize
			assert(v1.copyXY(10, 0).normalizeSelf().equalsXY(1, 0));
			assert(v1.copyXY(0, 10).normalizeSelf().equalsXY(0, 1));
			assert(v1.copyXY(1, 1).normalizeSelf().isWithinXY(0.7, 0.7, 0.1));
			assert(v1.isNormalized());
			assert(v1.copyXY(1, 1).normalize().isWithinXY(0.7, 0.7, 0.1));
			trace(v1.normalize(3).length());
			assert(!v1.isNormalized());
			 
			// rotate
			assert(v1.copyXY(1, 0).normalLeft().equalsXY(0, -1));
			assert(v1.copyXY(1, 0).normalRight().equalsXY(0, 1));
			assert(v1.copyXY(1, 0).normalLeftSelf().equalsXY(0, -1));
			assert(v1.copyXY(1, 0).normalRightSelf().equalsXY(0, 1));
			assert(v1.copyXY(-13, 3).negate().equalsXY(13, -3));
			assert(v1.copyXY( -13, 3).negateSelf().equalsXY(13, -3));
			assert(v1.copyXY(1, 0).rotate(Math.PI * 0.5).isNearXY(0, 1));
			assert(v1.copyXY(1, 0).rotateSelf(Math.PI * 0.5).isNearXY(0, 1));
			 
			// swap
			var v2:Vec2 = new Vec2(3, 4);
			Vec2.swap(v1.copyXY(12, 13), v2);
			assert(v1.equalsXY(3, 4));
			assert(v2.equalsXY(12, 13));
			 
			// distance
			assert(v1.lengthSqr() == 25);
			assert(v1.distance(new Vec2(3, 4)) == 0);
			assert(v1.distance(new Vec2(3, 0)) == 4);
			assert(v1.distanceXY(3, 0) == 4);
			 
			// dot
			assert(v1.copyXY(1, 0).dotXY(1, 0) == 1);
			assert(v1.copyXY(1, 0).dotXY( -1, 0) == -1);
			assert(v1.copyXY(1, 0).dotXY(0, 1) == 0);
			assert(v1.copyXY(1, 1).normalize().dot(v1.normalLeft()) == 0);
		 
			// cross
			assert(v1.copyXY(1, 0).crossDetXY(1, 0) == 0)
			assert(v1.copyXY(1, 0).crossDetXY(0, -1) == -1)
			assert(v1.copyXY(1, 0).crossDetXY(0, 1) == 1)
			assert(v1.copyXY(1, 0).crossDet(new Vec2(1, 0)) == 0)
			assert(v1.copyXY(1, 0).crossDet(new Vec2(0, -1)) == -1)
			assert(v1.copyXY(1, 0).crossDet(new Vec2(0, 1)) == 1)
			 
			// lerp
			assert(v1.copyXY(1, 0).lerp(new Vec2(0, -1), 0.5).isWithinXY(0.5, -0.5, 0.01));
			assert(v1.copyXY(1, 0).lerp(new Vec2(-1, 0), 0.5).isWithinXY(0, 0, 0.01));
			assert(v1.copyXY(1, 0).lerpSelf(new Vec2(0, -1), 0.5).isWithinXY(0.5, -0.5, 0.01));
			assert(v1.copyXY(1, 0).lerpSelf(new Vec2(-1, 0), 0.5).isWithinXY(0, 0, 0.01));
		 
			// slerp (need more testing)
			assert(v1.copyXY(1, 0).slerp(new Vec2(0, -1), 0.5).isWithinXY(0.7, -0.7, 0.1));

		}
		
		public static function assert(condition:Boolean):void 
		{
			if (!condition) throw new Error("Assert error!");
		}
	}
}