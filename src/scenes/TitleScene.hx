package scenes;
import com.haxepunk.Scene;
import entities.backgrounds.BgBack;
import entities.backgrounds.BgFront;
import entities.ReadyPlayers;
import entities.Title;
import entities.transitions.FadeIn;
import global.Fullscreener;
import global.Global;


/**
 * Attract / title scene.
 */
class TitleScene extends Scene
{

	public function new() 
	{
		super();
		
		add(new FadeIn());
		
		add(new Fullscreener(false)); //Change to true to enable.
		
		add(new BgFront());
		add(new BgBack());
		
		add(new ReadyPlayers());
	}
	
	override public function begin()
	{
		
		Global.active = false;
		add(new Title());
	}
	
}