using Math;
using MathUtil;

class MathUtil
{

    public static function point_on_circle(center_x:Float, center_y:Float, radius:Float, angle:Float):{x:Float,y:Float}
    {
        return {
            x: center_x + radius * angle.degrees_to_radians().cos(),
            y: center_y + radius * angle.degrees_to_radians().sin()
        }
    }

    public static function degrees_to_radians(angle:Float):Float
    {
        return angle * (Math.PI / 180);
    }

}