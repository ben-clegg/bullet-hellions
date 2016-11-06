package entities;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.HXP;
import entities.transitions.FadeOut;
import global.Global;
import scenes.MainScene;
import global.Controls;
import com.haxepunk.Sfx;

/**
 * Get input from both players to select control method and start game.
 */
class ReadyPlayers extends Entity
{
	private var readyRed:Bool = false;
	private var readyBlue:Bool = false;
	
	private var addedFader:Bool = false;
	
	private var prompt:Image = new Image("graphics/start_prompt.png");
	public var flash:Image = Image.createRect(Global.NATIVE_WIDTH, Global.NATIVE_HEIGHT, 0xFFFFFF, 1);
	public static inline var FADE_FLASH_FAC:Float = 2.5;
	
	
	private var delay:Float = 0;
	
	
	private var sfxFlash:Sfx = new Sfx("audio/Flash.wav");
	private static inline var VOL:Float = 0.6;
	
	
	public function new() 
	{
		super();
		
		x = (Global.NATIVE_WIDTH / 2) - (prompt.width / 2);
		y = 186;
		prompt.smooth = false;
		prompt.visible = false;
		addGraphic(prompt);
		
		flash.relative = false;
		flash.x = 0;
		flash.y = 0;
		flash.alpha = 0;
		flash.smooth = false;
		addGraphic(flash);
		
		//layer = -2000;
		
		Controls.defineInputs();
	}
	
	override public function update():Void
	{
		if (Global.active)
		{
			if (delay < 2)
			{
				delay += HXP.elapsed;
			}
			else 
			{
				prompt.visible = true;
			}
			if((readyBlue) && (readyRed)) 
			{
				//HXP.scene = new MainScene();
				prompt.visible = false;
				if (!addedFader)
				{
					addedFader = true;
					HXP.scene.add(new FadeOut(new MainScene(), 0.1, 3));
				}
			}
			else
			{
				if (!readyRed)
				{
					if (Input.joystick(0).check(PAD_360.A_BUTTON))
					{
						readyRed = true;
						flash.alpha = 1;
						sfxFlash.play(VOL, 0, false);
					}
					if (Input.check("p1_light"))
					{
						readyRed = true;
						flash.alpha = 1;
						sfxFlash.play(VOL, 0, false);
					}
				}
				if (!readyBlue)
				{
					if (Input.joystick(1).check(PAD_360.A_BUTTON))
					{
						readyBlue = true;
						flash.alpha = 1;
						sfxFlash.play(VOL, 0, false);
					}
					if (Input.check("p2_light"))
					{
						readyBlue = true;
						flash.alpha = 1;
						sfxFlash.play(VOL, 0, false);
					}
				}
			}
			
			if (flash.alpha > 0) 
			{
				flash.alpha -= HXP.elapsed * FADE_FLASH_FAC;
			}
		}
		
	}
	
}