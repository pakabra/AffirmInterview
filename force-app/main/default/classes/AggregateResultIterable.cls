public class AggregateResultIterable implements Iterable<AggregateResult> {
    private String query;
    
    public AggregateResultIterable(String soql){
        query = soql;
    }
    
    
    public Iterator<AggregateResult> Iterator(){
        return new AggregateResultIterator(query);
    }
}