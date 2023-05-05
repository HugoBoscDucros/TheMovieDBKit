@available(iOS 13.0.0, *)
public class TheMovieDBKit {
    
    public var api:API

    public init(apiKey:String) {
        self.api = API(apiKey: apiKey)
    }
}
