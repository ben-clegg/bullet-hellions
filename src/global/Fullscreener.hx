package global;

import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.HXP;

/**
 * Entity to handle logic for toggling fullscreen.
 */
class Fullscreener extends Entity
{
	private var prompt:Image = new Image("graphics/fullscreen_prompt.png");
	private static inline var MARGIN:Int = 3;
	
	public function new(isVis:Bool = false) 
	{
		super();
		prompt.smooth = false;
		addGraphic(prompt);
		prompt.visible = false;
		x = MARGIN;
		y = Global.NATIVE_HEIGHT - (prompt.height + MARGIN);
		
		this.visible = isVis;
	}
	
	public function toggle():Void
	{
		if (Input.pressed(Key.TAB))
		{
			if (HXP.fullscreen)
			{
				HXP.fullscreen = false;
			}
			else
			{
				HXP.fullscreen = true;
			}
			changeRes();
		}
	}
	
	private function changeRes()
	{
		var w:Int = Math.round(HXP.stage.stageWidth);
		var h:Int = Math.round(HXP.stage.stageHeight);
		HXP.resize(w, h);
		
		HXP.screen.scaleX = HXP.stage.stageWidth / Global.NATIVE_WIDTH;
		HXP.screen.scaleY = HXP.stage.stageHeight / Global.NATIVE_HEIGHT;
	}
	
	override public function update():Void
	{
		if (Global.active)
		{
			prompt.visible = true;
		}
		toggle();
	}
}