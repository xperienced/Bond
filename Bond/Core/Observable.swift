//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Srdan Rasic (@srdanrasic)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

/// A type that can be used to mimic a variable or a property
/// that enables observation of its change.
public final class Observable<Wrapped>: EventProducer<Wrapped> {
  
  /// The underlying sink to dispatch events to.
  private var capturedSink: Sink! = nil

  /// The encapsulated value.
  public var value: Wrapped {
    get {
      // We've created buffer of size 1 and we own it so it is safe
      // to force unwrap both the buffer and the last element.
      return replayBuffer!.last!
    }
    set {
      next(newValue)
    }
  }
  
  /// Creates a observable with the given initial value.
  public init(_ value: Wrapped) {
    
    var capturedSink: Sink! = nil
    super.init(replayLength: 1, lifecycle: .Normal) { sink in
      capturedSink = sink
      return nil
    }
    
    self.capturedSink = capturedSink
    self.capturedSink(value)
  }
  
  public override func next(event: Wrapped) {
    super.next(event)
  }
}