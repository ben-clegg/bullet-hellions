package entities.bullets;
import com.haxepunk.Entity;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.tweens.misc.ColorTween;
import com.haxepunk.tweens.misc.VarTween;
import src.entities.player.Player;
import com.haxepunk.utils.Draw;
import com.haxepunk.Tween.TweenType;

/**
 * Bullet entity. 
 * Spawned as part of an attack, with initial position, angle, and player colour.
 * Collision checking with enemy player is performed by this entity.
 */
class Bullet extends Entity
{
	private var xVel:Float = 0;
	private var yVel:Float = 0;
	private var angle:Float = 0;
	
	private var speed:Float = 100;
	private var dps:Float = 1; //DPS used for bullets, as game is time based.
	
	private var enemyType:String;
	
	private static inline var X_KILL:Int = 40;
	private static inline var Y_KILL:Int = 40;
	
	private var sprBullet:Spritemap;
	
	private var redTeam:Bool = true;

	public function new(isRed:Bool, xPos:Float, yPos:Float, dirAngle:Float) 
	{
		super(xPos, yPos);
		
		//angle = dirAngle;
		
		sprBullet.smooth = false;
		sprBullet.add("red", [0], 0, false);
		sprBullet.add("blue", [1], 0, false);
		
		if (isRed)
		{
			type = "red_bullet";
			enemyType = "blue";
			sprBullet.play("red");
		}
		else {
			type = "blue_bullet";
			enemyType = "red";
			sprBullet.play("blue");
			//sprBullet.flipped = true;
		}
		
		redTeam = isRed;
		
		set_graphic(sprBullet);
		sprBullet.centerOrigin();
		
		angle = dirAngle;
	}
	
	override public function added():Void
	{
		updateAngles();
	}
	
	public function rotateSprite():Void
	{
		sprBullet.angle = (-angle * 180 / Math.PI);
	}
	
	public function updateAngles():Void
	{
		xVel = speed * Math.cos(angle);
		yVel = speed * Math.sin(angle);
	}
	
	public function doMovement():Void
	{
		var newX = x + HXP.elapsed * xVel;
		var newY = y + HXP.elapsed * yVel;
		
		checkCollision();
		
		//Now move.
		x = newX;
		y = newY;
	}
	
	private function checkCollision():Void
	{
		var e:Entity = this.collide(enemyType, x, y);
		
		if (e != null)
		{
			var p:Player = cast (e, Player);
			if (!p.invuln)
			{
				p.die();
			}
		}
	}
	
	public function uniqueModifiers():Void
	{
		//Override this to give bullet-specific attributes.
	}
	
	override public function update():Void
	{
		uniqueModifiers();
		doMovement();
		autoRemove();
	}
	
	public function getDPS():Float
	{
		return dps;
	}
	
	public function die():Void
	{
		//TODO: Add custom effects, can override to change.
		
		//Remove the bullet.
		var fader:VarTween = new VarTween(onTweenComplete, TweenType.OneShot);
		fader.tween(sprBullet, "alpha", 0, 0.15, null);
		addTween(fader, true);
		this.collidable = false;
		//HXP.scene.remove(this);
	}
	
	private function onTweenComplete(_)
	{
		HXP.scene.remove(this);
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