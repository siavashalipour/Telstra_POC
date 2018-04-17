# Telstra_POC
Telstra POC code test

**Some Notes:**

1. No Use of Storyboard or .xib as requested
2. developed using MVVM pattern and RxSwift and RxCocoa
3. Services implementation is very simple and it has been developed just for this test
4. image caching is via [SDWebImage](https://github.com/rs/SDWebImage/blob/master/Docs/HowToUse.md) pod. (why reinvent the wheel) 
5. The observable pattern used is very basic and simple and it is not to be consider as a real world best solution
6. JSON encoding has been achieved via Swift 4 Decodable 
7. there were some serialisation issue regarding to the format of the json coming from the url which has been address in the code. Please see the comment in the `DropboxApiClient.swift`
