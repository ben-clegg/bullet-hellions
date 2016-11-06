package entities.player;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Emitter;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.HXP;
import openfl.display.BitmapData;

/**
 * Gibs to spawn upon game over.
 */

enum Part
{
	HEAD;
	LEG;
	ARM;
}

class Gib extends Entity
{
	private static inline var GRAV:Float = 100;
	private static inline var TERM_VEL:Float = 120;
	
	private static inline var X_KILL:Int = 40;
	private static inline var Y_KILL:Int = 40;
	
	private var sprGibs:Spritemap = new Spritemap("graphics/gibs.png", 6, 6);
	
	private var xVel:Float = 0;
	private var yVel:Float = 0;
	
	private var bloodEmit:Emitter = new Emitter(new BitmapData(1, 1, true), 0, 0);
	
	public function new(xPos:Float, yPos:Float, limb:Part, isRed:Bool) 
	{
		super(xPos, yPos);
		sprGibs.smooth = false;
		sprGibs.centerOrigin();
		
		sprGibs.add("red_head", [0], 0, false);
		sprGibs.add("blue_head", [1], 0, false);
		sprGibs.add("red_leg", [2], 0, false);
		sprGibs.add("blue_leg", [3], 0, false);
		sprGibs.add("red_arm", [4], 0, false);
		sprGibs.add("blue_arm", [5], 0, false);
		
		sprGibs.play("red_head");
		
		xVel = -20 + (Math.random() * 50);
		
		var r:Float = Math.random();
		
		if (isRed)
		{
			xVel *= -1;
			switch(limb)
			{
				case HEAD: 
					sprGibs.play("red_head");
					yVel = -1 * (10 + (r * 10));
					y -= 4;
				case LEG: 
					sprGibs.play("red_leg");
					yVel = -2 + (r * 8);
					y += 4;
				default: 
					sprGibs.play("red_arm");
					yVel = -4 + (r * 8);
			}
		}
		else
		{
			sprGibs.flipped = true;
			switch(limb)
			{
				case HEAD: 
					sprGibs.play("blue_head");
					yVel = -1 * (10 + (r * 10));
					y -= 4;
				case LEG: 
					sprGibs.play("blue_leg");
					yVel = -2 + (r * 8);
					y += 4;
				default: 
					sprGibs.play("blue_arm");
					yVel = -4 + (r * 8);
			}
		}
		
		addGraphic(sprGibs);
		
		bloodEmit.newType("blood", null);
		bloodEmit.setColor("blood", 0xbd2d28, 0xbd2d28);
		bloodEmit.setAlpha("blood", 0.9, 0, null);
		bloodEmit.setMotion("blood", 0, 0, 1, 0, 0, 0, null);
		
		bloodEmit.newType("blood2", null);
		bloodEmit.setColor("blood2", 0xbd2d28, 0xbd2d28);
		bloodEmit.setAlpha("blood2", 0.9, 0, null);
		bloodEmit.setMotion("blood2", 0, 0, 4, 0, 0, 0, null);
		bloodEmit.setGravity("blood2", 9, 3);
		
		var coatColour:Int = 0xad221d;
		if (!isRed)
		{
			coatColour = 0x3e2f96;
		}
		
		bloodEmit.newType("coat", null);
		bloodEmit.setColor("coat", coatColour, coatColour);
		bloodEmit.setAlpha("coat", 0.9, 0, null);
		bloodEmit.setMotion("coat", 0, 0, 5, 0, 0, 0, null);
		bloodEmit.setGravity("coat", 9, 3);
		
		bloodEmit.relative = false;
		addGraphic(bloodEmit);
		
		for (i in 0...10)
		{
			bloodEmit.emitInCircle("blood2", x, y, 18);
		}
		for (i in 0...10)
		{
			bloodEmit.emitInCircle("coat", x, y, 14);
		}
		
	}
	
	override public function update():Void
	{
		if (yVel < TERM_VEL)
		{
			yVel += HXP.elapsed * GRAV;
		}
		
		bloodEmit.emit("blood", x, y);
		
		x += HXP.elapsed * xVel;
		y += HXP.elapsed * yVel;
		
		doRotate();
		autoRemove();
	}
	
	private function doRotate():Void
	{
		sprGibs.angle += xVel * 0.3;
	}
	
	private function autoRemove():Void
	{
		//Remove the bullet if it goes far enough off-screen.
		if (this.x < (-X_KILL))
		{
			HXP.scene.remove(this);
		}
		if (this.x > ((HXP.screen.width) + X_KILL))
		{
			HXP.scene.remove(this);
		}
		if (this.y < (-Y_KILL))
		{
			HXP.scene.remove(this);
		}
		if (this.y > ((HXP.screen.height) + Y_KILL))
		{
			HXP.scene.remove(this);
		}
	}
}