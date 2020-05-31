
import java.util.Iterator;

/**
 * iterator of cubes.
 * @author ashiber
 */
public class Cube  implements Iterator<Long>{
    private Long i;
    public Cube(Long init){
        i=init;
    }
    
    @Override
    public boolean hasNext() {
        return i<=Math.cbrt(Long.MAX_VALUE);
    }

    @Override
    public Long next() {
        long temp= getCube();
        i++;
        return temp;
    }

    @Override
    public void remove() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public long getCube(){
    return i*i*i;
    
    }
    
}
