import motion.Actuate;
import h2d.Interactive;
import h2d.Graphics;

class DecksBtn extends Graphics
{

    static var width:Int = 32;
    static var height:Int = 40;

    public function new()
    {
        super(Main.i.scene);
        smooth = true;

		lineStyle(4, 0xFF0000);
		drawRect(0 - width/2, 8 - height/2, width - 8, height - 8);
		lineTo(0 - width/2, 8 - height/2);
		lineTo(8 - width/2, 0 - height/2);
		lineTo(width - width/2, 0 - height/2);
		lineTo(width - width/2, height - 8 - height/2);
		lineTo(width - 8 - width/2, height - height/2);
        
        setPosition(Main.i.scene.width - PADDING - width - width/2, 80);
        setScale(0.5);
        
        var int = new Interactive(width, height, this);
		int.setPosition(-width/2, -height/2);
        int.onClick = (e) -> click();
        int.onOver = (e) -> scale_to(0.6);
        int.onOut = (e) -> scale_to(0.5);
    }

    function click()
    {
		if (alpha == 0) return;
        setScale(0.75);
        scale_to(0.6);
		new DecksPopup();
    }
    
    function scale_to(v:Float) Actuate.tween(this, 0.2, { scaleX: v, scaleY: v });

}