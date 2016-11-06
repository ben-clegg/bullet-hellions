import com.haxepunk.Engine;
import com.haxepunk.HXP;
import global.Global;
import scenes.*;

/**
 * HaxePunk engine initialisation.
 * Tested with Windows target, with HaxePunk 2.5.6 and its dependencies.
 */
class Main extends Engine
{

	override public function init()
	{
#if debug
		HXP.console.enable();
#end
		HXP.screen.scaleX = HXP.stage.stageWidth / Global.NATIVE_WIDTH;
		HXP.screen.scaleY = HXP.stage.stageHeight / Global.NATIVE_HEIGHT;
		HXP.screen.smoothing = false;
		
		HXP.scene = new TitleScene();
	}

	public static function main() 
	{ 
		new Main(854, 480, 60, false);
	}

}