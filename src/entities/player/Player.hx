package src.entities.player;
import attacks.Attack;
import attacks.*;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.Sfx;
import com.haxepunk.utils.Input;
import com.haxepunk.HXP;
import com.haxepunk.utils.Joystick;
import com.haxepunk.utils.Joystick.XBOX_GAMEPAD;
import entities.HitStop;
import entities.player.Gib;
import entities.player.LifeDisplay;
import entities.transitions.FadeOut;
import global.Controls.PAD_360;
import com.haxepunk.utils.Key;
import entities.bullets.Bullet;
import global.Global;
import scenes.TitleScene;
/**
 * Player entity. Extended for each individual Player.
 */
class Player extends Entity
{
	//Variable definitions.
	private var sprPlayer:Spritemap;
	
	private var xVelBase:Float = 0;
	private var yVelBase:Float = 0;
	private static inline var SPEED:Int = 110;
	private static inline var FOCUS_SLOW_FAC:Float = 0.5;
	
	private var focused:Bool = false;
	private var firingLight:Bool = false;
	private var firingMedium:Bool = false;
	private var firingStrong:Bool = false;
	
	private var reloaded:Bool = true;
	private var relTime:Float = 0;
	
	private var inpUp:String;
	private var inpDown:String;
	private var inpLeft:String;
	private var inpRight:String;
	private var inpFocus:String;
	private var inpLight:String;
	private var inpMedium:String;
	private var inpStrong:String;
	
	private var minX:Int;
	private var maxX:Int;
	private var minY:Int;
	private var maxY:Int;
	private var startX:Float;
	private var startY:Float;
	
	private var gamepad:Joystick;
	private static inline var DEADZONE:Float = 0.4;	
	private static inline var TRIG_DEADZONE:Float = 0.0;	
	
	private var lives:Int = 5;
	private var hp:Float = 100;
	private static inline var MAX_HP:Float = 100;
	
	public var invuln:Bool = false;
	private var invTime:Float = 0;
	private static var MAX_INVLUN_TIME:Float = 1.6; //Max. invlun time, in seconds.
	
	private var enemyType:String = "not set";
	private var isRed:Bool = true;
	
	//Attacks
	//TODO: Change to actual attacks.
	private var attLight:Attack;
	private var attMedium:Attack;
	private var attStrong:Attack;
	private var attLightFocus:Attack;
	private var attMediumFocus:Attack;
	private var attStrongFocus:Attack;
	
	private var lifeCounter:LifeDisplay;
	private var lifeY:Int = Global.NATIVE_HEIGHT - 16;
	private var lifeOff:Int = 16;
	
	private var sprAttack:Spritemap = new Spritemap("graphics/attack.png", 16, 16);
	
	private var killed:Bool = false;
	
	private var sfxHit:Sfx = new Sfx("audio/Hit.wav");
	private var sfxGG:Sfx = new Sfx("audio/Death.wav");
	
	public function new(startingLives:Int, xPos:Int, yPos:Int, xMin:Int, xMax:Int, yMin:Int, yMax:Int) 
	{
		super(xPos, yPos);
		x = startX = xPos;
		y = startY = yPos;
		
		minX = xMin;
		maxX = xMax;
		minY = yMin;
		maxY = yMax;
		
		lives = startingLives;
		
		hp = MAX_HP;
		
	}
	override public function added():Void
	{
		//Set up players sprite.
		sprPlayer.add("idle", [0, 1, 2, 1], 6, true);
		sprPlayer.add("idle_alt", [1, 0, 1, 2], 6, true);
		sprPlayer.add("spawning", [3, 4, 5, 4], 6, true);
		sprPlayer.smooth = false;
		
		sprPlayer.x -= 8;
		sprPlayer.y -= 8;
		set_graphic(sprPlayer);
		sprPlayer.play("idle");
		if (isRed) { sprPlayer.play("idle_alt"); }
		
		//Initialise attacks.
		attLightFocus = new AttackLightFocus(isRed);
		attLight = new AttackLight(isRed);
		attMedium = new AttackMedium(isRed);
		attMediumFocus = new AttackMediumFocus(isRed);
		attStrong = new AttackStrong(isRed);
		attStrongFocus = new AttackStrongFocus(isRed);
		
		HXP.scene.add(lifeCounter);
		
		//Set up the player's attack animation sprite.
		sprAttack.add("idle", [0], 0, false);
		sprAttack.add("l", [1, 2, 0], 15, false);
		sprAttack.add("l_f", [3, 4, 0], 10, false);
		sprAttack.add("m", [5, 6, 7, 0], 10, false);
		sprAttack.add("m_f", [8, 9, 10, 0], 10, false);
		sprAttack.add("s", [11, 12, 13, 14, 15, 14, 13, 0], 20, false);
		sprAttack.add("s_f", [16, 17, 18, 19, 18, 0], 20, false);
		
		sprAttack.smooth = false;
		sprAttack.y = -8;
		
		if (!isRed)
		{
			sprAttack.flipped = true;
			sprAttack.x = -16;
		}
		
		addGraphic(sprAttack);
	}
	
	override public function update():Void
	{
		if (Global.active) 
		{
			if (!killed)
			{
				checkSpawn();
				getInput();
				applyMovement();
				doFiring();
			}
			else
			{
				finishDeath();
			}
		}
		else
		{
			if (Global.started)
			{
				lifeCounter.vanish();
			}
			
		}
	}
	
	/**
	 * Reset to start position, give invlunerability frames.
	 */
	private function spawn():Void
	{
		sprPlayer.play("spawning");
		sprPlayer.alpha = 0.5;
		x = startX;
		y = startY;
		invTime = MAX_INVLUN_TIME;
		invuln = true; //Is invulnerable.
	}
	
	/**
	 * Make player vulnerable after a time period.
	 */
	private function checkSpawn():Void
	{
		if (invuln)
		{
			invTime -= HXP.elapsed;
			if (invTime <= 0) 
			{ 
				//No longer invulnerable.
				stopInvuln();
			}
		}
	}
	
	/**
	 * Remove player's invulnerability.
	 */
	private function stopInvuln():Void
	{
		sprPlayer.play("idle");
		invuln = false; 
		sprPlayer.alpha = 1;
	}
	
	private function getInput():Void
	{
		xVelBase = 0;
		yVelBase = 0;
		focused = false;
		firingLight = false;
		firingMedium = false;
		firingStrong = false;
		
		joypadInput(gamepad); //360 controller input
		keyboardInput();
		
		//Balance keyboard and d-pad movement to be equivalent to analog input.
		if ((Math.abs(xVelBase) == 1) && (Math.abs(yVelBase) == 1))
		{
			var semi:Float = 0.707; //sin(45degrees)
			xVelBase = xVelBase * semi;
			yVelBase = yVelBase * semi;
		}
		
	}
	
	private function joypadInput(joy:Joystick):Void
	{
		//Analogue input
		var stickX:Float = joy.getAxis(XBOX_GAMEPAD.LEFT_ANALOGUE_X);
		var stickY:Float = joy.getAxis(XBOX_GAMEPAD.LEFT_ANALOGUE_Y);
		if (Math.abs(stickX) > DEADZONE) { xVelBase = stickX; }
		if (Math.abs(stickY) > DEADZONE) { yVelBase = stickY; }
		
		//D-Pad input
		if (gamepad.hat.x < 0) { xVelBase = -1; }
		else if (gamepad.hat.x > 0) { xVelBase = 1; }
		if (gamepad.hat.y < 0) { yVelBase = -1; }
		else if (gamepad.hat.y > 0) { yVelBase = 1; }
		
		//Focus
		if (joy.check(PAD_360.LB_BUTTON)) { focused = true; }
		if (joy.getAxis(PAD_360.LEFT_TRIGGER) > TRIG_DEADZONE) { focused = true; }
		if (joy.getAxis(PAD_360.RIGHT_TRIGGER) > TRIG_DEADZONE) { focused = true; }
		
		//TODO: Fix attack (letter) buttons.
		if (joy.check(PAD_360.A_BUTTON)) { firingLight = true; }
		if (joy.check(PAD_360.RB_BUTTON)) { firingLight = true; }
		if (joy.check(PAD_360.X_BUTTON)) { firingMedium = true; }
		if (joy.check(PAD_360.Y_BUTTON)) { firingStrong = true; }
	}
	
	private function keyboardInput():Void
	{
		//Check movement keys
		if (Input.check(inpUp))
		{
			yVelBase = -1;
		}
		else if (Input.check(inpDown))
		{
			yVelBase = 1;
		}
		if (Input.check(inpLeft))
		{
			xVelBase = -1;
		}
		else if (Input.check(inpRight))
		{
			xVelBase = 1;
		}
		
		//Focus key
		if (Input.check(inpFocus))
		{
			focused = true;
		}
		
		//Attacks
		if (Input.check(inpLight))
		{
			firingLight = true;
		}
		if (Input.check(inpMedium))
		{
			firingMedium = true;
		}
		if (Input.check(inpStrong))
		{
			firingStrong = true;
		}
	}
	
	/**
	 * Move the player.
	 */
	private function applyMovement():Void
	{
		var xMov:Float = 0;
		var yMov:Float = 0;
		
		if (focused)
		{
			//Focused movement
			xMov = SPEED * HXP.elapsed * xVelBase * FOCUS_SLOW_FAC;
			yMov = SPEED * HXP.elapsed * yVelBase * FOCUS_SLOW_FAC;
		}
		else
		{
			//Non-focused movement
			xMov = SPEED * HXP.elapsed * xVelBase;
			yMov = SPEED * HXP.elapsed * yVelBase;
		}
		
		x += xMov;
		y += yMov;
		
		//Boundaries
		if (y < minY)
		{
			y = minY;
		}
		else if (y > maxY)
		{
			y = maxY;
		}
		if (x < minX)
		{
			x = minX;
		}
		else if (x > maxX)
		{
			x = maxX;
		}
	}
	
	private function doReload():Void
	{
		if (!reloaded)
		{
			relTime -= HXP.elapsed;
			
			if (relTime <= 0)
			{
				reloaded = true;
			}
		}
	}
	
	private function startReload(startTime:Float):Void
	{
		relTime = startTime;
		reloaded = false;
	}
	
	private function doFiring():Void
	{
		//Do attacks, strong attacks take precendence over light.
		
		//Reload first.
		doReload();
		
		if (reloaded)
		{
			//Change origin of attacks.
			var aX:Float = x + 2;
			if (!isRed)
			{
				aX = this.x - 2;
			}
			var aY:Float = y;
			
			if (focused)
			{
				//Focused attacks - more accurate, less damage?
				if (firingStrong)
				{
					makeAttack(attStrongFocus, "s_f", aX, aY);
				}
				else if (firingMedium)
				{
					makeAttack(attMediumFocus, "m_f", aX, aY);
				}
				else if (firingLight)
				{
					makeAttack(attLightFocus, "l_f", aX, aY);
				}
			}
			else
			{
				//Non-focused attacks
				if (firingStrong)
				{
					makeAttack(attStrong, "s", aX, aY);
				}
				else if (firingMedium)
				{
					makeAttack(attMedium, "m", aX, aY);
				}
				else if (firingLight)
				{
					makeAttack(attLight, "l", aX, aY);
				}
			}
		}
	}
	
	/**
	 * Start an attack.
	 * @param	att		Attack to use.
	 * @param	anim	Attack animation sprite sequence to use.
	 * @param	attX	X Position to place attack origin.
	 * @param	attY	Y Position to place attack origin.
	 */
	private function makeAttack(att:Attack, anim:String, attX:Float, attY:Float)
	{
		att.fire(attX, attY);
		startReload(att.maxRelTime);
		sprAttack.play(anim, true);
		stopInvuln();
	}
	
	public function die():Void
	{
		killed = true;
		sfxHit.play(1, 0, false);
		HXP.scene.add(new HitStop());
	}
	
	private function finishDeath():Void
	{
		killed = false;
		
		//Remove all bullets.
		var rBullets:List<Entity> = HXP.scene.entitiesForType("red_bullet");
		if (! (rBullets == null)) 
		{
			for (e in rBullets) 
			{
				var b:Bullet = cast (e, Bullet);
				b.die();
			}
		}
		var bBullets:List<Entity> = HXP.scene.entitiesForType("blue_bullet");
		if (! (bBullets == null)) 
		{
			for (e in bBullets) 
			{
				var b:Bullet = cast (e, Bullet);
				b.die();
			}
		}
		
		HXP.screen.shake(20, 1); //Shake screen.		
		
		lives --; //Player loses life.
		lifeCounter.loseLife();
		if (lives <= 0)
		{
			//Game over here, victory to other player
			sfxGG.play(1, 0, false);
			
			//Create gibs
			HXP.scene.add(new Gib(x, y, HEAD, isRed));
			HXP.scene.add(new Gib(x, y, ARM, isRed));
			HXP.scene.add(new Gib(x, y, ARM, isRed));
			HXP.scene.add(new Gib(x, y, LEG, isRed));
			HXP.scene.add(new Gib(x, y, LEG, isRed));
			
			sprPlayer.visible = false;
			sprAttack.visible = false;
			
			Global.active = false;
			
			//Add fade out to title, with delay to make result more clear
			HXP.scene.add(new FadeOut(new TitleScene(), 2, 6));
		}
		else
		{
			spawn();
		}
	}
	
}