
import java.util.HashMap;
import java.util.Iterator;

/**
 * the main program will calculate the second taxi cab number
 * @author ashiber
 */
public class TaxiCabIt implements Iterable<LongPair> {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        TaxiCabIt it = new TaxiCabIt();
        HashMap<Long, Integer> taxiMap = new HashMap<>();
        int loopCounter=0;
        int ifCounter=0;
        for (LongPair pair : it) {
            loopCounter++;
            ifCounter+=2;
            if(taxiMap.get(pair.getSum())==null){
                taxiMap.put(pair.getSum(),0);
            }
            taxiMap.put(pair.getSum(), taxiMap.get(pair.getSum()) + 1);
            if (taxiMap.get(pair.getSum()) > 1) {
                System.out.println(String.format("%d is the taxi cab number , total if's: %d , total iterations:%d", pair.getSum(),ifCounter,loopCounter));
                break;
            }

        }
    }

    @Override
    public Iterator<LongPair> iterator() {
        return new CubePairs();
    }

}
