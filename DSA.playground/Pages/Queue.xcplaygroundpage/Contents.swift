import Foundation

/**
 * Queue errors
 */
enum QueueErrors: Error {
    case queueFull
}

/**
 * Queue implementation
 */
struct Queue<T> {
    private var queue: [T]
    private let size: Int
    
    /**
     * Initialize queue
     */
    init(size: Int) {
        queue = []
        self.size = size
    }
    
    /**
     * Check if queue is empty
     */
    var isEmpty: Bool  {
        return queue.count == 0
    }
    
    /**
     * Check if queue is full
     */
    var isFull: Bool {
        return queue.count == size
    }
    
    /**
     * Add to queue
     */
    mutating func enqueue(_ value: T) throws {
        if (isFull) {
            throw QueueErrors.queueFull
        }
        queue.append(value)
    }
    
    /**
     * Remove from queue
     */
    mutating func dequeue() -> T? {
        if (isEmpty) {
            return nil
        }
        
        return queue.removeFirst()
    }
    
    /**
     * Peek at first item in queue
     */
    var peek:T? {
        return queue.first
    }
}

/**
 * ---------------------------------------------------------------------------------------
 * Queue usage example
 * ---------------------------------------------------------------------------------------
 */
var queue = Queue<Int>(size: 5)

// Check initial states
assert(queue.dequeue() == nil)
assert(queue.peek == nil)
assert(queue.isEmpty == true)
assert(queue.isFull == false)

// Push values to stack
try queue.enqueue(5)
try queue.enqueue(10)
try queue.enqueue(4)
try queue.enqueue(2)

// Check state after pushes
assert(queue.isEmpty == false)
assert(queue.isFull == false)

// Check peek
if let peekValue = queue.peek {
    assert(peekValue == 5)
} else {
    assert(false)
}

// Check pop
if let popValue = queue.dequeue(), let peekValue = queue.peek {
    assert(popValue == 5)
    assert(peekValue == 10)
} else {
    assert(false)
}

// Check is full
try queue.enqueue(3)
try queue.enqueue(11)
assert(queue.isFull == true)

// Check push to full stack
do {
    try queue.enqueue(15)
} catch QueueErrors.queueFull {
    assert(true)
} catch {
    assert(false)
}
