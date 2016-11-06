package entities;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.tweens.motion.LinearMotion;
import com.haxepunk.tweens.motion.LinearPath;
import com.haxepunk.Tween.TweenType; 
import global.Global;
import com.haxepunk.utils.Ease;
import com.haxepunk.HXP;

/**
 * Countdown from 3 to 1.
 * Use LinearPath tween.
 * Moves from right to left of screen, tweened so faster at edges.
 * Slower, more readable at centre.
 * Could also try fading in just right of centre, moving to just left of centre, fade out.
 * Change graphic after each cycle.
 */
class Countdown extends Entity
{
	
	private var sprCount:Spritemap = new Spritemap("graphics/countdown.png", 32, 64);
	private var mover:LinearMotion;
	
	private var currentNum:Int = 3;
	
	private var startX:Float = Global.NATIVE_WIDTH + 40;
	private var endX:Float = -40;
	
	private var h:Float = (Global.NATIVE_HEIGHT / 2) - 16;
	
	public function new() 
	{
		super(100, 100);
		
		mover = new LinearMotion(finishedPath, TweenType.Persist);
		
		sprCount.smooth = false;
		sprCount.add("3", [0], 0, false);
		sprCount.add("2", [1], 0, false);
		sprCount.add("1", [2], 0, false);
		
		sprCount.play("3");
		
		addGraphic(sprCount);
		sprCount.centerOrigin();
		layer = -1100;
		
		mover.setMotion(startX, h, endX, h, 1, null);
		
		Global.started = false;
		
		addTween(mover, true);
		//mover.start();
		
	}
	
	override public function update():Void
	{
		x = mover.x;
		y = mover.y;
	}
	
	private function finishedPath(_):Void
	{
		currentNum --;
		if ((currentNum > 0) && (currentNum <= 3))
		{
			//sprCount.play(Std.string(currentNum));
			switch(currentNum)
			{
				case 3: sprCount.play("3");
				case 2: sprCount.play("2");
				case 1: sprCount.play("1");
				default: sprCount.visible = false;
			}
			mover.start();
		}
		else
		{
			Global.active = true;
			Global.started = true;
			HXP.scene.remove(this);
		}
	}
} 