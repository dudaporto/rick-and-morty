import Foundation

final class Request<T: Decodable> {
    let endpoint: Endpoint
    
    init(endpoint: Endpoint) {
        self.endpoint = endpoint
    }
    
    func perform(completion: @escaping (Result<T, ApiError>) -> Void) {
        guard let url = endpoint.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(.failure(.serverError))
                return
            }
            
            guard let data = data, self.isResponseValid(response) else {
                completion(.failure(.invalidResponse))
                return
            }

            if let decodedData: T = self.decode(from: data) {
                completion(.success(decodedData))
            } else {
                completion(.failure(.decodingError))
            }
        }
        
        task.resume()
    }
    
    private func isResponseValid(_ response: URLResponse?) -> Bool {
        guard let httpResponse = response as? HTTPURLResponse else {
            return false
        }
        
        return 200..<299 ~= httpResponse.statusCode
    }
    
    private func decode<T: Decodable>(from data: Data) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            return nil
        }
    }
}
