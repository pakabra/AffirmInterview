public class AggregateResultIterator implements Iterator<AggregateResult> {
    
    AggregateResult [] results {get;set;}
    
    // tracks which result item is returned
    
    Integer index {get; set;}
    
    
    
    public AggregateResultIterator(String query) {
        index = 0;
        results = Database.query(query);
    }
    
    
    public boolean hasNext(){
        return results != null && !results.isEmpty() && index < results.size();
    }
    
    
    public AggregateResult next(){
        return results[index++];
    }
}