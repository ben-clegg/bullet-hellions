package entities;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Spritemap;
import com.haxepunk.Sfx;
import global.Global;
import com.haxepunk.HXP;

/**
 * The Title entity to be shown on the attract screen.
 */

enum Status
{
	FADING_IN;
	FLASH;
	READY;
}
	
class Title extends Entity
{
	public var title:Spritemap = new Spritemap("graphics/title_main.png", 400, 128);
	public var flash:Image = Image.createRect(Global.NATIVE_WIDTH, Global.NATIVE_HEIGHT, 0xFFFFFF, 1);
	
	public static inline var FADE_IN_FAC:Int = 1;
	public static inline var FADE_FLASH_FAC:Int = 2;
	
	private var current:Status;
	
	private var sfxFlash:Sfx = new Sfx("audio/Flash.wav");
	
	public function new() 
	{
		super();
		
		title.smooth = false;
		
		title.add("white", [0], 0, false);
		title.add("colour", [1], 0, false);
		title.play("white");
		title.alpha = 0;
		addGraphic(title);
		
		flash.relative = false;
		flash.x = 0;
		flash.y = 0;
		
		x = (Global.NATIVE_WIDTH / 2) - (title.width / 2);
		y = 24;
		
		current = FADING_IN;
	}
	
	override public function update():Void
	{
		switch(current)
		{
			case FADING_IN:
				if (title.alpha < 1) 
				{
					title.alpha += HXP.elapsed * FADE_IN_FAC;
				}
				else 
				{
					title.alpha = 1;
					current = FLASH;
					addGraphic(flash);
					sfxFlash.play(1, 0, false);
					title.play("colour");
					Global.active = true;
				};
			case FLASH:
				if (flash.alpha > 0) 
				{
					flash.alpha -= HXP.elapsed * FADE_FLASH_FAC;
				}
				else 
				{
					flash.visible = false;
				};
			default:
				//Do nothing.
		}
	}
	
}