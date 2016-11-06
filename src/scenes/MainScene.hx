package scenes;

import entities.backgrounds.BgBack;
import entities.backgrounds.BgFront;
import com.haxepunk.Scene;
import entities.Countdown;
import entities.player.Blue;
import entities.player.Red;
import entities.transitions.FadeIn;
import src.entities.player.Player;
import com.haxepunk.HXP;
import global.Controls;
import global.Fullscreener;
import global.Global;

/**
 * Main Game scene.
 */
class MainScene extends Scene
{
	public override function begin()
	{
		add(new FadeIn());
		add(new Fullscreener());
		
		add(new Countdown());
		
		Controls.defineInputs();
		
		Global.active = false;
		
		var screenWidth:Int = Math.round(Global.NATIVE_WIDTH);
		var midPoint:Int = Math.round(screenWidth / 2);
		var noMansZone:Int = 10;
		var scTop:Int = 20;
		var scBot:Int = Math.round(Global.NATIVE_HEIGHT) - 20;
		var hBord:Int = 20;
		var startLives:Int = 5;
		
		//Players
		var pRed:Player = new Red(startLives, Math.round(midPoint / 2), 100, hBord, (midPoint - noMansZone), scTop, scBot);
		var pBlue:Player = new Blue(startLives, Math.round(midPoint / 2) + midPoint, 100, (midPoint + noMansZone), screenWidth - hBord, scTop, scBot);
		add(pRed);
		add(pBlue);
		
		//Backgrounds
		add(new BgFront());
		add(new BgBack());
		
	}
	
}